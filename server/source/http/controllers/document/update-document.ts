import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeUpdateDocumentUseCase } from "../../../useCases/factories/document/make-update-document";

export async function updateDocument(request: FastifyRequest, reply: FastifyReply) {
    const updateDocumentBodySchema = z.object({
        id: z.string(),
        text: z.string(),
        textString: z.string()
    })

    const { id, text, textString } = updateDocumentBodySchema.parse(request.body);

    try {
        const updateDocumentUseCase = makeUpdateDocumentUseCase();
        const { document } = await updateDocumentUseCase.handle({
            id,
            text,
            textString
        })

        return reply.status(200).send({ data: document });
    } catch(err) {
        return reply.status(400).send({ error: err });
    }
}