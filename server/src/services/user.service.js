const knex = require('../database/knex');
class ContactService {
    constructor() {
        this.users = knex('users');
    }

    #getUser(payload) {
        const user = { ...payload };
        const userProperties = ["name", "email", "password"];

        Object.keys(user).forEach(function (key) {
            if (userProperties.indexOf(key) < 0) {
                delete user[key]
            }
        })

        return user;
    }

    async create(payload) {
        const user = this.#getUser(payload);
        const [id] = await this.users.insert(user);
        return { id, ...user };
    }

    async all() {
        return await this.users.select('*');
    }

    async findByEmail(email) {
        return await this.users
            .where('email', email)
            .select('*')
            .first()
    }

    async findById(id) {
        return await this.users
            .where('id', id)
            .select('*')
            .first()
    }

    async update(id, payload) {
        const user = this.#getUser(payload);
        return await this.users.where('id', id).update(user)
    }

    async delete(id) {
        return await this.users.where('id', id).del()
    }
}
module.exports = ContactService;
