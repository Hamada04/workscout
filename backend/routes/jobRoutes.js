const express = require('express');
const Job = require('../models/Job');
const User = require('../models/User');
const adminAuth = require('../middleware/adminAuth');
const auth = require('../middleware/auth');

const publicRouter = express.Router();
const adminRouter = express.Router();

adminRouter.use(adminAuth);

// ─── Public Routes (mounted at /api/jobs) ─────────────────────────

publicRouter.get('/', async (req, res, next) => {
    try {
        const { page = 1, limit = 20, search = '', category = '' } = req.query;

        const query = {};
        if (search) {
            query.$or = [
                { jobTitle: { $regex: search, $options: 'i' } },
                { companyName: { $regex: search, $options: 'i' } }
            ];
        }
        if (category) {
            query.category = { $regex: `^${category}$`, $options: 'i' };
        }

        const total = await Job.countDocuments(query);
        const jobs = await Job.find(query)
            .sort({ createdAt: -1 })
            .skip((page - 1) * limit)
            .limit(parseInt(limit));

        res.json({
            jobs,
            total,
            page: parseInt(page),
            pages: Math.ceil(total / limit)
        });
    } catch (err) {
        next(err);
    }
});

publicRouter.get('/categories/list', async (req, res, next) => {
    try {
        const categories = await Job.distinct('category');
        res.json(categories);
    } catch (err) {
        next(err);
    }
});

// ─── Save / Unsave / Saved (auth-protected, mobile app) ────────

publicRouter.get('/saved', auth, async (req, res, next) => {
    try {
        const jobs = await Job.find({ _id: { $in: req.user.savedJobsIds } });
        res.json(jobs);
    } catch (err) {
        next(err);
    }
});

publicRouter.post('/:id/save', auth, async (req, res, next) => {
    try {
        await User.findByIdAndUpdate(
            req.user._id,
            { $addToSet: { savedJobsIds: req.params.id } }
        );
        res.json({ success: true, message: 'Job saved successfully' });
    } catch (err) {
        next(err);
    }
});

publicRouter.delete('/:id/save', auth, async (req, res, next) => {
    try {
        await User.findByIdAndUpdate(
            req.user._id,
            { $pull: { savedJobsIds: req.params.id } }
        );
        res.json({ success: true, message: 'Job unsaved successfully' });
    } catch (err) {
        next(err);
    }
});

publicRouter.get('/:id', async (req, res, next) => {
    try {
        const job = await Job.findById(req.params.id);
        if (!job) return res.status(404).json({ message: 'Job not found' });
        res.json(job);
    } catch (err) {
        next(err);
    }
});

// ─── Admin Routes (mounted at /api/admin/jobs) ────────────────────

adminRouter.get('/', async (req, res, next) => {
    try {
        const { page = 1, limit = 10, search = '', category = '' } = req.query;

        const query = {};
        if (search) {
            query.$or = [
                { jobTitle: { $regex: search, $options: 'i' } },
                { companyName: { $regex: search, $options: 'i' } }
            ];
        }
        if (category) query.category = category;

        const total = await Job.countDocuments(query);
        const jobs = await Job.find(query)
            .sort({ createdAt: -1 })
            .skip((page - 1) * limit)
            .limit(parseInt(limit));

        res.json({
            jobs,
            total,
            page: parseInt(page),
            pages: Math.ceil(total / limit)
        });
    } catch (err) {
        next(err);
    }
});

adminRouter.get('/stats/count', async (req, res, next) => {
    try {
        const total = await Job.countDocuments();
        res.json({ total });
    } catch (err) {
        next(err);
    }
});

adminRouter.get('/categories/list', async (req, res, next) => {
    try {
        const categories = await Job.distinct('category');
        res.json(categories);
    } catch (err) {
        next(err);
    }
});

adminRouter.post('/add', async (req, res, next) => {
    try {
        const job = new Job(req.body);
        const newJob = await job.save();
        res.status(201).json(newJob);
    } catch (err) {
        next(err);
    }
});

adminRouter.put('/:id', async (req, res, next) => {
    try {
        const job = await Job.findByIdAndUpdate(
            req.params.id,
            { $set: req.body },
            { new: true, runValidators: true }
        );
        if (!job) return res.status(404).json({ message: 'Job not found' });
        res.json(job);
    } catch (err) {
        next(err);
    }
});

adminRouter.delete('/:id', async (req, res, next) => {
    try {
        const job = await Job.findByIdAndDelete(req.params.id);
        if (!job) return res.status(404).json({ message: 'Job not found' });
        res.json({ message: 'Job deleted' });
    } catch (err) {
        next(err);
    }
});

adminRouter.get('/:id', async (req, res, next) => {
    try {
        const job = await Job.findById(req.params.id);
        if (!job) return res.status(404).json({ message: 'Job not found' });
        res.json(job);
    } catch (err) {
        next(err);
    }
});

module.exports = { publicRouter, adminRouter };
