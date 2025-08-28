import fp from 'fastify-plugin';
import type { FastifyInstance } from 'fastify';
import { thrower } from '@/errors/thrower';
import { UserDTO } from '@/packages/schemas/src/user/user.dto';


//Funcion que registra las rutas públics de Auth
async function registerAuthRoutes(fastify: FastifyInstance) {


  //Ruta para el registro de un usuario
  fastify.post('/sign-up', {
  
    //Se le pasa el schema en el body, para que pueda tener la prevalidación con el middleware de Zod: Plugins/errors/middlewares
    config: {
        inputSchema: UserDTO.createUserInput,
    },
    handler: fastify.authController.signUp,
  });


  //de prueba
  fastify.get('/all', async (request, reply) => {
    const users = await fastify.prisma.user.findMany();
    reply.send(users);
  });

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
