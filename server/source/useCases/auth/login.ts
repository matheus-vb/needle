import { User } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"
import { UserNotFound } from "../errors/UserNotFound"

interface ILoginUserUseCaseRequest{
    email: string
    password: string
}

interface ILoginUserUseCaseRespose{
    user: User
}

export class LoginUserUseCase{
    constructor(private usersRepository: IUserRepository) {}

    async handle({
        email,
        password
    }: ILoginUserUseCaseRequest): Promise<ILoginUserUseCaseRespose> {
            const existingUser = await this.usersRepository.findByEmail(email);

            if(!existingUser){
                throw new UserNotFound()
            }
    }
}