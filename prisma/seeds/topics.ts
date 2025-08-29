import { PrismaClient } from '@prisma/client';

export async function seedTopics(prisma: PrismaClient) {
  const topics = [
    {
      name: 'Gestión educativa',
      description:
        'Área dedicada a la planificación, organización y liderazgo de procesos académicos e institucionales. Incluye la administración de recursos, políticas educativas, y la vinculación con actores nacionales e internacionales para fortalecer proyectos educativos.',
    },
    {
      name: 'Aprendizaje',
      description:
        'Espacio centrado en teorías, metodologías y estrategias para potenciar el proceso de aprendizaje en estudiantes de todos los niveles. Aborda desde fundamentos cognitivos hasta prácticas inclusivas y socioemocionales.',
    },
    {
      name: 'Diseño de la enseñanza',
      description: 'Integra la creación de experiencias pedagógicas efectivas.',
    },
    {
      name: 'Evaluación',
      description:
        'Instrumentos y procesos para valorar el aprendizaje y la efectividad docente.',
    },
    {
      name: 'Investigación Educativa',
      description:
        'Generación y divulgación de conocimiento científico para innovar en pedagogía, con rigor metodológico y ético.',
    },
    {
      name: 'Desarrollo profesional',
      description:
        'Espacio para el desarrollo profesional, generación de conocimiento y evidencia para la innovación pedagógica, incluye áreas relacionadas con salud laboral y equilibrio vida-trabajo de los educadores, combinando formación continua, autocuidado y herramientas para una práctica docente sostenible.',
    },
  ];

  for (const topic of topics) {
    await prisma.topic.upsert({
      where: { name: topic.name },
      update: {}, // no actualiza nada si ya existe
      create: {
        name: topic.name,
        description: topic.description,
      },
    });
  }

  console.log('✅ Topics seeded');
}
