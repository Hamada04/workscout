const mongoose = require('mongoose');

const jobSchema = new mongoose.Schema({
    companyName: { type: String, required: true },
    jobTitle: { type: String, required: true },
    location: { type: String, required: true },
    jobType: { type: String, required: true },
    contractType: { type: String, required: true },
    experienceLevel: { type: String, required: true },
    postedDate: { type: String, required: true },
    salary: { type: String, required: true },
    companyLogo: { type: String, required: true },
    category: { type: String, required: true },
    description: { type: String, required: true },
    officeAddress: { type: String, required: true },
    skills: [String], // قائمة نصوص
    responsibilities: [String],
    requirements: [String],
    benefits: [String]
}, { timestamps: true }); // لكي نعرف متى أضيفت الوظيفة تلقائياً

module.exports = mongoose.model('Job', jobSchema);