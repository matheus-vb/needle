import { FastifyInstance } from "fastify";
import { register } from "./register";

export async function authRoutes(app: FastifyInstance) {
    app.post('/register', register);
    app.post('/auth', register);
}