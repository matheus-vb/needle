import { User } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"
import { UserRepository } from "../../repositories/Prisma/UserRepository"
import { UserNotFound } from "../errors/UserNotFound"

interface IDeleteUserRequest {
    userId: string
}

interface IDeleteUserReply{
    user: User
}

export class DeleteUserUseCase{
    constructor(private userRepository: IUserRepository) {}

    async handle({
        userId
    }: IDeleteUserRequest): Promise<IDeleteUserReply>{
        const user = await this.userRepository.findById(userId)

        if(!user){
            throw new UserNotFound();
        }

        const deletedUser = await this.userRepository.deleteUser(userId);
        
        return {
            user: deletedUser
        }
    }
}