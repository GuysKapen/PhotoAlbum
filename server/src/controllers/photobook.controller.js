const PhotobookService = require('../services/photobook.service')
const PhotopageService = require('../services/photopage.service')
const ApiError = require('../api_error')

exports.create = async (req, res, next) => {
    if (!req.body.name) {
        return next(new ApiError(400, 'Name can not be empty'))
    }

    try {
        const photobookService = new PhotobookService()
        const photobook = await photobookService.create(req.body)

        if ("pages" in req.body && req.body["pages"]) {
            for (let index = 0; index < req.body["pages"].length; index++) {
                const page = req.body["pages"][index];
                const photopageService = new PhotopageService()
                photopageService.create({ photobook_id: photobook.id, ...page })
            }
        }

        return res.send(photobook)
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred in create contact'))
    }
}

exports.list = async (req, res, next) => {
    let contacts = []

    try {
        const contactService = new PhotobookService();
        const { name } = req.query;
        if (name) {
            contacts = await contactService.findByName(name);
        } else {
            contacts = await contactService.all();
        }
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred in listing contacts'))
    }

    return res.send(contacts)
}

exports.read = async (req, res, next) => {
    try {
        const contactService = new PhotobookService();
        const contact = await contactService.findById(req.params.id);

        if (!contact) {
            return next(new ApiError(404, 'Contact not found'));
        }

        return res.send(contact);
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred when read contact'))
    }
}

exports.update = async (req, res, next) => {
    try {
        if (Object.keys(req.body).length === 0) {
            return next(new ApiError(400, 'Data update connot be empty'))
        }

        const contactService = new PhotobookService();
        const updated = await contactService.update(req.params.id, req.body);

        if (!updated) {
            return next(new ApiError(404, 'Contact not found'))
        }

        return res.send({ message: 'Contact was updated successfully' })
    } catch (error) {
        console.log(error)
        return next(new ApiError(500, `Error updating contact with id=${req.params.id}`))
    }
}

exports.delete = async (req, res, next) => {
    try {
        const contactService = new PhotobookService();
        const deleted = await contactService.delete(req.params.id);

        if (!deleted) {
            return next(new ApiError(404, 'Contact not found'))
        }
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, `Could not delete contact with id=${req.params.id}`))
    }
}

exports.deleteAll = async (req, res, next) => {
    try {
        const contactService = new PhotobookService();
        const deleted = await contactService.deleteAll();

        return res.send({ message: `${deleted} contacts were deleted successfully` })
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'An error occurred while delele all contacts'))
    }
}

exports.findAllFavorite = async (req, res, next) => {
    let contacts = []

    try {
        const contactService = new PhotobookService();
        contacts = await contactService.findAllFavorite();
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred in retrieving favorite contacts contacts'))
    }

    return res.send(contacts)
}

// For specific user
exports.findOfUser = async (req, res, next) => {
    let photobooks = []

    try {
        const contactService = new PhotobookService();
        photobooks = await contactService.findOfUser(req.params.userId);
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred in retrieving favorite contacts contacts'))
    }

    return res.send(photobooks)
}

exports.addToUser = async (req, res, next) => {
    let photobooks = []

    try {
        const contactService = new PhotobookService();
        photobooks = await contactService.findOfUser(req.params.userId);
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred in retrieving favorite contacts contacts'))
    }

    return res.send(photobooks)
}