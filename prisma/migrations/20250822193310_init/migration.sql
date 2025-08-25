-- CreateEnum
CREATE TYPE "public"."UserTypeEnum" AS ENUM ('admin', 'professor');

-- CreateEnum
CREATE TYPE "public"."UserStatusEnum" AS ENUM ('active', 'inactive');

-- CreateTable
CREATE TABLE "public"."User" (
    "id" UUID NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "birthDate" TIMESTAMP(3),
    "phoneNumber" JSONB,
    "type" "public"."UserTypeEnum" NOT NULL,
    "status" "public"."UserStatusEnum" NOT NULL DEFAULT 'active',
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "public"."User"("email");
