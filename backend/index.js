const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

if (!process.env.JWT_SECRET) {
    console.error('FATAL ERROR: JWT_SECRET is not defined in environment variables');
    process.exit(1);
}

const authRoutes = require('./routes/authRoutes');
const adminAuthRoutes = require('./routes/adminAuthRoutes');
const userRoutes = require('./routes/userRoutes');
const { publicRouter: jobPublicRoutes, adminRouter: jobAdminRoutes } = require('./routes/jobRoutes');
const applicationRoutes = require('./routes/applicationRoutes');
const mobileApplicationRoutes = require('./routes/mobileApplicationRoutes');
const notificationRoutes = require('./routes/notificationRoutes');
const offerRoutes = require('./routes/offerRoutes');
const errorHandler = require('./middleware/errorHandler');

const app = express();

app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads'));

app.use((req, res, next) => {
    console.log(`${req.method} ${req.url}`);
    next();
});

// User authentication (mobile app)
app.use('/api/auth', authRoutes);

// Admin authentication & management
app.use('/api/admin/auth', adminAuthRoutes);
app.use('/api/admin/users', userRoutes);
app.use('/api/admin/jobs', jobAdminRoutes);
app.use('/api/admin/applications', applicationRoutes);
app.use('/api/admin/notifications', notificationRoutes);
app.use('/api/admin/offers', offerRoutes);

// Public routes (mobile app)
app.use('/api/jobs', jobPublicRoutes);
app.use('/api/applications', mobileApplicationRoutes);

// Global error handler — must be last
app.use(errorHandler);

mongoose.connect(process.env.MONGO_URI)
    .then(() => console.log('Connected to MongoDB Local Successfully'))
    .catch(err => console.log('MongoDB Connection Error: ', err));

const PORT = process.env.PORT || 5000;

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on port: ${PORT}`);
});
