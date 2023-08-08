import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { EditTaskUseCase } from "../../task/edit-task";

export function makeEditTask(){
    const taskRepository = new TaskRepository();
    const userRepository = new UserRepository();
    const useCase = new EditTaskUseCase(taskRepository,userRepository);
    
    return useCase
}