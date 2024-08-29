-- CreateTable
CREATE TABLE "Profile" (
    "id" SERIAL NOT NULL,
    "firstName" TEXT,
    "middleName" TEXT,
    "lastName" TEXT,
    "secondLastName" TEXT,
    "birthDate" TIMESTAMP(3),
    "gender" TEXT,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DirectionType" (
    "id" SERIAL NOT NULL,
    "direccion" TEXT,

    CONSTRAINT "DirectionType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmploymentStatusType" (
    "id" SERIAL NOT NULL,
    "status" TEXT,

    CONSTRAINT "EmploymentStatusType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmploymentStatusRelation" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "employmentStatusTypeId" INTEGER NOT NULL,
    "companyName" TEXT,
    "position" TEXT,

    CONSTRAINT "EmploymentStatusRelation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EducationalStatusType" (
    "id" SERIAL NOT NULL,
    "status" TEXT,

    CONSTRAINT "EducationalStatusType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AcademyNames" (
    "id" SERIAL NOT NULL,
    "name" TEXT,

    CONSTRAINT "AcademyNames_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EducationalStatusRelation" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "educationalStatusTypeId" INTEGER NOT NULL,
    "academyId" INTEGER NOT NULL,
    "career" TEXT,

    CONSTRAINT "EducationalStatusRelation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProfileContactType" (
    "id" SERIAL NOT NULL,
    "type" TEXT,

    CONSTRAINT "ProfileContactType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProfileContact" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "typeId" INTEGER NOT NULL,
    "description" TEXT,

    CONSTRAINT "ProfileContact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FamilyRelationType" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "dirId" INTEGER NOT NULL,

    CONSTRAINT "FamilyRelationType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FamilyRelationProfile" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "anotherProfileId" INTEGER NOT NULL,
    "typeId" INTEGER NOT NULL,

    CONSTRAINT "FamilyRelationProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AffinityType" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "dirId" INTEGER NOT NULL,

    CONSTRAINT "AffinityType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AffinityRelationProfile" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "anotherProfileId" INTEGER NOT NULL,
    "affinityId" INTEGER NOT NULL,

    CONSTRAINT "AffinityRelationProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GeographicProfile" (
    "id" SERIAL NOT NULL,
    "lat" DOUBLE PRECISION,
    "long" DOUBLE PRECISION,
    "queryMap" TEXT,
    "city" TEXT,
    "state" TEXT,
    "country" TEXT,
    "description" TEXT,
    "houseNumber" TEXT,
    "profileId" INTEGER NOT NULL,

    CONSTRAINT "GeographicProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Users" (
    "id" SERIAL NOT NULL,
    "username" TEXT,
    "password" TEXT,
    "profileId" INTEGER NOT NULL,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StructureType" (
    "id" SERIAL NOT NULL,
    "type" TEXT,

    CONSTRAINT "StructureType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Structures" (
    "id" SERIAL NOT NULL,
    "typeId" INTEGER NOT NULL,
    "name" TEXT,
    "mainProfileId" INTEGER NOT NULL,

    CONSTRAINT "Structures_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StructureMembers" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "structureId" INTEGER NOT NULL,

    CONSTRAINT "StructureMembers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MemberType" (
    "id" SERIAL NOT NULL,
    "type" TEXT,

    CONSTRAINT "MemberType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MemberTypeRelationProfile" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "memberTypeId" INTEGER NOT NULL,

    CONSTRAINT "MemberTypeRelationProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MedicalConditionType" (
    "id" SERIAL NOT NULL,
    "type" TEXT,

    CONSTRAINT "MedicalConditionType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MedicalConditionRelationProfile" (
    "id" SERIAL NOT NULL,
    "typeId" INTEGER NOT NULL,
    "profileId" INTEGER NOT NULL,
    "description" TEXT,

    CONSTRAINT "MedicalConditionRelationProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ObservationTypes" (
    "id" SERIAL NOT NULL,
    "type" TEXT,

    CONSTRAINT "ObservationTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ObservationHistoryProfile" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "observationTypeId" INTEGER NOT NULL,
    "observation" TEXT,

    CONSTRAINT "ObservationHistoryProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BaptismRelationProfile" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "date" TIMESTAMP(3),
    "local" BOOLEAN,

    CONSTRAINT "BaptismRelationProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PetitionType" (
    "id" SERIAL NOT NULL,
    "type" TEXT,

    CONSTRAINT "PetitionType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PetitionCategories" (
    "id" SERIAL NOT NULL,
    "category" TEXT,

    CONSTRAINT "PetitionCategories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PetitionHistoryProfile" (
    "id" SERIAL NOT NULL,
    "profileId" INTEGER NOT NULL,
    "petitionTypeId" INTEGER NOT NULL,
    "petitionCategoryId" INTEGER NOT NULL,
    "description" TEXT,
    "petitionDate" TIMESTAMP(3),
    "completionDate" TIMESTAMP(3),

    CONSTRAINT "PetitionHistoryProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AttentionType" (
    "id" SERIAL NOT NULL,
    "type" TEXT,

    CONSTRAINT "AttentionType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AttentionHistory" (
    "id" SERIAL NOT NULL,
    "description" TEXT,
    "profileId" INTEGER NOT NULL,
    "attentionTypeId" INTEGER NOT NULL,
    "intermediaryProfileId" INTEGER NOT NULL,

    CONSTRAINT "AttentionHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IntelligenceMetaData" (
    "id" SERIAL NOT NULL,
    "databaseName" TEXT,
    "appUniqueId" TEXT,
    "installationDate" TIMESTAMP(3),
    "congregationName" TEXT,
    "contactNumber" TEXT,
    "juridicalInfo" TEXT,
    "syncUrl" TEXT,
    "lastVersionUpdate" TEXT,
    "lastUpdateDate" TIMESTAMP(3),
    "installHash" TEXT,

    CONSTRAINT "IntelligenceMetaData_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "GeographicProfile_profileId_key" ON "GeographicProfile"("profileId");

-- CreateIndex
CREATE UNIQUE INDEX "Users_profileId_key" ON "Users"("profileId");

-- CreateIndex
CREATE UNIQUE INDEX "AttentionHistory_intermediaryProfileId_key" ON "AttentionHistory"("intermediaryProfileId");

-- AddForeignKey
ALTER TABLE "EmploymentStatusRelation" ADD CONSTRAINT "EmploymentStatusRelation_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmploymentStatusRelation" ADD CONSTRAINT "EmploymentStatusRelation_employmentStatusTypeId_fkey" FOREIGN KEY ("employmentStatusTypeId") REFERENCES "EmploymentStatusType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EducationalStatusRelation" ADD CONSTRAINT "EducationalStatusRelation_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EducationalStatusRelation" ADD CONSTRAINT "EducationalStatusRelation_educationalStatusTypeId_fkey" FOREIGN KEY ("educationalStatusTypeId") REFERENCES "EducationalStatusType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EducationalStatusRelation" ADD CONSTRAINT "EducationalStatusRelation_academyId_fkey" FOREIGN KEY ("academyId") REFERENCES "AcademyNames"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProfileContact" ADD CONSTRAINT "ProfileContact_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProfileContact" ADD CONSTRAINT "ProfileContact_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "ProfileContactType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FamilyRelationType" ADD CONSTRAINT "FamilyRelationType_dirId_fkey" FOREIGN KEY ("dirId") REFERENCES "DirectionType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FamilyRelationProfile" ADD CONSTRAINT "ProfileToFamilyRelation_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FamilyRelationProfile" ADD CONSTRAINT "AnotherProfileToFamilyRelation_fkey" FOREIGN KEY ("anotherProfileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FamilyRelationProfile" ADD CONSTRAINT "FamilyRelationProfile_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "FamilyRelationType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AffinityType" ADD CONSTRAINT "AffinityType_dirId_fkey" FOREIGN KEY ("dirId") REFERENCES "DirectionType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AffinityRelationProfile" ADD CONSTRAINT "ProfileToAffinityRelation_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AffinityRelationProfile" ADD CONSTRAINT "AnotherProfileToAffinityRelation_anotherProfileId_fkey" FOREIGN KEY ("anotherProfileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AffinityRelationProfile" ADD CONSTRAINT "AffinityRelationProfile_affinityId_fkey" FOREIGN KEY ("affinityId") REFERENCES "AffinityType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GeographicProfile" ADD CONSTRAINT "GeographicProfile_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Users" ADD CONSTRAINT "Users_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Structures" ADD CONSTRAINT "Structures_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "StructureType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Structures" ADD CONSTRAINT "Structures_mainProfileId_fkey" FOREIGN KEY ("mainProfileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StructureMembers" ADD CONSTRAINT "StructureMembers_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StructureMembers" ADD CONSTRAINT "StructureMembers_structureId_fkey" FOREIGN KEY ("structureId") REFERENCES "Structures"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MemberTypeRelationProfile" ADD CONSTRAINT "MemberTypeRelationProfile_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MemberTypeRelationProfile" ADD CONSTRAINT "MemberTypeRelationProfile_memberTypeId_fkey" FOREIGN KEY ("memberTypeId") REFERENCES "MemberType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalConditionRelationProfile" ADD CONSTRAINT "MedicalConditionRelationProfile_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "MedicalConditionType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicalConditionRelationProfile" ADD CONSTRAINT "MedicalConditionRelationProfile_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ObservationHistoryProfile" ADD CONSTRAINT "ObservationHistoryProfile_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ObservationHistoryProfile" ADD CONSTRAINT "ObservationHistoryProfile_observationTypeId_fkey" FOREIGN KEY ("observationTypeId") REFERENCES "ObservationTypes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BaptismRelationProfile" ADD CONSTRAINT "BaptismRelationProfile_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PetitionHistoryProfile" ADD CONSTRAINT "PetitionHistoryProfile_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PetitionHistoryProfile" ADD CONSTRAINT "PetitionHistoryProfile_petitionTypeId_fkey" FOREIGN KEY ("petitionTypeId") REFERENCES "PetitionType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PetitionHistoryProfile" ADD CONSTRAINT "PetitionHistoryProfile_petitionCategoryId_fkey" FOREIGN KEY ("petitionCategoryId") REFERENCES "PetitionCategories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AttentionHistory" ADD CONSTRAINT "ProfileToAttentionHistory_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AttentionHistory" ADD CONSTRAINT "AttentionHistory_attentionTypeId_fkey" FOREIGN KEY ("attentionTypeId") REFERENCES "AttentionType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AttentionHistory" ADD CONSTRAINT "IntermediaryProfileToAttentionHistory_fkey" FOREIGN KEY ("intermediaryProfileId") REFERENCES "Profile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
