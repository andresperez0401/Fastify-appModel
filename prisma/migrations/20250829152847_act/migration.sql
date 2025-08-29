/*
  Warnings:

  - You are about to drop the column `status` on the `User` table. All the data in the column will be lost.
  - Made the column `birthDate` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateEnum
CREATE TYPE "public"."ReactionReferenceTypesEnum" AS ENUM ('blog', 'message');

-- CreateEnum
CREATE TYPE "public"."ReactionTypesEnum" AS ENUM ('like');

-- CreateEnum
CREATE TYPE "public"."AdminTypeEnum" AS ENUM ('super_admin', 'admin', 'auditor', 'operator');

-- CreateEnum
CREATE TYPE "public"."TeachingLevelEnum" AS ENUM ('elementary_school', 'high_school', 'college', 'preeschool');

-- CreateEnum
CREATE TYPE "public"."NotificationTypeEnum" AS ENUM ('new_follower', 'new_message', 'new_event');

-- CreateEnum
CREATE TYPE "public"."GroupInvitationStatusEnum" AS ENUM ('pending', 'accepted', 'rejected');

-- CreateEnum
CREATE TYPE "public"."MemberPermissionsEnum" AS ENUM ('principal', 'admin', 'member');

-- CreateEnum
CREATE TYPE "public"."ReportReferenceTypesEnum" AS ENUM ('blog', 'group', 'message', 'user');

-- CreateEnum
CREATE TYPE "public"."ReportStatusEnum" AS ENUM ('pending', 'reviewed');

-- CreateEnum
CREATE TYPE "public"."SavedItemTypesEnum" AS ENUM ('blog', 'content', 'message');

-- CreateEnum
CREATE TYPE "public"."InstitutionTypeEnum" AS ENUM ('private', 'public');

-- CreateEnum
CREATE TYPE "public"."ReferralInvitationStatus" AS ENUM ('pending', 'completed');

-- CreateEnum
CREATE TYPE "public"."SourceTypeEnum" AS ENUM ('challenge', 'league');

-- CreateEnum
CREATE TYPE "public"."ActionTypeEnum" AS ENUM ('complete_content', 'follow_user', 'like_post', 'share_content', 'create_group', 'comment_post', 'rate_content', 'invite_new_user', 'complete_profile', 'first_post', 'join_group', 'write_blog', 'featured_post');

-- CreateEnum
CREATE TYPE "public"."ChallengeTypeEnum" AS ENUM ('one_time', 'daily', 'weekly', 'infinite');

-- CreateEnum
CREATE TYPE "public"."ChallengeStateEnum" AS ENUM ('in_progress', 'achieved', 'expired');

-- CreateEnum
CREATE TYPE "public"."EventTypeEnum" AS ENUM ('on_site', 'remote');

-- CreateEnum
CREATE TYPE "public"."EventOwnerTypeEnum" AS ENUM ('personal', 'general');

-- CreateEnum
CREATE TYPE "public"."InviteStatusEnum" AS ENUM ('accepted', 'rejected', 'pending');

-- CreateEnum
CREATE TYPE "public"."ContentModalityEnum" AS ENUM ('remote', 'on_site', 'hybrid');

-- CreateEnum
CREATE TYPE "public"."ContentDifficultyEnum" AS ENUM ('beginner', 'intermediate', 'experienced');

-- CreateEnum
CREATE TYPE "public"."ContentTypeEnum" AS ENUM ('course', 'document', 'presentation', 'video', 'GUAO');

-- CreateEnum
CREATE TYPE "public"."UserContentStatusEnum" AS ENUM ('in_progress', 'completed');

-- CreateEnum
CREATE TYPE "public"."BlogPostStatusEnum" AS ENUM ('published', 'draft');

-- CreateEnum
CREATE TYPE "public"."NotificationReferenceTypeEnum" AS ENUM ('user', 'message', 'event');

-- CreateEnum
CREATE TYPE "public"."RedeemedItemStatus" AS ENUM ('active', 'expired', 'used');

-- CreateEnum
CREATE TYPE "public"."StoreItemTypesEnum" AS ENUM ('coupon', 'video_conference', 'system_content');

-- CreateEnum
CREATE TYPE "public"."UserNotificationStatusEnum" AS ENUM ('unread', 'read', 'hidden');

-- CreateEnum
CREATE TYPE "public"."BlogStructureTypeEnum" AS ENUM ('title', 'subtitle', 'paragraph', 'image', 'quote', 'video');

-- CreateEnum
CREATE TYPE "public"."GUAOLevelEnum" AS ENUM ('primaria', 'media', 'varios');

-- AlterTable
ALTER TABLE "public"."User" DROP COLUMN "status",
ALTER COLUMN "birthDate" SET NOT NULL;

-- DropEnum
DROP TYPE "public"."UserStatusEnum";

-- CreateTable
CREATE TABLE "public"."Admin" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "type" "public"."AdminTypeEnum" NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TeachingResume" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "teachingLevels" "public"."TeachingLevelEnum"[],
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TeachingResume_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Professor" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "profilePicture" JSONB,
    "bio" TEXT,
    "dni" TEXT NOT NULL,
    "dniType" TEXT NOT NULL,
    "addressId" UUID NOT NULL,
    "resumeId" UUID NOT NULL,
    "userSocialsId" UUID NOT NULL,
    "notificationPreferencesId" UUID NOT NULL,
    "privacyPreferencesId" UUID NOT NULL,
    "referralCode" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Professor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."PrivacyPreferences" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "privateProfile" BOOLEAN NOT NULL DEFAULT false,
    "showContactInfo" BOOLEAN NOT NULL DEFAULT true,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PrivacyPreferences_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."NotificationPreferences" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "promotions" BOOLEAN NOT NULL DEFAULT true,
    "allowedNotifications" "public"."NotificationTypeEnum"[],
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "NotificationPreferences_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserSocials" (
    "id" UUID NOT NULL,
    "instagram" TEXT,
    "x" TEXT,
    "facebook" TEXT,
    "linkedIn" TEXT,
    "medium" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserSocials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."GUAOGrade" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "level" "public"."GUAOLevelEnum" NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GUAOGrade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."GUAOSubject" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "gradeId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GUAOSubject_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."GUAOContent" (
    "id" UUID NOT NULL,
    "quarter" INTEGER NOT NULL,
    "subjectId" UUID NOT NULL,
    "content" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GUAOContent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Topic" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Topic_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserTopic" (
    "userId" UUID NOT NULL,
    "topicId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserTopic_pkey" PRIMARY KEY ("userId","topicId")
);

-- CreateTable
CREATE TABLE "public"."Tag" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "topicId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Group" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "groupImage" JSONB,
    "description" TEXT NOT NULL,
    "private" BOOLEAN NOT NULL DEFAULT false,
    "invitationsEnabled" BOOLEAN NOT NULL DEFAULT true,
    "groupFounderId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."GroupTopic" (
    "groupId" UUID NOT NULL,
    "topicId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GroupTopic_pkey" PRIMARY KEY ("groupId","topicId")
);

-- CreateTable
CREATE TABLE "public"."GroupMember" (
    "memberId" UUID NOT NULL,
    "groupId" UUID NOT NULL,
    "permissions" "public"."MemberPermissionsEnum" NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GroupMember_pkey" PRIMARY KEY ("memberId","groupId")
);

-- CreateTable
CREATE TABLE "public"."GroupInvitation" (
    "userId" UUID NOT NULL,
    "groupId" UUID NOT NULL,
    "status" "public"."GroupInvitationStatusEnum" NOT NULL DEFAULT 'pending',
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GroupInvitation_pkey" PRIMARY KEY ("userId","groupId")
);

-- CreateTable
CREATE TABLE "public"."Message" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "groupId" UUID NOT NULL,
    "message" TEXT NOT NULL,
    "attachments" JSONB,
    "parentMessageId" UUID,
    "stats" JSONB,
    "featured" BOOLEAN NOT NULL DEFAULT false,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Reaction" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "type" "public"."ReactionTypesEnum" NOT NULL,
    "referenceType" "public"."ReactionReferenceTypesEnum" NOT NULL,
    "referenceId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Reaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Report" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "referenceType" "public"."ReportReferenceTypesEnum" NOT NULL,
    "referenceId" UUID NOT NULL,
    "number" TEXT NOT NULL,
    "status" "public"."ReportStatusEnum" NOT NULL DEFAULT 'pending',
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Report_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."SavedItem" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "referenceType" "public"."SavedItemTypesEnum" NOT NULL,
    "referenceId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SavedItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Country" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "iso" TEXT NOT NULL,
    "phonePrefix" TEXT NOT NULL,
    "flag" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Country_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."State" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "countryId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "State_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."City" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "stateId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "City_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Address" (
    "id" UUID NOT NULL,
    "countryId" UUID NOT NULL,
    "stateId" UUID NOT NULL,
    "cityId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TeachingResumeInstitution" (
    "teachingResumeId" UUID NOT NULL,
    "institutionId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TeachingResumeInstitution_pkey" PRIMARY KEY ("teachingResumeId","institutionId")
);

-- CreateTable
CREATE TABLE "public"."Institution" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "countryId" UUID NOT NULL,
    "institutionType" "public"."InstitutionTypeEnum" NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Institution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TeachingResumeSubject" (
    "teachingResumeId" UUID NOT NULL,
    "subjectId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TeachingResumeSubject_pkey" PRIMARY KEY ("teachingResumeId","subjectId")
);

-- CreateTable
CREATE TABLE "public"."Subject" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "institutionLevel" "public"."TeachingLevelEnum" NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Subject_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserReferral" (
    "id" UUID NOT NULL,
    "referrerId" UUID NOT NULL,
    "referredEmail" TEXT NOT NULL,
    "referralToken" TEXT NOT NULL,
    "referredId" UUID,
    "status" "public"."ReferralInvitationStatus" NOT NULL DEFAULT 'pending',
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserReferral_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Follow" (
    "followerId" UUID NOT NULL,
    "followedId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Follow_pkey" PRIMARY KEY ("followerId","followedId")
);

-- CreateTable
CREATE TABLE "public"."Content" (
    "id" UUID NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "syllabus" TEXT,
    "thumbnail" JSONB,
    "type" "public"."ContentTypeEnum" NOT NULL,
    "modality" "public"."ContentModalityEnum",
    "difficulty" "public"."ContentDifficultyEnum",
    "courseReferenceId" TEXT,
    "attachments" JSONB NOT NULL,
    "topics" JSONB NOT NULL,
    "tags" JSONB NOT NULL,
    "redemptionRequired" BOOLEAN NOT NULL DEFAULT false,
    "rewardXP" INTEGER,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Content_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserContent" (
    "userId" UUID NOT NULL,
    "contentId" UUID NOT NULL,
    "status" "public"."UserContentStatusEnum" NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserContent_pkey" PRIMARY KEY ("userId","contentId")
);

-- CreateTable
CREATE TABLE "public"."Rating" (
    "userId" UUID NOT NULL,
    "contentId" UUID NOT NULL,
    "rating" DECIMAL(2,1) NOT NULL,
    "testimony" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Rating_pkey" PRIMARY KEY ("userId","contentId")
);

-- CreateTable
CREATE TABLE "public"."League" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "image" JSONB NOT NULL,
    "badge" JSONB NOT NULL,
    "minExperience" INTEGER NOT NULL,
    "experienceReward" INTEGER NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "League_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."LeagueRestriction" (
    "id" UUID NOT NULL,
    "contentId" UUID NOT NULL,
    "minLeagueId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LeagueRestriction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserExperience" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "currentXP" INTEGER NOT NULL DEFAULT 0,
    "currentLeagueId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserExperience_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."HExperience" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "sourceType" "public"."SourceTypeEnum" NOT NULL,
    "earnedXP" INTEGER NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "HExperience_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."HUserLeague" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "finalXP" INTEGER NOT NULL,
    "league" JSONB NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "HUserLeague_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Challenge" (
    "id" UUID NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "experienceReward" INTEGER,
    "creditsReward" INTEGER,
    "type" "public"."ChallengeTypeEnum" NOT NULL,
    "actionType" "public"."ActionTypeEnum" NOT NULL,
    "targetCount" INTEGER NOT NULL DEFAULT 1,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Challenge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ChallengeCycle" (
    "id" UUID NOT NULL,
    "challengeId" UUID NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3),
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ChallengeCycle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserChallenge" (
    "userId" UUID NOT NULL,
    "cycleId" UUID NOT NULL,
    "progress" INTEGER NOT NULL DEFAULT 0,
    "state" "public"."ChallengeStateEnum" NOT NULL DEFAULT 'in_progress',
    "achivedAt" TIMESTAMP(3),
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserChallenge_pkey" PRIMARY KEY ("userId","cycleId")
);

-- CreateTable
CREATE TABLE "public"."Badge" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "image" JSONB NOT NULL,
    "actionType" "public"."ActionTypeEnum" NOT NULL,
    "targetCount" INTEGER NOT NULL DEFAULT 1,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Badge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserBadge" (
    "userId" UUID NOT NULL,
    "badgeId" UUID NOT NULL,
    "progress" INTEGER NOT NULL DEFAULT 0,
    "earned" BOOLEAN NOT NULL DEFAULT false,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserBadge_pkey" PRIMARY KEY ("userId","badgeId")
);

-- CreateTable
CREATE TABLE "public"."Event" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "link" TEXT,
    "location" TEXT,
    "ownerId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserEvent" (
    "eventId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "inviteStatus" "public"."InviteStatusEnum" NOT NULL DEFAULT 'pending',
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserEvent_pkey" PRIMARY KEY ("eventId","userId")
);

-- CreateTable
CREATE TABLE "public"."StoreItem" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "image" JSONB,
    "type" "public"."StoreItemTypesEnum" NOT NULL,
    "price" INTEGER NOT NULL,
    "link" TEXT,
    "contentId" UUID,
    "expireDate" TIMESTAMP(3),
    "daysToExpire" INTEGER,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "StoreItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Cart" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Cart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CartItem" (
    "cartId" UUID NOT NULL,
    "storeItemId" UUID NOT NULL,
    "priceAtAdd" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CartItem_pkey" PRIMARY KEY ("cartId","storeItemId")
);

-- CreateTable
CREATE TABLE "public"."RedeemedItem" (
    "userId" UUID NOT NULL,
    "itemId" UUID NOT NULL,
    "redemptionCode" TEXT NOT NULL,
    "expireDate" TIMESTAMP(3) NOT NULL,
    "status" "public"."RedeemedItemStatus" NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RedeemedItem_pkey" PRIMARY KEY ("userId","itemId")
);

-- CreateTable
CREATE TABLE "public"."BlogPost" (
    "id" UUID NOT NULL,
    "slug" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "summary" TEXT NOT NULL,
    "thumbnail" JSONB,
    "userId" UUID NOT NULL,
    "structure" JSONB NOT NULL,
    "status" "public"."BlogPostStatusEnum" NOT NULL,
    "topicsRelated" JSONB NOT NULL,
    "private" BOOLEAN NOT NULL DEFAULT false,
    "readTime" INTEGER,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BlogPost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Notification" (
    "id" UUID NOT NULL,
    "type" "public"."NotificationTypeEnum" NOT NULL,
    "content" TEXT NOT NULL,
    "referenceType" "public"."NotificationReferenceTypeEnum" NOT NULL,
    "referenceId" UUID NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UserNotification" (
    "userId" UUID NOT NULL,
    "notificationId" UUID NOT NULL,
    "status" "public"."UserNotificationStatusEnum" NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserNotification_pkey" PRIMARY KEY ("userId","notificationId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_userId_key" ON "public"."Admin"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "TeachingResume_userId_key" ON "public"."TeachingResume"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Professor_userId_key" ON "public"."Professor"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Professor_addressId_key" ON "public"."Professor"("addressId");

-- CreateIndex
CREATE UNIQUE INDEX "Professor_resumeId_key" ON "public"."Professor"("resumeId");

-- CreateIndex
CREATE UNIQUE INDEX "Professor_userSocialsId_key" ON "public"."Professor"("userSocialsId");

-- CreateIndex
CREATE UNIQUE INDEX "Professor_notificationPreferencesId_key" ON "public"."Professor"("notificationPreferencesId");

-- CreateIndex
CREATE UNIQUE INDEX "Professor_privacyPreferencesId_key" ON "public"."Professor"("privacyPreferencesId");

-- CreateIndex
CREATE UNIQUE INDEX "Professor_referralCode_key" ON "public"."Professor"("referralCode");

-- CreateIndex
CREATE UNIQUE INDEX "Professor_dni_dniType_key" ON "public"."Professor"("dni", "dniType");

-- CreateIndex
CREATE UNIQUE INDEX "PrivacyPreferences_userId_key" ON "public"."PrivacyPreferences"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationPreferences_userId_key" ON "public"."NotificationPreferences"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "GUAOGrade_name_level_key" ON "public"."GUAOGrade"("name", "level");

-- CreateIndex
CREATE INDEX "GUAOSubject_gradeId_idx" ON "public"."GUAOSubject"("gradeId");

-- CreateIndex
CREATE UNIQUE INDEX "GUAOSubject_gradeId_name_key" ON "public"."GUAOSubject"("gradeId", "name");

-- CreateIndex
CREATE INDEX "GUAOContent_subjectId_idx" ON "public"."GUAOContent"("subjectId");

-- CreateIndex
CREATE UNIQUE INDEX "Topic_name_key" ON "public"."Topic"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Tag_topicId_name_key" ON "public"."Tag"("topicId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "Country_name_key" ON "public"."Country"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Country_iso_key" ON "public"."Country"("iso");

-- CreateIndex
CREATE UNIQUE INDEX "State_countryId_name_key" ON "public"."State"("countryId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "City_stateId_name_key" ON "public"."City"("stateId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "UserReferral_referralToken_key" ON "public"."UserReferral"("referralToken");

-- CreateIndex
CREATE UNIQUE INDEX "UserExperience_userId_key" ON "public"."UserExperience"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Cart_userId_key" ON "public"."Cart"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "RedeemedItem_redemptionCode_key" ON "public"."RedeemedItem"("redemptionCode");

-- CreateIndex
CREATE UNIQUE INDEX "BlogPost_slug_key" ON "public"."BlogPost"("slug");

-- AddForeignKey
ALTER TABLE "public"."Admin" ADD CONSTRAINT "Admin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeachingResume" ADD CONSTRAINT "TeachingResume_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Professor" ADD CONSTRAINT "Professor_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Professor" ADD CONSTRAINT "Professor_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "public"."Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Professor" ADD CONSTRAINT "Professor_resumeId_fkey" FOREIGN KEY ("resumeId") REFERENCES "public"."TeachingResume"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Professor" ADD CONSTRAINT "Professor_userSocialsId_fkey" FOREIGN KEY ("userSocialsId") REFERENCES "public"."UserSocials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Professor" ADD CONSTRAINT "Professor_notificationPreferencesId_fkey" FOREIGN KEY ("notificationPreferencesId") REFERENCES "public"."NotificationPreferences"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Professor" ADD CONSTRAINT "Professor_privacyPreferencesId_fkey" FOREIGN KEY ("privacyPreferencesId") REFERENCES "public"."PrivacyPreferences"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."PrivacyPreferences" ADD CONSTRAINT "PrivacyPreferences_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."NotificationPreferences" ADD CONSTRAINT "NotificationPreferences_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."GUAOSubject" ADD CONSTRAINT "GUAOSubject_gradeId_fkey" FOREIGN KEY ("gradeId") REFERENCES "public"."GUAOGrade"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."GUAOContent" ADD CONSTRAINT "GUAOContent_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES "public"."GUAOSubject"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserTopic" ADD CONSTRAINT "UserTopic_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserTopic" ADD CONSTRAINT "UserTopic_topicId_fkey" FOREIGN KEY ("topicId") REFERENCES "public"."Topic"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Tag" ADD CONSTRAINT "Tag_topicId_fkey" FOREIGN KEY ("topicId") REFERENCES "public"."Topic"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Group" ADD CONSTRAINT "Group_groupFounderId_fkey" FOREIGN KEY ("groupFounderId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."GroupTopic" ADD CONSTRAINT "GroupTopic_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "public"."Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."GroupTopic" ADD CONSTRAINT "GroupTopic_topicId_fkey" FOREIGN KEY ("topicId") REFERENCES "public"."Topic"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."GroupMember" ADD CONSTRAINT "GroupMember_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."GroupMember" ADD CONSTRAINT "GroupMember_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "public"."Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."GroupInvitation" ADD CONSTRAINT "GroupInvitation_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."GroupInvitation" ADD CONSTRAINT "GroupInvitation_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "public"."Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Message" ADD CONSTRAINT "Message_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Message" ADD CONSTRAINT "Message_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "public"."Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Message" ADD CONSTRAINT "Message_parentMessageId_fkey" FOREIGN KEY ("parentMessageId") REFERENCES "public"."Message"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Reaction" ADD CONSTRAINT "Reaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Report" ADD CONSTRAINT "Report_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SavedItem" ADD CONSTRAINT "SavedItem_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."State" ADD CONSTRAINT "State_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "public"."Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."City" ADD CONSTRAINT "City_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES "public"."State"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Address" ADD CONSTRAINT "Address_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "public"."Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Address" ADD CONSTRAINT "Address_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES "public"."State"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Address" ADD CONSTRAINT "Address_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "public"."City"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeachingResumeInstitution" ADD CONSTRAINT "TeachingResumeInstitution_teachingResumeId_fkey" FOREIGN KEY ("teachingResumeId") REFERENCES "public"."TeachingResume"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeachingResumeInstitution" ADD CONSTRAINT "TeachingResumeInstitution_institutionId_fkey" FOREIGN KEY ("institutionId") REFERENCES "public"."Institution"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Institution" ADD CONSTRAINT "Institution_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "public"."Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeachingResumeSubject" ADD CONSTRAINT "TeachingResumeSubject_teachingResumeId_fkey" FOREIGN KEY ("teachingResumeId") REFERENCES "public"."TeachingResume"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TeachingResumeSubject" ADD CONSTRAINT "TeachingResumeSubject_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES "public"."Subject"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserReferral" ADD CONSTRAINT "UserReferral_referrerId_fkey" FOREIGN KEY ("referrerId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserReferral" ADD CONSTRAINT "UserReferral_referredId_fkey" FOREIGN KEY ("referredId") REFERENCES "public"."User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Follow" ADD CONSTRAINT "Follow_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Follow" ADD CONSTRAINT "Follow_followedId_fkey" FOREIGN KEY ("followedId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserContent" ADD CONSTRAINT "UserContent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserContent" ADD CONSTRAINT "UserContent_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "public"."Content"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Rating" ADD CONSTRAINT "Rating_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Rating" ADD CONSTRAINT "Rating_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "public"."Content"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."LeagueRestriction" ADD CONSTRAINT "LeagueRestriction_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "public"."Content"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."LeagueRestriction" ADD CONSTRAINT "LeagueRestriction_minLeagueId_fkey" FOREIGN KEY ("minLeagueId") REFERENCES "public"."League"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserExperience" ADD CONSTRAINT "UserExperience_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserExperience" ADD CONSTRAINT "UserExperience_currentLeagueId_fkey" FOREIGN KEY ("currentLeagueId") REFERENCES "public"."League"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."HExperience" ADD CONSTRAINT "HExperience_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."HUserLeague" ADD CONSTRAINT "HUserLeague_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ChallengeCycle" ADD CONSTRAINT "ChallengeCycle_challengeId_fkey" FOREIGN KEY ("challengeId") REFERENCES "public"."Challenge"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserChallenge" ADD CONSTRAINT "UserChallenge_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserChallenge" ADD CONSTRAINT "UserChallenge_cycleId_fkey" FOREIGN KEY ("cycleId") REFERENCES "public"."ChallengeCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserBadge" ADD CONSTRAINT "UserBadge_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserBadge" ADD CONSTRAINT "UserBadge_badgeId_fkey" FOREIGN KEY ("badgeId") REFERENCES "public"."Badge"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Event" ADD CONSTRAINT "Event_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserEvent" ADD CONSTRAINT "UserEvent_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "public"."Event"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserEvent" ADD CONSTRAINT "UserEvent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."StoreItem" ADD CONSTRAINT "StoreItem_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "public"."Content"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Cart" ADD CONSTRAINT "Cart_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CartItem" ADD CONSTRAINT "CartItem_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "public"."Cart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CartItem" ADD CONSTRAINT "CartItem_storeItemId_fkey" FOREIGN KEY ("storeItemId") REFERENCES "public"."StoreItem"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RedeemedItem" ADD CONSTRAINT "RedeemedItem_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."RedeemedItem" ADD CONSTRAINT "RedeemedItem_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "public"."StoreItem"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."BlogPost" ADD CONSTRAINT "BlogPost_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserNotification" ADD CONSTRAINT "UserNotification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UserNotification" ADD CONSTRAINT "UserNotification_notificationId_fkey" FOREIGN KEY ("notificationId") REFERENCES "public"."Notification"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
