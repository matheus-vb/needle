import { FastifyInstance } from "fastify";
import { getTaskDocument } from "./get-task-document";
import { queryDocumentByTaskTag } from "./query-document-tag";
import { queryDocumentByTaskType } from "./query-document-type";
import { queryDocumentByTitle } from "./query-document-title";
import { updateDocument } from "./update-document";

export async function documentRoutes(app: FastifyInstance) {
    app.get('/document/task/:taskId', getTaskDocument);
    app.get('/document/tag/:accessCode/:tag', queryDocumentByTaskTag);
    app.get('/document/title/:accessCode/:query', queryDocumentByTitle);
    app.get('/document/type/:accessCode/:type', queryDocumentByTaskType);
    app.patch('/document', updateDocument);
}