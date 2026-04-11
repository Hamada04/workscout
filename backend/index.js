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

const app = express();

// Middleware
app.use(cors());
app.use(express.json()); // ضروري لفهم بيانات JSON القادمة من فلاتر

// هذا الكود سيطبع في الـ Terminal أي طلب يصل للسيرفر فوراً
app.use((req, res, next) => {
    console.log(`وصل طلب جديد: ${req.method} على المسار ${req.url}`);
    next();
});
// ربط مسارات الموثوقية (Login & Signup)
app.use('/api/auth', authRoutes);

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