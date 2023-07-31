import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeSignInUseCase } from "../../../useCases/factories/auth/make-sign-in";

export async function signIn(request: FastifyRequest, reply: FastifyReply) {
    const signInBodySchema = z.object({
        userId: z.string(),
        name: z.string().nullable(),
        email: z.string().nullable()
    })

    const { userId, name, email } = signInBodySchema.parse(request.body);

    try {
        const signInUseCase = makeSignInUseCase()

        const { user } = await signInUseCase.handle({
            userId,
            name,
            email,
        })

        return reply.status(200).send({ data: user })
    } catch(err) {
        return reply.status(500).send({ err: err })
    }
}