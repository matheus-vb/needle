import { Task } from "@prisma/client"
import { ITaskRepository } from "../../repositories/ITaskRepository"
import { BadRequest } from "../errors/BadRequest"

interface IChangeIsVisibleStatusRequest {
    taskId: string,
    isVisible: boolean
}

interface IChangeIsVisibleStatusReply{
    task: Task
}

export class ChangeIsVisibleStatus{
    constructor(private taskRepository: ITaskRepository) {}

    async handle({taskId, isVisible}: IChangeIsVisibleStatusRequest): Promise<IChangeIsVisibleStatusReply>{
        const task = await this.taskRepository.findById(taskId)

        if(!task){
            throw new BadRequest();
        }

        const updatedTask = await this.taskRepository.updateIsVisibleStatus(taskId, isVisible);

        return{
            task: updatedTask
        }
    }
}