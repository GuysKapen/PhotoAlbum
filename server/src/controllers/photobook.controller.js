const PhotobookService = require('../services/photobook.service')
const PhotopageService = require('../services/photopage.service')
const AlbumPhotobookService = require('../services/album_photobook.service')
const ApiError = require('../api_error')
const fs = require('fs')

exports.create = async (req, res, next) => {
    if (!req.body.name) {
        return next(new ApiError(400, 'Name can not be empty'))
    }

    console.log("req", req.body);

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

        if ("album" in req.body && req.body["album"] && req.body["album"] > 0) {
            try {
                const albumPhotobookService = new AlbumPhotobookService()
                await albumPhotobookService.create({ album_id: req.body["album"], photobook_id: photobook.id })
            } catch (error) {

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
    const photobookId = req.params.id
    try {
        if (Object.keys(req.body).length === 0) {
            return next(new ApiError(400, 'Data update connot be empty'))
        }

        const photobook = await (new PhotobookService()).findById(req.params.id)
        if (!photobook) {
            return next(new ApiError(404, 'Not found'))
        }

        // Remove old cover
        if (req.body['cover'] && photobook.cover && photobook.cover !== req.body['cover']) {
            fs.unlink(photobook.cover, (err) => {
                if (err) {
                    console.log(`Failed to delete ${photobook.cover}: ` + err);
                } else {
                    console.log(`Successfully deleted ${photobook.cover}`);
                }
            })
        }

        const photobookService = new PhotobookService();
        const updated = await photobookService.update(photobookId, req.body);

        if ("pages" in req.body && req.body["pages"]) {
            const photopageService = new PhotopageService()

            for (let index = 0; index < req.body["pages"].length; index++) {
                const page = req.body["pages"][index];
                // If id exist (update)
                if (page.id) {

                    let oldPage = await (new PhotopageService()).findById(page.id)
                    // Remove old cover
                    if (oldPage && page.image && oldPage.image
                        && page.image !== oldPage.image) {
                        fs.unlink(oldPage.image, (err) => {
                            if (err) {
                                console.log(`Failed to delete ${oldPage.image}: ` + err);
                            } else {
                                console.log(`Successfully deleted ${oldPage.image}`);
                            }
                        })
                    }

                    await photopageService.update(page.id, { photobook_id: photobookId, ...page })
                } else {
                    await photopageService.create({ photobook_id: photobookId, ...page })
                }
            }
            await photopageService.deleteOfBook(req.params.id, req.body["pages"].map(el => el.id))
        }

        if ("album" in req.body && req.body["album"] && req.body["album"] > 0) {
            const albumPhotobookService = new AlbumPhotobookService()

            await albumPhotobookService.deleteOfBook(photobookId)
            await albumPhotobookService.create({ album_id: req.body["album"], photobook_id: photobookId })

        }


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
    return res.send({ message: 'Photobook was deleted successfully' })
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

exports.pages = async (req, res, next) => {
    try {
        const photopageService = new PhotopageService();
        const pages = await photopageService.findOfBook(req.params.id);

        if (!pages) {
            return next(new ApiError(404, 'Contact not found'));
        }

        return res.send(pages);
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred when read contact'))
    }
}

// For specific user
exports.findOfUser = async (req, res, next) => {
    const userId = req.params.userId || req.userId
    let photobooks = []

    try {
        const contactService = new PhotobookService();
        photobooks = await contactService.findOfUser(userId);
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

exports.toggleFavorite = async (req, res, next) => {
    try {
        const photobookService = new PhotobookService();
        const updated = await photobookService.toggleFavorite(req.params.id);

        if (!updated) {
            return next(new ApiError(404, 'Not found'))
        }
    } catch (error) {
        console.log(error);
        return next(new ApiError(500, `Could not update photobook with id=${req.params.id}`))
    }
    return res.send({ message: 'Photobook was updated successfully' })
}

exports.download = async function (req, res, next) {
    try {
        const photobookService = new PhotobookService();
        const photobook = await photobookService.findById(req.params.id);

        if (!photobook || !photobook.cover) {
            return next(new ApiError(404, 'Contact not found'));
        }

        const photopageService = new PhotopageService()

        const photopages = await photopageService.findOfBook(req.params.id)

        const paths = [{ path: photobook.cover, name: photobook.cover.replace(/^.*[\\\/]/, '') }]
        for (const element of photopages) {
            if (element.image) {
                paths.push({ path: element.image, name: element.image.replace(/^.*[\\\/]/, '') })
            }
        }

        return res.zip(paths)

    } catch (error) {
        console.log(error);
        return next(new ApiError(500, 'Error occurred when read contact'))
    }
};