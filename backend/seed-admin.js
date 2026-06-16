const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const User = require('./models/User');
require('dotenv').config();

async function seedAdmin() {
    try {
        await mongoose.connect(process.env.MONGO_URI || 'mongodb://localhost:27017/workscout');
        console.log('Connected to MongoDB');

        const adminEmail = 'admin@workscout.com';
        const adminPassword = 'admin123';

        const existingAdmin = await User.findOne({ email: adminEmail });
        
        if (existingAdmin) {
            console.log('Admin user already exists');
            if (existingAdmin.role !== 'admin') {
                existingAdmin.role = 'admin';
                await existingAdmin.save();
                console.log('Updated existing user to admin role');
            }
        } else {
            const hashedPassword = await bcrypt.hash(adminPassword, 10);
            
            const admin = new User({
                name: 'Admin User',
                email: adminEmail,
                password: hashedPassword,
                role: 'admin',
                location: 'Jordan',
                profilePic: '',
                skills: [],
                languages: ['English', 'Arabic']
            });

            await admin.save();
            console.log('Admin user created successfully');
        }

        console.log('\nAdmin credentials:');
        console.log('Email: admin@workscout.com');
        console.log('Password: admin123');

        await mongoose.disconnect();
        console.log('\nDisconnected from MongoDB');
    } catch (err) {
        console.error('Seed error:', err);
        process.exit(1);
    }
}

seedAdmin();
