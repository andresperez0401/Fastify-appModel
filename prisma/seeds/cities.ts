import { PrismaClient } from '@prisma/client';

const citiesByState: Record<string, string[]> = {
  // Venezuela
  'Distrito Capital': ['Caracas'],
  Tachira: ['San Cristóbal'],
  Miranda: ['Los Teques', 'Guarenas'],
  Zulia: ['Maracaibo', 'Cabimas'],
  Carabobo: ['Valencia', 'Puerto Cabello'],

  // México
  'Ciudad de México': ['Ciudad de México'],
  Jalisco: ['Guadalajara', 'Puerto Vallarta'],
  'Nuevo León': ['Monterrey', 'San Nicolás de los Garza'],
  Yucatán: ['Mérida', 'Valladolid'],

  // España
  Madrid: ['Madrid', 'Alcalá de Henares'],
  Cataluña: ['Barcelona', 'Girona'],
  Andalucía: ['Sevilla', 'Málaga'],
  Valencia: ['Valencia', 'Alicante'],

  // Colombia
  Bogotá: ['Bogotá'],
  Antioquia: ['Medellín', 'Bello'],
  Cundinamarca: ['Soacha', 'Chía'],
  'Valle del Cauca': ['Cali', 'Palmira'],

  // Estados Unidos
  California: ['Los Angeles', 'San Francisco'],
  Texas: ['Houston', 'Dallas'],
  'New York': ['New York City', 'Buffalo'],
  Florida: ['Miami', 'Orlando'],

  // Chile
  Santiago: ['Santiago'],
  Valparaíso: ['Valparaíso', 'Viña del Mar'],
  Concepción: ['Concepción', 'Talcahuano'],
  Antofagasta: ['Antofagasta', 'Calama'],
};

export async function seedCities(prisma: PrismaClient) {
  for (const [stateName, cities] of Object.entries(citiesByState)) {
    const state = await prisma.state.findFirst({ where: { name: stateName } });
    if (!state) continue;

    for (const cityName of cities) {
      await prisma.city.upsert({
        where: { stateId_name: { stateId: state.id, name: cityName } },
        update: {},
        create: { name: cityName, stateId: state.id },
      });
    }
  }

  console.log('✅ Cities seeded');
}
