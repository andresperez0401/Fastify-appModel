import { PrismaClient } from '@prisma/client';

const statesByCountry: Record<string, string[]> = {
  VE: ['Caracas', 'Tachira', 'Miranda', 'Zulia', 'Carabobo'],
  MX: ['Ciudad de México', 'Jalisco', 'Nuevo León', 'Yucatán'],
  ES: ['Madrid', 'Cataluña', 'Andalucía', 'Valencia'],
  CO: ['Bogotá', 'Antioquia', 'Cundinamarca', 'Valle del Cauca'],
  US: ['California', 'Texas', 'New York', 'Florida'],
  CL: ['Santiago', 'Valparaíso', 'Concepción', 'Antofagasta'],
};

export async function seedStates(prisma: PrismaClient) {
  for (const [countryCode, states] of Object.entries(statesByCountry)) {
    const country = await prisma.country.findUnique({ where: { iso: countryCode } });
    if (!country) continue;
    for (const stateName of states) {
      await prisma.state.upsert({
        where: { countryId_name: { countryId: country.id, name: stateName } },
        update: {},
        create: { name: stateName, countryId: country.id },
      });
    }
  }

  console.log('✅ States seeded');
}
