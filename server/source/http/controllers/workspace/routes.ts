import { FastifyInstance } from "fastify";
import { createWorkspace } from "./create-workspace";
import { joinWorkspace } from "./join-workspace";
import { getWorkspaceMembers } from "./get-workspaces-members";
import { listUserWorkspaces } from "./list-user-workspaces";
import { getWorkspaceDocuments } from "./get-workspace-documents";
import { getAllMembers } from "./get-all-members";
import { deleteWorkspace } from "./delete-workspace";
import { getWorkspaceTasksByStatus } from "./get-workspace-tasks-by-status";
import { inviteMember } from "./invite-member";

export async function workspaceRoutes(app: FastifyInstance) {
    app.post('/workspace', createWorkspace);
    app.post('/join', joinWorkspace);
    app.get('/members/:workspaceId/:role', getWorkspaceMembers);
    app.get('/workspace/list/:id', listUserWorkspaces);
    app.get('/workspace/:workspaceId', getWorkspaceDocuments);
    app.get('/members/:workspaceId', getAllMembers)
    app.delete('/workspace/delete/:accessCode', deleteWorkspace);
    app.get('/task/:workspaceId/:status', getWorkspaceTasksByStatus);
    app.post('/invite', inviteMember);
}
