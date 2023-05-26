import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { GetTaskDocumentationUseCase } from "../../document/get-task-document";

export function makeGetTaskDocuementUseCase() {
    const docuementRepository = new DocumentRepository();
    const taskRepository = new TaskRepository();
    const useCase = new GetTaskDocumentationUseCase(taskRepository, docuementRepository);

    return useCase;
}