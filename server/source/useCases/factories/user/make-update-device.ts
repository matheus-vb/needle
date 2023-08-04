import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { UpdateDeviceTokenUseCase } from "../../user/update-device";

export function makeUpdateDeviceTokenUseCase() {
    const userRepository = new UserRepository()
    const useCase = new UpdateDeviceTokenUseCase(userRepository)

    return useCase
}