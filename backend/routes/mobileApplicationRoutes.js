const express = require('express');
const router = express.Router();
const Application = require('../models/Application');
const auth = require('../middleware/auth');

// Mobile: get current user's applications
router.get('/my-applications', auth, async (req, res, next) => {
    try {
        const applications = await Application.find({ userId: req.user._id })
            .populate('jobId', 'jobTitle companyName companyLogo location jobType')
            .sort({ appliedAt: -1 });
        res.json(applications);
    } catch (err) {
        next(err);
    }
});

module.exports = router;
