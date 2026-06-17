const mongoose = require('mongoose');

const applicationSchema = new mongoose.Schema({
    jobId: { type: mongoose.Schema.Types.ObjectId, ref: 'Job', required: true, index: true },
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true, index: true },
    status: {
        type: String,
        enum: ['pending', 'reviewed', 'interview', 'accepted', 'rejected'],
        default: 'pending',
        index: true
    },
    cvUrl: { type: String, default: '' },
    coverLetter: { type: String, default: '' },
    notes: { type: String, default: '' },
    appliedAt: { type: Date, default: Date.now }
}, { timestamps: true });

applicationSchema.index({ jobId: 1, userId: 1 });

module.exports = mongoose.model('Application', applicationSchema);
