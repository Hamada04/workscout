const express = require('express');
const router = express.Router();
const OfferLetter = require('../models/OfferLetter');
const Notification = require('../models/Notification');
const adminAuth = require('../middleware/adminAuth');

router.get('/', adminAuth, async (req, res) => {
    try {
        const { page = 1, limit = 10, status = '' } = req.query;
        
        const query = {};
        if (status) query.status = status;

        const total = await OfferLetter.countDocuments(query);
        const offers = await OfferLetter.find(query)
            .populate('userId', 'name email profilePic')
            .populate('jobId', 'jobTitle companyName')
            .populate('applicationId')
            .sort({ createdAt: -1 })
            .skip((page - 1) * limit)
            .limit(parseInt(limit));

        res.json({
            offers,
            total,
            page: parseInt(page),
            pages: Math.ceil(total / limit)
        });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/:id', adminAuth, async (req, res) => {
    try {
        const offer = await OfferLetter.findById(req.params.id)
            .populate('userId', 'name email profilePic')
            .populate('jobId')
            .populate('applicationId');
        
        if (!offer) return res.status(404).json({ message: 'Offer not found' });
        res.json(offer);
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.post('/create', adminAuth, async (req, res) => {
    try {
        const { userId, jobId, applicationId, salary, startDate, position, department, message, expiresInDays = 14 } = req.body;
        
        const expiresAt = new Date();
        expiresAt.setDate(expiresAt.getDate() + expiresInDays);

        const offer = new OfferLetter({
            userId,
            jobId,
            applicationId,
            salary,
            startDate,
            position,
            department,
            message,
            expiresAt
        });
        
        await offer.save();

        const notification = new Notification({
            userId,
            title: 'Job Offer Received',
            message: `You have received a job offer for the position of ${position}. Please review and respond.`,
            type: 'offer',
            relatedId: offer._id
        });
        await notification.save();

        res.status(201).json({ message: 'Offer created and sent', offer });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.put('/:id', adminAuth, async (req, res) => {
    try {
        const offer = await OfferLetter.findByIdAndUpdate(
            req.params.id,
            { $set: req.body },
            { new: true }
        );
        if (!offer) return res.status(404).json({ message: 'Offer not found' });
        res.json({ message: 'Offer updated', offer });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.put('/:id/resend', adminAuth, async (req, res) => {
    try {
        const offer = await OfferLetter.findById(req.params.id);
        if (!offer) return res.status(404).json({ message: 'Offer not found' });

        const expiresAt = new Date();
        expiresAt.setDate(expiresAt.getDate() + 14);
        offer.expiresAt = expiresAt;
        offer.status = 'sent';
        await offer.save();

        const notification = new Notification({
            userId: offer.userId,
            title: 'Job Offer Resent',
            message: `Your job offer has been resent. Please review and respond.`,
            type: 'offer',
            relatedId: offer._id
        });
        await notification.save();

        res.json({ message: 'Offer resent', offer });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.delete('/:id', adminAuth, async (req, res) => {
    try {
        const offer = await OfferLetter.findByIdAndDelete(req.params.id);
        if (!offer) return res.status(404).json({ message: 'Offer not found' });
        res.json({ message: 'Offer deleted' });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/stats/count', adminAuth, async (req, res) => {
    try {
        const total = await OfferLetter.countDocuments();
        const sent = await OfferLetter.countDocuments({ status: 'sent' });
        const accepted = await OfferLetter.countDocuments({ status: 'accepted' });
        const rejected = await OfferLetter.countDocuments({ status: 'rejected' });
        
        res.json({ total, sent, accepted, rejected });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
