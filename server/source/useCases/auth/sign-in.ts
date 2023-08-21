import { User } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"
import { InvalidCredentials } from "../errors/InvalidCredentials"

interface ISignInUseCaseRequest {
    userId: string
    email: string | null
    name: string | null
}

interface ISignInUseCaseReply {
    user: User
}

export class SignInUseCase {
    constructor(private userRepository: IUserRepository) {}

    async handle({
        email,
        name,
        userId,
    }: ISignInUseCaseRequest): Promise<ISignInUseCaseReply> {
        const user = await this.userRepository.findById(userId)
        
        if (user) {
            return { user }
        }

        if (!name || !email) {
            throw new InvalidCredentials()
        }

        const newUser = await this.userRepository.create({
            id: userId,
            email,
            name,
        })

        return {
            user: newUser,
        }
    }
}