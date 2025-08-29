import { PrismaClient } from '@prisma/client';
import { seedTopics } from './seeds/topics';
import { seedCountries } from './seeds/countries';
import { seedStates } from './seeds/states';
import { seedCities } from './seeds/cities';

const prisma = new PrismaClient();

export async function seed() {
  try {
    console.log('🌱 Starting seed...');
    await seedTopics(prisma);
    await seedCountries(prisma);
    await seedStates(prisma);
    await seedCities(prisma);
    console.log('🌱 Seed completed successfully!');
  } catch (e) {
    console.error('❌ Error during seeding:', e);
    throw e;
  }
}

// Only run if executed directly
if (require.main === module) {
  seed()
    .catch((e) => {
      console.error('❌ Error during seeding:', e);
      process.exit(1);
    })
    .finally(async () => {
      await prisma.$disconnect();
      process.exit(0);
    });
}
