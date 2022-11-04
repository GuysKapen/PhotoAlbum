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

app.route('/api/users/:userId/uploads/image')
    .post(uploadController.uploadImage)

app.route('/api/public/photobooks')
    .get(photobookController.list)

app.route('/api/public/albums')
    .get(albumController.list)

// Photobooks routes
const photobookRoutes = express.Router();

photobookRoutes.use(authMiddleware.verifyToken);

photobookRoutes.route('/')
    .get(photobookController.findOfUser)
    .post(photobookController.create)

photobookRoutes.route('/:id')
    .get(photobookController.read)
    .put(photobookController.update)
    .delete(photobookController.delete);

photobookRoutes.route('/:id/favorite')
    .put(photobookController.toggleFavorite)

photobookRoutes.route('/favorite')
    .get(photobookController.findAllFavorite)

photobookRoutes.route('/:id/pages')
    .get(photobookController.pages)

app.use("/api/photobooks", photobookRoutes)

// Album routes
const albumRoutes = express.Router();

albumRoutes.use(authMiddleware.verifyToken);

albumRoutes.route('/')
    .get(albumController.findOfUser)
    .post(albumController.create)

albumRoutes.route('/:id')
    .get(albumController.read)
    .put(albumController.update)
    .delete(albumController.delete);

albumRoutes.route('/:id/favorite')
    .put(albumController.toggleFavorite)

albumRoutes.route('/:id/photobooks')
    .get(albumController.photobooks)

app.use("/api/albums", albumRoutes)

app.use((req, res, next) => {
    return next(new ApiError(404, 'Resource not found'))
})

app.use((err, req, res, next) => {
    return res.status(err.statusCode || 500).json({
        message: err.message || 'Internal server error'
    })
})

module.exports = app;