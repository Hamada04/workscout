const mongoose = require('mongoose');

const offerLetterSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    jobId: { type: mongoose.Schema.Types.ObjectId, ref: 'Job', required: true },
    applicationId: { type: mongoose.Schema.Types.ObjectId, ref: 'Application', required: true },
    salary: { type: String, required: true },
    startDate: { type: Date, required: true },
    position: { type: String, required: true },
    department: { type: String, default: '' },
    status: { 
        type: String, 
        enum: ['sent', 'viewed', 'accepted', 'rejected', 'expired'], 
        default: 'sent' 
    },
    message: { type: String, default: '' },
    expiresAt: { type: Date, required: true }
}, { timestamps: true });

module.exports = mongoose.model('OfferLetter', offerLetterSchema);
