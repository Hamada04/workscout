const express = require('express');
const router = express.Router();
const Application = require('../models/Application');
const Job = require('../models/Job');
const User = require('../models/User');
const adminAuth = require('../middleware/adminAuth');

router.get('/', adminAuth, async (req, res) => {
    try {
        const { page = 1, limit = 10, status = '', jobId = '', userId = '' } = req.query;
        
        const query = {};
        if (status) query.status = status;
        if (jobId) query.jobId = jobId;
        if (userId) query.userId = userId;

        const total = await Application.countDocuments(query);
        const applications = await Application.find(query)
            .populate('jobId', 'jobTitle companyName')
            .populate('userId', 'name email profilePic')
            .sort({ createdAt: -1 })
            .skip((page - 1) * limit)
            .limit(parseInt(limit));

        res.json({
            applications,
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
        const application = await Application.findById(req.params.id)
            .populate('jobId')
            .populate('userId', '-password');
        
        if (!application) return res.status(404).json({ message: 'Application not found' });
        res.json(application);
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.put('/:id/status', adminAuth, async (req, res) => {
    try {
        const { status, notes } = req.body;
        
        const application = await Application.findById(req.params.id);
        if (!application) return res.status(404).json({ message: 'Application not found' });

        application.status = status;
        if (notes) application.notes = notes;
        await application.save();

        res.json({ message: 'Status updated', application });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.delete('/:id', adminAuth, async (req, res) => {
    try {
        const application = await Application.findByIdAndDelete(req.params.id);
        if (!application) return res.status(404).json({ message: 'Application not found' });
        res.json({ message: 'Application deleted' });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/stats/count', adminAuth, async (req, res) => {
    try {
        const total = await Application.countDocuments();
        const pending = await Application.countDocuments({ status: 'pending' });
        const reviewed = await Application.countDocuments({ status: 'reviewed' });
        const interview = await Application.countDocuments({ status: 'interview' });
        const accepted = await Application.countDocuments({ status: 'accepted' });
        const rejected = await Application.countDocuments({ status: 'rejected' });
        
        res.json({ total, pending, reviewed, interview, accepted, rejected });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/job/:jobId', adminAuth, async (req, res) => {
    try {
        const applications = await Application.find({ jobId: req.params.jobId })
            .populate('userId', 'name email profilePic');
        res.json(applications);
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
