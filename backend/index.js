//connect to Cluster0
//mongodb+srv://ahmadhammam004_db_user:K8yUBIBSNHF46Qnx@cluster0.zs23g2t.mongodb.net/?appName=Cluster0
//ahmadhammam004_db_user
//K8yUBIBSNHF46Qnx
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

// استيراد المسارات (Routes)
const authRoutes = require('./routes/authRoutes');
const adminAuthRoutes = require('./routes/adminAuthRoutes');
const userRoutes = require('./routes/userRoutes');
const jobRoutes = require('./routes/jobRoutes');
const applicationRoutes = require('./routes/applicationRoutes');
const notificationRoutes = require('./routes/notificationRoutes');
const offerRoutes = require('./routes/offerRoutes');

const app = express();

// Middleware
app.use(cors());
app.use(express.json()); // ضروري لفهم بيانات JSON القادمة من فلاتر

// هذا الكود سيطبع في الـ Terminal أي طلب يصل للسيرفر فوراً
app.use((req, res, next) => {
    console.log(`وصل طلب جديد: ${req.method} على المسار ${req.url}`);
    next();
});

// ربط المسارات
// User authentication (mobile app)
app.use('/api/auth', authRoutes);

// Admin authentication & management
app.use('/api/admin/auth', adminAuthRoutes);
app.use('/api/admin/users', userRoutes);
app.use('/api/admin/jobs', jobRoutes);
app.use('/api/admin/applications', applicationRoutes);
app.use('/api/admin/notifications', notificationRoutes);
app.use('/api/admin/offers', offerRoutes);

// Public job routes (mobile app)
app.use('/api/jobs', jobRoutes);

// الاتصال بقاعدة البيانات المحلية
mongoose.connect(process.env.MONGO_URI)
    .then(() => console.log("Connected to MongoDB Local Successfully ✅"))
    .catch(err => console.log("MongoDB Connection Error: ", err));

// تعريف المنفذ (Port)
const PORT = process.env.PORT || 5000;

// app.listen(PORT, () => {
//     console.log(`Server is running on port: ${PORT}`);
// });
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on port: ${PORT}`);
});