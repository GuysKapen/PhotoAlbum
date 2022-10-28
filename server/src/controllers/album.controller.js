const AlbumService = require('../services/album.service')
const AlbumPhotobookService = require('../services/album_photobook.service')
const ApiError = require('../api_error')

exports.create = async (req, res, next) => {
    if (!req.body.name) {
        return next(new ApiError(400, 'Name can not be empty'))
    }

    try {
        const albumService = new AlbumService()
        const album = await albumService.create(req.body)

        if ("photobooks" in req.body && req.body["photobooks"]) {
            for (let index = 0; index < req.body["photobooks"].length; index++) {
                const photobook = req.body["photobooks"][index];
                const albumPhotobookService = new AlbumPhotobookService()
                albumPhotobookService.create({ album_id: album.id, photobook_id: photobook })
            }
        }

        return res.send(album)
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred in create album'))
    }
}

exports.list = async (req, res, next) => {
    let albums = []

    try {
        const albumService = new AlbumService();
        const { name } = req.query;
        if (name) {
            albums = await albumService.findByName(name);
        } else {
            albums = await albumService.all();
        }
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred in listing albums'))
    }

    return res.send(albums)
}

exports.read = async (req, res, next) => {
    try {
        const albumService = new AlbumService();
        const album = await albumService.findById(req.params.id);

        if (!album) {
            return next(new ApiError(404, 'Contact not found'));
        }

        return res.send(album);
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred when read album'))
    }
}

exports.update = async (req, res, next) => {
    try {
        if (Object.keys(req.body).length === 0) {
            return next(new ApiError(400, 'Data update connot be empty'))
        }

        const albumService = new AlbumService();
        const updated = await albumService.update(req.params.id, req.body);

        if (!updated) {
            return next(new ApiError(404, 'Contact not found'))
        }

        return res.send({ message: 'Contact was updated successfully' })
    } catch (error) {
        console.log(error)
        return next(new ApiError(500, `Error updating album with id=${req.params.id}`))
    }
}

exports.delete = async (req, res, next) => {
    try {
        const albumService = new AlbumService();
        const deleted = await albumService.delete(req.params.id);

        if (!deleted) {
            return next(new ApiError(404, 'Contact not found'))
        }
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, `Could not delete album with id=${req.params.id}`))
    }
}

exports.deleteAll = async (req, res, next) => {
    try {
        const albumService = new AlbumService();
        const deleted = await albumService.deleteAll();

        return res.send({ message: `${deleted} albums were deleted successfully` })
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'An error occurred while delele all albums'))
    }
}

exports.findAllFavorite = async (req, res, next) => {
    let albums = []

    try {
        const albumService = new AlbumService();
        albums = await albumService.findAllFavorite();
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred in retrieving favorite albums albums'))
    }

    return res.send(albums)
}

// For specific user
exports.findOfUser = async (req, res, next) => {
    const userId = req.params.userId || req.userId
    let albums = []

    try {
        const albumService = new AlbumService();
        albums = await albumService.findOfUser(userId);
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred in retrieving favorite albums albums'))
    }

    return res.send(albums)
}

exports.addToUser = async (req, res, next) => {
    let albums = []

    try {
        const albumService = new AlbumService();
        albums = await albumService.findOfUser(req.params.userId);
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred in retrieving favorite albums albums'))
    }

    return res.send(albums)
}

exports.photobooks = async (req, res, next) => {
    try {
        const albumPhotobookService = new AlbumPhotobookService();
        const books = await albumPhotobookService.findOfAlbum(req.params.id);

        if (!books) {
            return next(new ApiError(404, 'Not found'));
        }

        return res.send(books);
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred'))
    }
}