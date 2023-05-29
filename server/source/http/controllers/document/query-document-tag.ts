import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeQueryDocumentByTagUseCase } from "../../../useCases/factories/document/make-query-document-tag";

export async function queryDocumentByTaskTag(request: FastifyRequest, reply: FastifyReply) {
    const queryDocumentByTaskTagBodySchema = z.object({
        tag: z.string(),
    })

    const { tag } = queryDocumentByTaskTagBodySchema.parse(request.params);

    try {
        const queryDocumentByTaskTagUseCase = makeQueryDocumentByTagUseCase();

        const { documents } = await queryDocumentByTaskTagUseCase.handle({
            tag,
        })

        return reply.status(200).send({ data: documents });
    } catch(err) {
        return reply.status(400).send({ error: err });
    }
}