import { TaskTag } from "@prisma/client";
import { ITaskRepository } from "../../repositories/ITaskRepository";
import { ITagRepository } from "../../repositories/ITagRepository";
import { BadRequest } from "../errors/BadRequest";

interface IAddTagsToTaskUseCaseRequest {
    taskId: string,
    tag: string
}

interface IAddTagsToTaskUseCaseReply {
    taskTag: TaskTag
}

export class AddTagsToTaskUseCase {
    constructor(private taskRepository: ITaskRepository, private tagRepository: ITagRepository) {}

    async handle({
        taskId,
        tag,
    }: IAddTagsToTaskUseCaseRequest): Promise<IAddTagsToTaskUseCaseReply> {
        const task = await this.taskRepository.findById(taskId);
        if(!task) {
            throw new BadRequest();
        }

        const taskTag = await this.tagRepository.create({
            taskId,
            tag
        })

        return {
            taskTag,
        }
    }
}