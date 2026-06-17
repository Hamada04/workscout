const express = require('express');
const router = express.Router();
const Notification = require('../models/Notification');
const User = require('../models/User');
const adminAuth = require('../middleware/adminAuth');

router.get('/', adminAuth, async (req, res, next) => {
    try {
        const { page = 1, limit = 20, isRead = '' } = req.query;
        
        const query = {};
        if (isRead !== '') query.isRead = isRead === 'true';

        const total = await Notification.countDocuments(query);
        const notifications = await Notification.find(query)
            .populate('userId', 'name email')
            .sort({ createdAt: -1 })
            .skip((page - 1) * limit)
            .limit(parseInt(limit));

        res.json({
            notifications,
            total,
            page: parseInt(page),
            pages: Math.ceil(total / limit)
        });
    } catch (err) {
        next(err);
    }
});

router.post('/send', adminAuth, async (req, res, next) => {
    try {
        const { userId, title, message, type = 'system', relatedId = null } = req.body;
        
        const notification = new Notification({
            userId,
            title,
            message,
            type,
            relatedId
        });
        
        await notification.save();
        res.status(201).json({ message: 'Notification sent', notification });
    } catch (err) {
        next(err);
    }
});

router.post('/send-all', adminAuth, async (req, res, next) => {
    try {
        const { title, message, type = 'system' } = req.body;
        
        const users = await User.find({ role: 'user' });
        const notifications = users.map(user => ({
            userId: user._id,
            title,
            message,
            type
        }));
        
        await Notification.insertMany(notifications);
        res.status(201).json({ message: `Sent to ${users.length} users` });
    } catch (err) {
        next(err);
    }
});

router.put('/:id/read', adminAuth, async (req, res, next) => {
    try {
        const notification = await Notification.findByIdAndUpdate(
            req.params.id,
            { isRead: true },
            { new: true }
        );
        if (!notification) return res.status(404).json({ message: 'Notification not found' });
        res.json(notification);
    } catch (err) {
        next(err);
    }
});

router.put('/mark-all-read', adminAuth, async (req, res, next) => {
    try {
        await Notification.updateMany({ isRead: false }, { isRead: true });
        res.json({ message: 'All notifications marked as read' });
    } catch (err) {
        next(err);
    }
});

router.delete('/:id', adminAuth, async (req, res, next) => {
    try {
        const notification = await Notification.findByIdAndDelete(req.params.id);
        if (!notification) return res.status(404).json({ message: 'Notification not found' });
        res.json({ message: 'Notification deleted' });
    } catch (err) {
        next(err);
    }
});

router.get('/stats/count', adminAuth, async (req, res, next) => {
    try {
        const total = await Notification.countDocuments();
        const unread = await Notification.countDocuments({ isRead: false });
        
        res.json({ total, unread });
    } catch (err) {
        next(err);
    }
});

module.exports = router;
