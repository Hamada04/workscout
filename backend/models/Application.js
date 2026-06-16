const mongoose = require('mongoose');

const applicationSchema = new mongoose.Schema({
    jobId: { type: mongoose.Schema.Types.ObjectId, ref: 'Job', required: true },
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    status: { 
        type: String, 
        enum: ['pending', 'reviewed', 'interview', 'accepted', 'rejected'], 
        default: 'pending' 
    },
    cvUrl: { type: String, default: '' },
    coverLetter: { type: String, default: '' },
    notes: { type: String, default: '' },
    appliedAt: { type: String, required: true }
}, { timestamps: true });

module.exports = mongoose.model('Application', applicationSchema);
