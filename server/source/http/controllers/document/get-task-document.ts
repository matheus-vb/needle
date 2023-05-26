import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeGetTaskDocuementUseCase } from "../../../useCases/factories/document/make-get-task-document";

export async function getTaskDocument(request: FastifyRequest, reply: FastifyReply) {
    const getTaskDocumentBodySchema = z.object({
        taskId: z.string(),
    })

    const { taskId } = getTaskDocumentBodySchema.parse(getTaskDocumentBodySchema);

    try {
        const getTaskDocumentationUseCase = makeGetTaskDocuementUseCase();

        const { document } = await getTaskDocumentationUseCase.handle({
            taskId,
        })

        return reply.status(200).send({ data: document });
    } catch(err) {
        return reply.status(400).send({ error: err });
    }
}