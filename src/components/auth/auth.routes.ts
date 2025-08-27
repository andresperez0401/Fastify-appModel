import fp from 'fastify-plugin';
import type { FastifyInstance } from 'fastify';
import { thrower } from '@/errors/thrower';


async function registerAuthRoutes(fastify: FastifyInstance) {

  //Ruta para el sign-up de un usuario
  fastify.post('/sign-up', fastify.authController.signUp);

  //Ruta para el sign-in de un usuario
  fastify.post('/sign-in', fastify.authController.signIn);

  fastify.get('/test-error', async (request, reply) => {
    // Simulamos un error para probar el manejador de errores
     thrower.exception('user', 'not-found', { id: 123 });
  });

}

//Funcion para agregar las rutas al fastify instance
export default fp(
  async (fastify) => {
    await fastify.register(registerAuthRoutes, { prefix: 'auth' });
  },
  { name: 'auth-routes', dependencies: ['auth-controller'] }
);
