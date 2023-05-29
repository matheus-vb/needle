import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeQueryDocumentByTypeUseCase } from "../../../useCases/factories/document/make-query-document-type";


export async function queryDocumentByTaskType(request: FastifyRequest, reply: FastifyReply) {
    const queryDocumentByTaskTypeBodySchema = z.object({
        type: z.string(),
        accessCode: z.string(),
    })

    const { type, accessCode } = queryDocumentByTaskTypeBodySchema.parse(request.params);

    try {
        const queryDocumentByTaskTypeUseCase = makeQueryDocumentByTypeUseCase();
        const { documents } = await queryDocumentByTaskTypeUseCase.handle({
            type,
            accessCode
        })

        return reply.status(200).send({ data: documents });
    } catch (err) {
        return reply.status(400).send({ error: err });
    }
}