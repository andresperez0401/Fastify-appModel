Para iniciar el proyecto de cero:

1) Instalamos dependencia global de npm, que crea un archivo package json con datos iniciales del proyecto.

# npm init -y



2) Instalamos dependencias 


# npm i fastify @fastify/jwt @fastify/cors @fastify/helmet pino pino-pretty

fastify → El framework web que vas a usar, muy rápido y con plugins fáciles de usar.

@fastify/jwt → Middleware para manejar JSON Web Tokens (JWT) y autenticar usuarios.

@fastify/cors → Habilita CORS (Cross-Origin Resource Sharing) para tu API.

@fastify/helmet → Protege tu app agregando headers de seguridad (tipo X-Frame-Options, X-Content-Type-Options).

pino → Logger rápido y eficiente para Node.js.

pino-pretty → Hace que los logs de pino sean legibles en la consola (bonito para desarrollo).



# npm i @fastify/swagger @fastify/swagger-ui

@fastify/swagger → Genera la documentación de tu API en formato OpenAPI/Swagger.

@fastify/swagger-ui → Interfaz web interactiva para probar tu API y ver la documentación generada.



# npm i -D prisma
# npm i @prisma/client

prisma (devDependency) → CLI de Prisma, sirve para generar el cliente, migraciones y manejar tu esquema de base de datos.

@prisma/client → Cliente que importas en tu código para hacer queries a la base de datos usando Prisma.



# npm i -D typescript tsx @types/node zod fastify-type-provider-zod

typescript → TypeScript para tipado estático en tu proyecto.

tsx → Ejecutar archivos TS directamente sin compilar primero (tsx src/index.ts).

@types/node → Tipos de Node.js para TypeScript (para que reconozca process, fs, etc.).

zod → Librería de validación y parsing de datos con tipos.

fastify-type-provider-zod → Integra Zod con Fastify para validar rutas y esquemas de forma tipada.

# npx tsc --init

Ese comando de arriba, sirve para inicializar un tsconfig.json


- Comandos completos: 

# Fastify y utilidades
npm i fastify @fastify/jwt @fastify/cors @fastify/helmet pino pino-pretty
npm i @fastify/swagger @fastify/swagger-ui

# Prisma
npm i -D prisma
npm i @prisma/client

# TypeScript y DX
npm i -D typescript tsx @types/node zod fastify-type-provider-zod
# (opcional) lint/format:
# npm i -D eslint prettier


3) Luego para prisma: 

# npx prisma init 

Esto genera:
- prisma/schema.prisma
- .env con DATABASE_URL
- Carpeta prisma/migrations (vacía al inicio)

# npx prisma migrate dev --name init

# npx prisma generate

# npx prisma studio 

para ver la base de datos creada por prisma con interfaz gráfica 

