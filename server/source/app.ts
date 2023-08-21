import fastify from "fastify";
import { ZodError } from "zod";
import { authRoutes } from "./http/controllers/auth/routes";
import { taskRoutes } from "./http/controllers/task/routes";
import { documentRoutes } from "./http/controllers/document/routes";
import { workspaceRoutes } from "./http/controllers/workspace/routes";
import { userRoutes } from "./http/controllers/user/routes";
import { notificationRoutes } from "./http/controllers/notification/routes";
import { InvalidCredentials } from "./useCases/errors/InvalidCredentials";
import { BadRequest } from "./useCases/errors/BadRequest";
import { UserNotFound } from "./useCases/errors/UserNotFound";

export const app = fastify();

app.get('/', ()=> {
    return "tudo ok!"
})

app.register(authRoutes);
app.register(userRoutes)
app.register(taskRoutes);
app.register(documentRoutes);
app.register(workspaceRoutes);
app.register(notificationRoutes);

app.setErrorHandler((error, _, reply) => {
    if (error instanceof ZodError) {
        return reply.status(400).send({
            message: "Validation failed.",
            issues: error.format(),
        })
    }

    console.log(error);

    if(error instanceof InvalidCredentials) {
        return reply.status(401).send({ message: error.message })
    }

    if(error instanceof BadRequest) {
        return reply.status(404).send({ message: error.message })
    }

    if(error instanceof UserNotFound) {
        return reply.status(404).send({ message: error.message })
    }
   
    return reply.status(500).send({
        message: "Internal server error.",
    })
})