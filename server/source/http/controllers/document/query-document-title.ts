import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeQueryDocumentByTitleUseCase } from "../../../useCases/factories/document/make-query-document-title";

export async function queryDocumentByTitle(request: FastifyRequest, reply: FastifyReply) {
    const queryDocumentByTaskTitleBodySchema = z.object({
        query: z.string(),
        accessCode: z.string(),
    })

    const { query, accessCode } = queryDocumentByTaskTitleBodySchema.parse(request.params);

    try {
        const queryDocumentByTaskTitleUseCase = makeQueryDocumentByTitleUseCase();

        const { documents } = await queryDocumentByTaskTitleUseCase.handle({
            query,
            accessCode
        })

        return reply.status(200).send({ data: documents });
    } catch(err) {
        return reply.status(400).send({ error: err });
    }
}