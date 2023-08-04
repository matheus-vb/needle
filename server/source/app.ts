import fastify from "fastify";
import { ZodError } from "zod";
import { authRoutes } from "./http/controllers/auth/routes";
import { taskRoutes } from "./http/controllers/task/routes";
import { documentRoutes } from "./http/controllers/document/routes";
import { workspaceRoutes } from "./http/controllers/workspace/routes";
import { userRoutes } from "./http/controllers/user/routes";

export const app = fastify();

app.get('/', ()=> {
    return "tudo ok!"
})

app.register(authRoutes);
app.register(userRoutes)
app.register(taskRoutes);
app.register(documentRoutes);
app.register(workspaceRoutes);

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