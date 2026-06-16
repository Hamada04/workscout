const express = require('express');
const router = express.Router();
const User = require('../models/User');
const adminAuth = require('../middleware/adminAuth');

router.get('/', adminAuth, async (req, res) => {
    try {
        const { page = 1, limit = 10, search = '', role = '' } = req.query;
        
        const query = {};
        if (search) {
            query.$or = [
                { name: { $regex: search, $options: 'i' } },
                { email: { $regex: search, $options: 'i' } }
            ];
        }
        if (role) query.role = role;

        const total = await User.countDocuments(query);
        const users = await User.find(query)
            .select('-password')
            .sort({ createdAt: -1 })
            .skip((page - 1) * limit)
            .limit(parseInt(limit));

        res.json({
            users,
            total,
            page: parseInt(page),
            pages: Math.ceil(total / limit)
        });
    } catch (err) {
        console.error('Get users error:', err);
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/:id', adminAuth, async (req, res) => {
    try {
        const user = await User.findById(req.params.id).select('-password');
        if (!user) return res.status(404).json({ message: 'User not found' });
        res.json(user);
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.put('/:id', adminAuth, async (req, res) => {
    try {
        const { name, location, skills, languages, education, experiences, role } = req.body;
        
        const user = await User.findById(req.params.id);
        if (!user) return res.status(404).json({ message: 'User not found' });

        if (name) user.name = name;
        if (location) user.location = location;
        if (skills) user.skills = skills;
        if (languages) user.languages = languages;
        if (education) user.education = education;
        if (experiences) user.experiences = experiences;
        if (role) user.role = role;

        await user.save();
        res.json({ message: 'User updated', user });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.put('/:id/block', adminAuth, async (req, res) => {
    try {
        const user = await User.findById(req.params.id);
        if (!user) return res.status(404).json({ message: 'User not found' });
        
        user.isBlocked = !user.isBlocked;
        await user.save();
        
        res.json({ message: user.isBlocked ? 'User blocked' : 'User unblocked', user });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.delete('/:id', adminAuth, async (req, res) => {
    try {
        const user = await User.findByIdAndDelete(req.params.id);
        if (!user) return res.status(404).json({ message: 'User not found' });
        res.json({ message: 'User deleted' });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

router.get('/stats/overview', adminAuth, async (req, res) => {
    try {
        const totalUsers = await User.countDocuments({ role: 'user' });
        const totalAdmins = await User.countDocuments({ role: 'admin' });
        
        res.json({ totalUsers, totalAdmins });
    } catch (err) {
        res.status(500).json({ message: 'Server error' });
    }
});

module.exports = router;
