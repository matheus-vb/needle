import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { UpdateTaskUseCase } from "../../task/update-task";

export function makeUpdateTask(){
    const taskRepository = new TaskRepository()
    const documentRepository = new DocumentRepository()

    const useCase = new UpdateTaskUseCase(taskRepository, documentRepository)

    return useCase
}