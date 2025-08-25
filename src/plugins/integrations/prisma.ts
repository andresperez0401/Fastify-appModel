import { PrismaClient } from '@prisma/client';
import fastify, { FastifyPluginAsync } from 'fastify';
import fp from 'fastify-plugin';
import { FastifyInstance } from 'fastify';

declare module 'fastify' {
  interface FastifyInstance {
    prisma: PrismaClient;
  }
}

const prisma = new PrismaClient();


export default fp(
    async (fastify: FastifyInstance) => {

    // Connect to the database
    await prisma.$connect();        
    console.log('🍃 Database connected')
    
    // Decorate Fastify instance with Prisma client
    fastify.decorate('prisma', prisma);

    // Close the database connection when Fastify close
    fastify.addHook('onClose', async (app) => {
      await app.prisma.$disconnect();
    });
    },
    { name: 'prisma-plugin' }
)

// export const prismaPlugin: FastifyPluginAsync = fp(async (app) => {
//   // Conectar
//   await prisma.$connect();
//   console.log('🍃 Database connected');

//   // Decorar Fastify para usar prisma
//   app.decorate('prisma', prisma);

//   // Hook para cerrar la conexión cuando Fastify cierre
//   app.addHook('onClose', async () => {
//     await prisma.$disconnect();
//     console.log('🍃 Database disconnected');
//   });
// });

// export default prismaPlugin;
