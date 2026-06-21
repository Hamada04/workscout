const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true, index: true },
    password: { type: String, required: true, select: false },
    role: { type: String, enum: ['user', 'admin'], default: 'user', index: true },
    location: { type: String, default: 'Jordan' },
    profilePic: { type: String, default: '' },
    cvUrl: { type: String, default: '' },
    isBlocked: { type: Boolean, default: false },
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
    }],
    savedJobsIds: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Job' }]
}, { timestamps: true });

userSchema.pre('findOneAndDelete', async function (next) {
    const filter = this.getFilter();
    const userId = filter._id;
    await mongoose.model('Application').deleteMany({ userId });
    await mongoose.model('Notification').deleteMany({ userId });
    await mongoose.model('OfferLetter').deleteMany({ userId });
    next();
});

module.exports = mongoose.model('User', userSchema);
