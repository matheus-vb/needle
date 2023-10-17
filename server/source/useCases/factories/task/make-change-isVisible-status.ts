import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { ChangeIsVisibleStatus } from "../../task/change-isVisible-status";

export function makeChangeIsVisibleStatus(){
    const taskRepository = new TaskRepository();
    
    const useCase = new ChangeIsVisibleStatus(taskRepository);

    return useCase;
}