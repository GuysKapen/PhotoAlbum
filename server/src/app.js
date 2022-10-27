require('dotenv').config()
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const bodyParser = require('body-parser')
const fileUpload = require('express-fileupload')

const app = express()

const photobookController = require('./controllers/photobook.controller')
const albumController = require('./controllers/album.controller')
const authController = require('./controllers/auth.controller')
const uploadController = require('./controllers/upload.controller')
const ApiError = require('./api_error')
const authMiddleware = require('./middleware/auth');

app.use(fileUpload({
    createParentPath: true,
    limits: {
        fileSize: 20 * 1024 * 1024 * 1024 //20MB max file(s) size
    },
}))
app.use(express.json())
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(morgan('dev'));
app.use(cors())
app.use('/uploads', express.static('uploads'))

app.get('/', (req, res) => {
    res.json({ 'message': 'Welcome' })
});

app.route('/api/authenticate')
    .post(authController.authenticate)

app.route('/api/register')
    .post(authController.registerController)

// Albums
app.route('/api/users/:userId/albums')
    .get(albumController.findOfUser)
    .post(albumController.create)
    .delete(albumController.deleteAll)

app.route('/api/users/:userId/uploads/image')
    .post(uploadController.uploadImage)

app.route('/api/public/photobooks')
    .get(photobookController.list)

const photobookRoutes = express.Router({ mergeParams: true });

photobookRoutes.use(authMiddleware.verifyToken);

photobookRoutes.route('/')
    .get(photobookController.findOfUser)
    .post(photobookController.create)

photobookRoutes.route('/:id')
    .get(photobookController.read)
    .put(photobookController.update)
    .delete(photobookController.delete);

photobookRoutes.route('/favorite')
    .get(photobookController.findAllFavorite)

photobookRoutes.route('/:id/pages')
    .get(photobookController.pages)

app.use("/api/photobooks", photobookRoutes)

app.use((req, res, next) => {
    return next(new ApiError(404, 'Resource not found'))
})

app.use((err, req, res, next) => {
    return res.status(err.statusCode || 500).json({
        message: err.message || 'Internal server error'
    })
})

module.exports = app;