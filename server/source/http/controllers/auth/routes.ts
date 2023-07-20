import { FastifyInstance } from "fastify";
import { register } from "./register";
import { authenticate } from "./authenticate";

export async function authRoutes(app: FastifyInstance) {
    app.post('/register', register);
    app.post('/auth', authenticate);
}