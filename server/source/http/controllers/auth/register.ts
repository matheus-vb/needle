import { FastifyReply, FastifyRequest } from "fastify";
import { z } from "zod";
import { makeRegisterUseCase } from "../../../useCases/factories/auth/make-register";

export async function register(request: FastifyRequest, reply: FastifyReply) {
    const registerBodySchema = z.object({
        name: z.string(),
        email: z.string(),
        password: z.string(),
        role: z.string(),
    })

    const { name, email, password, role } = registerBodySchema.parse(request.body);

    try {
        const registerUserUseCase = makeRegisterUseCase();

        const { user } = await registerUserUseCase.handle({
            email,
            name,
            password,
            role,
        })

        return reply.status(201).send({ data: user });
    } catch(err) {
        return reply.status(400).send({ error: err });
    }
}