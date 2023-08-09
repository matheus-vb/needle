import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { GetRoleInWorkspaceUseCase } from "../../user/get-role";

export function makeGetRoleInWorkspaceUseCase() {
    const userRepository = new UserRepository()
    const useCase = new GetRoleInWorkspaceUseCase(userRepository)

    return useCase
}