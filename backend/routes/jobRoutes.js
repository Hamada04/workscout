const express = require('express');
const router = express.Router();
const Job = require('../models/Job');
const adminAuth = require('../middleware/adminAuth');

router.get('/', async (req, res) => {
    try {
        const jobs = await Job.find().sort({ createdAt: -1 });
        res.json(jobs);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

router.get('/all', async (req, res) => {
    try {
        const jobs = await Job.find().sort({ createdAt: -1 });
        res.json(jobs);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

router.get('/admin', adminAuth, async (req, res) => {
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
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/:id', async (req, res) => {
    try {
        const job = await Job.findById(req.params.id);
        if (!job) return res.status(404).json({ message: 'Job not found' });
        res.json(job);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

router.post('/add', adminAuth, async (req, res) => {
    try {
        const job = new Job(req.body);
        const newJob = await job.save();
        res.status(201).json(newJob);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

router.put('/:id', adminAuth, async (req, res) => {
    try {
        const job = await Job.findByIdAndUpdate(
            req.params.id,
            { $set: req.body },
            { new: true }
        );
        if (!job) return res.status(404).json({ message: 'Job not found' });
        res.json(job);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

router.delete('/:id', adminAuth, async (req, res) => {
    try {
        const job = await Job.findByIdAndDelete(req.params.id);
        if (!job) return res.status(404).json({ message: 'Job not found' });
        res.json({ message: 'Job deleted' });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

router.get('/stats/count', adminAuth, async (req, res) => {
    try {
        const total = await Job.countDocuments();
        res.json({ total });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/categories/list', async (req, res) => {
    try {
        const categories = await Job.distinct('category');
        res.json(categories);
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
