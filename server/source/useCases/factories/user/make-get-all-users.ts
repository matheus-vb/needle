import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { GetAllUsersUseCase } from "../../user/get-all-users";

export function makeGetAllUsers() {
    const userRepository = new UserRepository()

    const useCase = new GetAllUsersUseCase(userRepository)

    return useCase
}