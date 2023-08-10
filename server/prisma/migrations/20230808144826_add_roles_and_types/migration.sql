/*
  Warnings:

  - The values [MEMBER] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('PRODUCT_MANAGER', 'DESIGNER', 'DEVELOPER', 'QA', 'BUSINESS', 'DEVOPS', 'SALES', 'MARKETING');
ALTER TABLE "User_Workspace" ALTER COLUMN "userRole" TYPE "Role_new" USING ("userRole"::text::"Role_new");
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "Role_old";
COMMIT;

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "TaskType" ADD VALUE 'BUSINESS';
ALTER TYPE "TaskType" ADD VALUE 'DEVOPS';
ALTER TYPE "TaskType" ADD VALUE 'SALES';
ALTER TYPE "TaskType" ADD VALUE 'MARKETING';
ALTER TYPE "TaskType" ADD VALUE 'QA';
