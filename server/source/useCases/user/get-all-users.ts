import { User } from "@prisma/client";
import { IUserRepository } from "../../repositories/IUserRepository";

interface IGetAllUsersUseCaseReply {
    users: User[]
}

export class GetAllUsersUseCase {
    constructor(private userRepository: IUserRepository) {}

    async handle(): Promise<IGetAllUsersUseCaseReply> {
        const users = await this.userRepository.getAllUsers()

        return {
            users
        }
    }
}