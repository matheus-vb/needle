import { Task } from "@prisma/client";
import { TaskRepository } from "../../repositories/Prisma/TaskRepository";

interface IGetWorkspaceTasksRequest{
    workspaceId: string;
}

interface IGetWorkspaceTasksResponse{
    tasks: Task[];
}

export class GetWorkspaceTasksUseCase{
    constructor(private taskRepository: TaskRepository){}

    async handle({
        workspaceId,
    }: IGetWorkspaceTasksRequest): Promise<IGetWorkspaceTasksResponse> {
        const tasks = this.taskRepository.findTasksByWorksapceId(workspaceId);

        return {
            tasks,
        }
    }
}