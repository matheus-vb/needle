-- CreateTable
CREATE TABLE "User_Task" (
    "userId" TEXT NOT NULL,
    "taskId" TEXT NOT NULL,

    CONSTRAINT "User_Task_pkey" PRIMARY KEY ("userId","taskId")
);

-- AddForeignKey
ALTER TABLE "User_Task" ADD CONSTRAINT "User_Task_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User_Task" ADD CONSTRAINT "User_Task_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
