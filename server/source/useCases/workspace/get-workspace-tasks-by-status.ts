import { Workspace, TaskStatus } from "@prisma/client";
import { ITaskRepository } from "../../repositories/ITaskRepository";

interface IGetWorkspaceTasksByStatusRequest{
    workspaceId: string
    status: TaskStatus
}

interface IGetWorkspaceTasksByStatusReply{
    finished: number
}

export class GetWorkspaceTasksByStatusUseCase{
    constructor(private taskRepository: ITaskRepository){}
    
    async handle({
        workspaceId,
        status
    }: IGetWorkspaceTasksByStatusRequest): Promise<IGetWorkspaceTasksByStatusReply>{        
        const finishedTasks = await this.taskRepository.findTasksByWorkspaceIdAndStatus(workspaceId, status);

        return {
            finished: finishedTasks
        }
    }
}