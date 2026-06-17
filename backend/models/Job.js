const mongoose = require('mongoose');

const jobSchema = new mongoose.Schema({
    companyName: { type: String, required: true, index: true },
    jobTitle: { type: String, required: true },
    location: { type: String, required: true },
    jobType: { type: String, required: true, index: true },
    contractType: { type: String, required: true },
    experienceLevel: { type: String, required: true, index: true },
    postedDate: { type: Date, default: Date.now },
    salary: { type: String, required: true },
    companyLogo: { type: String, default: '' },
    category: { type: String, required: true, index: true },
    description: { type: String, required: true },
    officeAddress: { type: String, required: true },
    skills: [String],
    responsibilities: [String],
    requirements: [String],
    benefits: [String]
}, { timestamps: true });

jobSchema.pre('findOneAndDelete', async function (next) {
    const filter = this.getFilter();
    const jobId = filter._id;
    await mongoose.model('Application').deleteMany({ jobId });
    await mongoose.model('OfferLetter').deleteMany({ jobId });
    next();
});

module.exports = mongoose.model('Job', jobSchema);
