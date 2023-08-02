import { FastifyInstance } from "fastify";
import { signIn } from "./sign-in";

export async function authRoutes(app: FastifyInstance) {
    app.post('/signin', signIn);
}