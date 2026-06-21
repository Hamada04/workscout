const express = require('express');
const router = express.Router();
const Notification = require('../models/Notification');
const auth = require('../middleware/auth');

// Mobile: get current user's notifications
router.get('/my-notifications', auth, async (req, res, next) => {
    try {
        const notifications = await Notification.find({ userId: req.user._id })
            .sort({ createdAt: -1 });
        res.json(notifications);
    } catch (err) {
        next(err);
    }
});

module.exports = router;
