import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { DeleteTaskUseCase } from "../../task/delete-task";

export function makeDeleteTask(){
    const taskRepository = new TaskRepository();
    const documentRepository = new DocumentRepository();
    const useCase = new DeleteTaskUseCase(taskRepository, documentRepository);

    return useCase
}