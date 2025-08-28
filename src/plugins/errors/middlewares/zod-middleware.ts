import fp from 'fastify-plugin';
import type { FastifyInstance } from 'fastify';
import { ZodError, ZodObject } from 'zod';
import { thrower } from '@/errors/thrower';

export default fp(async (fastify: FastifyInstance) => {
  fastify.addHook('preValidation', async (req, reply) => {
    const schema = (req.routeOptions.config as any)?.inputSchema;
    if (schema && schema instanceof ZodObject) {
      try {
        req.body = schema.parse(req.body);
      } catch (err) {
        if (err instanceof ZodError) {
          const details = err.issues.map(i => ({
            field: i.path.join('.'),
            message: i.message,
          }));
          const fields = details.map(d => d.field).join(', ');
          return reply.status(400).send({
            type: "VALIDATION_ERROR",
            code: "VALIDATION_ERROR",
            title: "Datos inválidos",
            message: `La petición contiene datos inválidos: ${fields}.`,
            status: 400,
            details
          });
        }
      }
    }
  });
});
