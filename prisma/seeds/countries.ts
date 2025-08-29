import { PrismaClient } from '@prisma/client';
import { countries } from 'country-codes-flags-phone-codes';
import countriesIso from 'i18n-iso-countries';

countriesIso.registerLocale(require('i18n-iso-countries/langs/es.json'));

export async function seedCountries(prisma: PrismaClient) {
  for (const country of countries) {
    const nameInSpanish = countriesIso.getName(country.code, 'es') || country.name;
    await prisma.country.upsert({
      where: { iso: country.code },
      update: {},
      create: {
        name: nameInSpanish,
        iso: country.code,
        phonePrefix: country.dialCode,
        flag: country.flag,
      },
    });
  }

  console.log('✅ Countries seeded in Spanish');
}
