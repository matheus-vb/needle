import { Role, User } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"
import { hash } from "bcryptjs";
import { z } from "zod";

interface IRegisterUserUseCaseRequest {
    name: string
    email: string
    password: string
    role: string
}

interface IRegisterUserUseCaseReply {
    user: User
}

export class RegisterUserUseCase {
    constructor(private usersRepository: IUserRepository) {}

    async handle({
        email,
        name,
        password,
        role,
    }: IRegisterUserUseCaseRequest): Promise<IRegisterUserUseCaseReply> {
        const existingUser = await this.usersRepository.findByEmail(email);
        if(existingUser) {
            throw new Error();
        }

        const password_hash = await hash(password, 6);

        const roleEnum = z.nativeEnum(Role)
        const checkedRole = roleEnum.parse(role)

        const user = await this.usersRepository.create({
            email,
            name,
            password_hash,
            role: checkedRole,
        })

        return {
            user,
        }
    }
}