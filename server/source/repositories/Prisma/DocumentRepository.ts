import { Prisma, Document, Task } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { IDocumentRepository } from "../IDocumentRepository";

export class DocumentRepository implements IDocumentRepository {
    async create(data: Prisma.DocumentCreateInput) {
        const document = await prisma.document.create({
            data,
        })
        return document;
    }

    async findDocumentByTask(task: Task) {
        const document = await prisma.document.findFirst({
            where: {
                task,
            }
        })

        return document;
    }
}