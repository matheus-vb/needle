import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { GetWorkspaceMembersByRoleUseCase } from "../../workspace/get-workspaces-members-by-role";

export function makeGetWorkspaceMembersUseCase(){
    const userRepository = new UserRepository();
    const useCase = new GetWorkspaceMembersByRoleUseCase(userRepository);

    return useCase;
}