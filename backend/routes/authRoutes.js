const express = require('express');
const router = express.Router();
const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// تسجيل حساب جديد
router.post('/signup', async (req, res) => {
    try {
        const { name, email, password, role } = req.body;

        const userExists = await User.findOne({ email });
        if (userExists) return res.status(400).json({ message: "الإيميل مستخدم مسبقاً" });

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        const user = new User({ name, email, password: hashedPassword, role });
        await user.save();

        res.status(201).json({ message: "تم إنشاء الحساب بنجاح" });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// تسجيل الدخول
router.post('/login', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) return res.status(400).json({ message: "بيانات الدخول غير صحيحة" });

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(400).json({ message: "بيانات الدخول غير صحيحة" });

        const token = jwt.sign({ id: user._id, role: user.role }, 'secret_key_123', { expiresIn: '1d' });

        res.json({
            token,
            user: { id: user._id, name: user.name, role: user.role, email: user.email }
        });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});
// مسار لتحديث بيانات المستخدم الإضافية
router.put('/update-profile/:id', async (req, res) => {
    try {
        const updatedUser = await User.findByIdAndUpdate(
            req.params.id, 
            { $set: req.body }, // سيأخذ البيانات (المهارات، الموقع، الخ) ويحدثها
            { new: true }
        );
        res.json({ message: "تم تحديث الملف الشخصي بنجاح", user: updatedUser });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});
module.exports = router;