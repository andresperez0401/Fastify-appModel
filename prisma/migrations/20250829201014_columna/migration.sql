ALTER TABLE "public"."Subject"
ALTER COLUMN "institutionLevel" SET DATA TYPE "public"."TeachingLevelEnum"[]
USING ARRAY["institutionLevel"];