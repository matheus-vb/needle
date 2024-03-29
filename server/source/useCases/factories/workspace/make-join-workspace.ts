import { NotificationRepository } from "../../../repositories/Prisma/NotificationRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { UserWorkspaceRepository } from "../../../repositories/Prisma/UserWorkspaceRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { JoinWorkspaceUseCase } from "../../workspace/join-workspace";

export function makeJoinWorkspaceUseCase() {
    const userRepository = new UserRepository();
    const userWorkspaceRepository = new UserWorkspaceRepository();
    const workspaceRepository = new WorkspaceRepository();
    const notificationRepository = new NotificationRepository();
    const useCase = new JoinWorkspaceUseCase(userRepository, workspaceRepository, userWorkspaceRepository, notificationRepository);

    return useCase;
}