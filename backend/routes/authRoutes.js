const express = require('express');
const router = express.Router();
const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');

// تسجيل حساب جديد
router.post('/signup', async (req, res, next) => {
    try {
        const { name, email, password } = req.body;

        const userExists = await User.findOne({ email });
        if (userExists) return res.status(400).json({ message: "الإيميل مستخدم مسبقاً" });

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        const user = new User({ name, email, password: hashedPassword, role: 'user' });
        await user.save();

        res.status(201).json({ message: "تم إنشاء الحساب بنجاح" });
    } catch (err) {
        next(err);
    }
});

// تسجيل الدخول
router.post('/login', async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email }).select('+password');
        if (!user) return res.status(400).json({ message: "بيانات الدخول غير صحيحة" });

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({ message: "بيانات الدخول غير صحيحة" });

        const token = jwt.sign({ id: user._id, role: user.role }, process.env.JWT_SECRET, { expiresIn: '1d' });

        res.json({
            token,
            user: { id: user._id, name: user.name, role: user.role, email: user.email, savedJobsIds: user.savedJobsIds }
        });
    } catch (err) {
        next(err);
    }
});
// مسار لتحديث بيانات المستخدم الإضافية
router.get('/profile', auth, async (req, res, next) => {
    try {
        const user = await User.findById(req.user._id).select('-password');
        if (!user) return res.status(404).json({ message: 'User not found' });
        res.json({ success: true, data: user });
    } catch (err) {
        next(err);
    }
});

router.put('/update-profile', auth, async (req, res, next) => {
    try {
        const allowedFields = ['name', 'profilePic', 'location', 'skills', 'languages', 'education', 'experiences', 'savedJobsIds'];
        const updates = {};
        for (const field of allowedFields) {
            if (req.body[field] !== undefined) {
                updates[field] = req.body[field];
            }
        }

        if (Object.keys(updates).length === 0) {
            return res.status(400).json({ message: "No valid fields provided to update" });
        }

        const updatedUser = await User.findByIdAndUpdate(
            req.user._id,
            { $set: updates },
            { new: true, runValidators: true }
        ).select('-password');

        if (!updatedUser) {
            return res.status(404).json({ message: "User not found" });
        }

        res.json({ message: "تم تحديث الملف الشخصي بنجاح", user: updatedUser });
    } catch (err) {
        next(err);
    }
});

module.exports = router;