import { PrismaClient, TeachingLevelEnum } from '@prisma/client';

const subjects: { name: string; institutionLevel: TeachingLevelEnum[] }[] = [
    { name: 'Castellano', institutionLevel: [TeachingLevelEnum.elementary_school, TeachingLevelEnum.high_school] },
    { name: 'Matemática', institutionLevel: [TeachingLevelEnum.elementary_school, TeachingLevelEnum.high_school] },
    { name: 'Ciencias naturales', institutionLevel: [TeachingLevelEnum.elementary_school, TeachingLevelEnum.high_school] },
    { name: 'Ciencias sociales', institutionLevel: [TeachingLevelEnum.elementary_school] },
    { name: 'Educación estética', institutionLevel: [TeachingLevelEnum.elementary_school] },
    { name: 'Educación física', institutionLevel: [TeachingLevelEnum.elementary_school, TeachingLevelEnum.high_school] },
    { name: 'Educación sexual', institutionLevel: [TeachingLevelEnum.elementary_school] },
    { name: 'Geografía, historia y ciudadanía', institutionLevel: [TeachingLevelEnum.high_school] },
    { name: 'Arte y patrimonio', institutionLevel: [TeachingLevelEnum.high_school] },
    { name: 'Química', institutionLevel: [TeachingLevelEnum.high_school] },
    { name: 'Física', institutionLevel: [TeachingLevelEnum.high_school] },
    { name: 'Ciencias de la tierra', institutionLevel: [TeachingLevelEnum.high_school] },
];

export async function seedSubjects(prisma: PrismaClient) {
    for (const subject of subjects) {
        await prisma.subject.upsert({
            where: { name: subject.name },
            update: {}, // no se actualiza si ya existe
            create: {
                name: subject.name,
                institutionLevel: subject.institutionLevel,
            },
        });
    }

    console.log('✅ Subjects seeded');
}