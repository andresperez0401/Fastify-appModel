// import fp from 'fastify-plugin';
// import { FastifyInstance } from 'fastify';
// import { CreateUserSchema } from './user.schemas';

// export async function registerUserRoutes(fastify: FastifyInstance) {
  
//     fastify.get('', async (request, reply) => {
//     reply.send({ message: 'Hello, User!' });
//   });


//    // Crear usuario (validación Zod en la ruta)
//   fastify.post('', async (req, rep) => {
//     const parsed = CreateUserSchema.safeParse(req.body);
//     if (!parsed.success) {
//       return rep.code(400).send({
//         message: 'Payload inválido para crear usuario',
//         errors: parsed.error.flatten(), // <-- Zod te da los detalles
//       });
//     }

//     // Inyectamos el body parseado para reutilizar tu controller.create
//       return fastify.userController.create(parsed.data, rep);
//   });

//   fastify.get('/all', fastify.userController.list);
// }

// export default fp(
//   async (fastify) => {
//     await fastify.register(registerUserRoutes, { prefix: 'users' });
//   },
//   { name: 'user-routes', dependencies: ['user-controller'] }
// );