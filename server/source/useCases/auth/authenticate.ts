import { User } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"
import { compare } from "bcryptjs"

interface IAuthenticateUserUseCaseRequest {
    email: string
    password: string
}

interface IAuthenticateUserUseCaseReply {
    user: User
}

export class AuthenticateUserUseCase {
    constructor(private userRepository: IUserRepository) {}

    async handle ({
        email,
        password
    }: IAuthenticateUserUseCaseRequest): Promise<IAuthenticateUserUseCaseReply> {
        const user = await this.userRepository.findByEmail(email);
        if(!user) {
            throw new Error();
        }

        const passwordMatches = await compare(password, user.password_hash);

        if(!passwordMatches) {
            throw new Error()
        }

        return {
            user,
        }

    }   
}