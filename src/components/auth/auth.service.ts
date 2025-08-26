import fp from 'fastify-plugin';
import type { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify';

declare module 'fastify' {
  interface FastifyInstance {
    authService: AuthService;
  }
}

class AuthService {

    private fastify: FastifyInstance;

    constructor(fastify: FastifyInstance) {
        this.fastify = fastify;
    }

    async signUp(data: any) {
        // Aquí puedes agregar lógica adicional, como enviar un correo de bienvenida
        return this.fastify.userService.create(data);
    }

    async signIn(email: string, password: string) {
        const user = await this.fastify.prisma.user.findUnique({ where: { email } });
        if (!user || user.password !== password) {
        throw new Error('Invalid email or password');
        }
        // Aquí puedes generar y devolver un token JWT u otro mecanismo de autenticación
        return 'fake-jwt-token'; // Reemplaza con la lógica real de generación de tokens
    }
}
