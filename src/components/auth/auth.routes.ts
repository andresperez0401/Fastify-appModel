import fp from 'fastify-plugin';
import type { FastifyInstance } from 'fastify';
import {
    TUserDTO, UserDTO
}from '../../packages/schemas/src/user/user.dto';


async function registerAuthRoutes(fastify: FastifyInstance) {

  //Ruta para el sign-up de un usuario
  fastify.post('/sign-up', fastify.authController.signUp);

  //Ruta para el sign-in de un usuario
  fastify.post('/sign-in', fastify.authController.signIn);

}

//Funcion para agregar las rutas al fastify instance
export default fp(
  async (fastify) => {
    await fastify.register(registerAuthRoutes, { prefix: 'auth' });
  },
  { name: 'auth-routes', dependencies: ['auth-controller'] }
);
