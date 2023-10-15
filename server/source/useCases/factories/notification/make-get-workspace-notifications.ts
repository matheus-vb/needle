import { NotificationRepository } from "../../../repositories/Prisma/NotificationRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { GetWorkspaceNotifications } from "../../notification/get-workspace-notifications";

export function makeGetWorkspaceNotifications() {
    const notificationRepository = new NotificationRepository()
    const workspaceRepository = new WorkspaceRepository()

    const useCase = new GetWorkspaceNotifications(notificationRepository, workspaceRepository)

    return useCase
}