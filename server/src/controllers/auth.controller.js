// noinspection JSUnresolvedFunction
const jwt = require('jsonwebtoken');

const { validationResult } = require("express-validator");

const privateKey = process.env.PRIVATE_KEY;
const tokenExpireInSeconds = process.env.TOKEN_EXPIRE;

const ApiError = require("../api_error")

const UserService = require('../services/user.service')

exports.authenticate = async function (req, res, next) {
  try {
    const userService = new UserService();
    const user = await userService.findByEmail(req.body.email);

    if (!user) {
      return next(new ApiError(404, 'User not found'));
    }

    const userTokenData = { id: user.id, email: user.email }

    const token = jwt.sign(userTokenData, privateKey, {
      expiresIn: tokenExpireInSeconds
    });

    const {id, email} = user

    return res.json({
      success: true,
      message: 'Token created.',
      token: token,
      user: { id, email }
    });
  } catch (error) {
    console.log(error);
    return next(new ApiError(500, 'Error occurred when read contact'))
  }
}

exports.verifyToken = async function (req, res, next) {
  const token = req.body.token || req.query.token || req.headers['x-access-token'];

  if (token) {
    jwt.verify(token, privateKey, async function (err, decoded) {
      if (err) {
        res.status(401).send({ success: false, message: 'Failed to authenticate token' })
      } else {
        const userService = new UserService();
        const user = await userService.findByEmail(decoded.email);
        if (!user) {
          res.status(401).send({ success: false, message: 'Failed to authenticate token' })
        }
        req.currentUser = user;
        next()
      }
    });
  } else {
    res.status(401).send({ success: false, message: 'To token provided' })
  }
};

// Mine
exports.registerController = async (req, res) => {
  const { email } = req.body;
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    const firstError = errors.array().map((error) => error.msg)[0];
    return res.status(400).json({
      error: firstError,
    });
  } else {
    let user
    try {
      const userService = new UserService();
      user = await userService.findByEmail(email)
      if (user) {
        return res.json({
          error: "Email is taken",
        });
      }

      user = userService.create(req.body)

      return res.send(user)
    } catch (err) {
      if (err) return res.json({ error: "Something went wrong!" })
    }
  }
};