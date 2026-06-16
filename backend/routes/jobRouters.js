const express = require('express');
const router = express.Router();
const Job = require('../models/Job');

// 1. جلب جميع الوظائف (GET)
router.get('/all', async (req, res) => {
    try {
        const jobs = await Job.find();
        res.json(jobs);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// 2. إضافة وظيفة جديدة (POST) - هذه يستخدمها الأدمن
router.post('/add', async (req, res) => {
    const job = new Job(req.body);
    try {
        const newJob = await job.save();
        res.status(201).json(newJob);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

module.exports = router;