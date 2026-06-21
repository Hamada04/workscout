const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const { GoogleGenerativeAI } = require('@google/generative-ai');

router.post('/analyze-cv', auth, async (req, res, next) => {
    try {
        const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
        const model = genAI.getGenerativeModel({ model: 'gemini-3.1-flash-lite' });

        const user = req.user;
        const profileSummary = [
            `Name: ${user.name || 'N/A'}`,
            `Location: ${user.location || 'N/A'}`,
            `Skills: ${(user.skills || []).join(', ')}`,
            `Languages: ${(user.languages || []).join(', ')}`,
            `Education: ${(user.education || []).map(e => `${e.degree} at ${e.university} (${e.date})`).join('; ')}`,
            `Experience: ${(user.experiences || []).map(e => `${e.title} at ${e.company} (${e.date})`).join('; ')}`,
        ].join('\n');

        const systemPrompt = `You are an expert AI career coach. Analyze the user's profile below and provide personalized career recommendations in Arabic. Focus on:

1. Career path suggestions based on their skills and experience
2. Skills they should develop to advance
3. Job roles that match their profile
4. Learning resources and certifications
5. Any gaps in their profile

Format the response in clean markdown with sections.

User Profile:
${profileSummary}`;

        const result = await model.generateContent(systemPrompt);
        const text = result.response.text();

        res.json({ recommendation: text });
    } catch (err) {
        if (err.message?.includes('API_KEY')) {
            return res.status(500).json({ message: 'AI service not configured. Please set GEMINI_API_KEY in .env' });
        }
        next(err);
    }
});

module.exports = router;
