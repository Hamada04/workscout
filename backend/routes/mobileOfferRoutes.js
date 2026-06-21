const express = require('express');
const router = express.Router();
const OfferLetter = require('../models/OfferLetter');
const auth = require('../middleware/auth');

// Mobile: get a single offer by ID (must belong to the requesting user)
router.get('/:id', auth, async (req, res, next) => {
    try {
        const offer = await OfferLetter.findById(req.params.id)
            .populate('jobId');
        if (!offer) return res.status(404).json({ message: 'Offer not found' });
        if (offer.userId.toString() !== req.user._id.toString()) {
            return res.status(403).json({ message: 'Forbidden' });
        }
        res.json(offer);
    } catch (err) {
        next(err);
    }
});

module.exports = router;
