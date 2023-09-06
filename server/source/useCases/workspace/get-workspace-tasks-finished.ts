import { Workspace, TaskStatus } from "@prisma/client";
import { ITaskRepository } from "../../repositories/ITaskRepository";

interface IGetWorkspaceTasksFinishedRequest{
    workspaceId: string
    status: TaskStatus
}

interface IGetWorkspaceTasksFinishedReply{
    finished: number
}

export class GetWorkspaceMembersByRoleUseCase{
    constructor(private taskRepository: ITaskRepository){}
    
    async handle({
        workspaceId,
        status
    }: IGetWorkspaceTasksFinishedRequest): Promise<IGetWorkspaceTasksFinishedReply>{        
        const finishedTasks = await this.taskRepository.findNumOfTasksByWorkspaceIdAndStatus(workspaceId, status);

        return {
            finished: finishedTasks
        }
    }
}