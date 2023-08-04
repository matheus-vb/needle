import { User } from "@prisma/client";
import { IUserRepository } from "../../repositories/IUserRepository";
import { UserNotFound } from "../errors/UserNotFound";

interface IUpdateDeviceTokenUseCaseRequest {
    userId: string
    deviceToken: string
}

interface IUpdateDeviceTokenUseCaseReply {
    user: User
}

export class UpdateDeviceTokenUseCase {
    constructor(private userRepository: IUserRepository) {}

    async handle({
        userId,
        deviceToken
    }: IUpdateDeviceTokenUseCaseRequest): Promise<IUpdateDeviceTokenUseCaseReply> {
        let user = await this.userRepository.findById(userId);
        if(!user) {
            throw new UserNotFound()
        }

        user = await this.userRepository.updateDeviceToken(userId, deviceToken)

        return {
            user,
        }
    }
}