import { FastifyInstance } from "fastify";
import { createWorkspace } from "./create-workspace";
import { joinWorkspace } from "./join-workspace";
import { getWorkspaceMembers } from "./get-workspaces-members";
import { listUserWorkspaces } from "./list-user-workspaces";
import { getWorkspaceDocuments } from "./get-workspace-documents";

export async function workspaceRoutes(app: FastifyInstance) {
    app.post('/workspace', createWorkspace);
    app.post('/join', joinWorkspace);
    app.get('/members/:workspaceId/:role', getWorkspaceMembers);
    app.get('/workspace/list/:id', listUserWorkspaces);
    app.get('/workspace/:workspaceId', getWorkspaceDocuments);
}