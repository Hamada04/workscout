const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    // 'user' للباحث عن عمل، و 'admin' لصاحب العمل/الشركة
    role: { type: String, enum: ['user', 'admin'], default: 'user' }, 
    location: { type: String, default: 'Jordan' },
    profilePic: { type: String, default: '' },
    // هذه الحقول ستظهر للأدمن عندما يفتح ملفك الشخصي
    skills: [String],
    languages: [String],
    education: [{
        degree: String,
        university: String,
        date: String
    }],
    experiences: [{
        title: String,
        company: String,
        date: String
    }]
}, { timestamps: true });

module.exports = mongoose.model('User', userSchema);