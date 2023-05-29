import { FastifyInstance } from "fastify";
import { getTaskDocument } from "./get-task-document";
import { queryDocumentByTaskTag } from "./query-document-tag";
import { queryDocumentByTaskType } from "./query-document-type";
import { queryDocumentByTitle } from "./query-document-title";
import { updateDocument } from "./update-document";

export async function documentRoutes(app: FastifyInstance) {
    app.get('/document/task', getTaskDocument);
    app.get('/document/tag', queryDocumentByTaskTag);
    app.get('/document/title', queryDocumentByTitle)
    app.get('/document/type', queryDocumentByTaskType);
    app.patch('/document', updateDocument);
}