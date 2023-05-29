import { Prisma, Document, Task, TaskType } from "@prisma/client";
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

    async queryDocumentByTitle(query: string, accessCode: string) {
        const documents = await prisma.document.findMany({
            where: {
                title: {
                    contains: query,
                },
                task:{
                    workspace:{
                        accessCode: accessCode
                    }
                }
            }
        })

        return documents;
    }

    async queryDocumentByTaskTag(tag: string, accessCode: string) {
        const documents = await prisma.document.findMany({
            where :{
                task: {
                    TaskTag: {
                        some:{
                            tag,
                        }
                    },
                    workspace:{
                        accessCode: accessCode
                    }
                }
            }
        })

        return documents;
    }

    async queryDocumentByType(type: TaskType) {
        const documents = await prisma.document.findMany({
            where: {
                task: {
                    type,
                }
            }
        })

        return documents;
    }

    async updateDocument(id: string, text: string) {
        const document = await prisma.document.update({
            where: {
                id,
            },
            data: {
                text,
            }
        })

        return document;
    }
}