import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { UserWorkspaceRepository } from "../../../repositories/Prisma/UserWorkspaceRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { CreateTaskUseCase } from "../../task/create-task";

export function makeCreateTaskUseCase() {
    const taskRepository = new TaskRepository();
    const userRepository = new UserRepository();
    const userWorkspaceRepository = new UserWorkspaceRepository()
    const docuementRepository = new DocumentRepository();
    const workspaceRepository = new WorkspaceRepository();
    const useCase = new CreateTaskUseCase(taskRepository, userRepository, workspaceRepository, userWorkspaceRepository, docuementRepository);
}