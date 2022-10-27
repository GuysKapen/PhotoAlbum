const jwt = require('jsonwebtoken')
const privateKey = process.env.PRIVATE_KEY;

exports.verifyToken = function (req, res, next) {
    const token = req.body.token || req.query.token || req.headers['x-access-token'];
    if (token) {
        jwt.verify(token, privateKey, function (err, decoded) {
            if (err) {
                res.status(401).send({ success: false, message: 'Failed to authenticate token.' });
            } else {
                req.userId = decoded.id
                next();
            }
        });
    } else {
        response.sendUnauthorized(res, 'No token provided.');
    }
};