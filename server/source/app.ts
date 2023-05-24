import fastify from "fastify";
import { ZodError } from "zod";

export const app = fastify();

app.get('/', ()=> {
    return "tudo ok!"
})

app.setErrorHandler((error, _, reply) => {
    if (error instanceof ZodError) {
        return reply.status(400).send({
            message: "Validation failed.",
            issues: error.format(),
        })
    }

    console.log(error);

    return reply.status(500).send({
        message: "Internal server error.",
    })
})