import fp from 'fastify-plugin';
import type { FastifyInstance } from 'fastify';

declare module 'fastify' {
  interface FastifyInstance {
    userService: UserService;
  }
}

export type CreateUserDTO = {
  firstName: string;
  lastName: string;
  email: string;
  password: string; // (en prod: hashear)
  birthDate?: string; // ISO opcional
  phoneNumber?: { areaCode: string; number: string }; // embebido como JSON
  type: 'admin' | 'professor';
};

class UserService {
  constructor(private app: FastifyInstance) {}

  async create(data: CreateUserDTO) {
    const { birthDate, phoneNumber, ...rest } = data;

    return this.app.prisma.user.create({
      data: {
        ...rest,
        birthDate: birthDate ? new Date(birthDate) : undefined,
        phoneNumber: phoneNumber ? (phoneNumber as any) : undefined,
      },
    });
  }

  async findAll() {
    return this.app.prisma.user.findMany({
      orderBy: { createdAt: 'desc' },
    });
  }
}

export default fp(async (fastify) => {
  fastify.decorate('userService', new UserService(fastify));
}, { name: 'user-service', dependencies: ['prisma-plugin'] });
