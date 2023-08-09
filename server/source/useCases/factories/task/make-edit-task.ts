import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { EditTaskUseCase } from "../../task/edit-task";

export function makeEditTask(){
    const taskRepository = new TaskRepository();
    const useCase = new EditTaskUseCase(taskRepository);
    
    return useCase
}