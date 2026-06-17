const errorHandler = (err, req, res, next) => {
    console.error(`[${req.method} ${req.url}]`, err.message);

    if (err.name === 'ValidationError') {
        return res.status(400).json({
            success: false,
            message: err.message
        });
    }

    if (err.name === 'CastError') {
        return res.status(400).json({
            success: false,
            message: 'Invalid resource identifier'
        });
    }

    if (err.name === 'MulterError') {
        if (err.code === 'LIMIT_FILE_SIZE') {
            return res.status(400).json({
                success: false,
                message: 'File too large. Maximum size is 5MB'
            });
        }
        return res.status(400).json({
            success: false,
            message: err.message
        });
    }

    if (err.message === 'Only PDF files are allowed') {
        return res.status(400).json({
            success: false,
            message: err.message
        });
    }

    if (err.code === 11000) {
        return res.status(409).json({
            success: false,
            message: 'Resource already exists'
        });
    }

    res.status(err.status || 500).json({
        success: false,
        message: err.message || 'Internal Server Error'
    });
};

module.exports = errorHandler;
