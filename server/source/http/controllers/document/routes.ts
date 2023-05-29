import { FastifyInstance } from "fastify";
import { getTaskDocument } from "./get-task-document";
import { queryDocumentByTaskTag } from "./query-document-tag";
import { queryDocumentByTaskType } from "./query-document-type";
import { queryDocumentByTitle } from "./query-document-title";
import { updateDocument } from "./update-document";

export async function documentRoutes(app: FastifyInstance) {
    app.get('/document/task/:taskId', getTaskDocument);
    app.get('/document/tag/:tag/:accessCode', queryDocumentByTaskTag);
    app.get('/document/title/:quer/:accessCode', queryDocumentByTitle)
    app.get('/document/type/:type/:accessCode', queryDocumentByTaskType);
    app.patch('/document', updateDocument);
}