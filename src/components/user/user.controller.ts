import fp from 'fastify-plugin';
import type { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify';
import type { CreateUserDTO } from './user.service';

declare module 'fastify' {
  interface FastifyInstance {
    userController: UserController;
  }
}

class UserController {
  constructor(private app: FastifyInstance) {

    //Hay que bindear para que no pieda el contexto 
    this.create = this.create.bind(this);
    this.list = this.list.bind(this);
  }

  // POST /users
  async create(
    req: CreateUserDTO ,
    rep: FastifyReply
  ) {
    try {
      const user = await this.app.userService.create(req);
      return rep.code(201).send(user);
    } catch (e: any) {
      if (e?.code === 'P2002') {
        return rep.code(409).send({ message: 'Email already exists' });
      }
      this.app.log.error(e);
      return rep.code(500).send({ message: 'Unexpected error' });
    }
  }

  // GET /users
  async list(_req: FastifyRequest, _rep: FastifyReply) {
    const users = await this.app.userService.findAll();
    return { users };
  }
}

export default fp(async (fastify) => {
  fastify.decorate('userController', new UserController(fastify));
}, { name: 'user-controller', dependencies: ['user-service'] });
