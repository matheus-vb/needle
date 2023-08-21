import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeQueryDocumentByTagUseCase } from "../../../useCases/factories/document/make-query-document-tag";

export async function queryDocumentByTaskTag(request: FastifyRequest, reply: FastifyReply) {
    const queryDocumentByTaskTagBodySchema = z.object({
        accessCode: z.string(),
        tag: z.string(),
    })

    const { tag, accessCode } = queryDocumentByTaskTagBodySchema.parse(request.params);

    try {
        const queryDocumentByTaskTagUseCase = makeQueryDocumentByTagUseCase();

        const { documents } = await queryDocumentByTaskTagUseCase.handle({
            tag,
            accessCode
        })

        return reply.status(200).send({ data: documents });
    } catch(err) {
        throw err
    }
}