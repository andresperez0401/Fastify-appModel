import { createApp } from './app';

export async function start() {
  try {
    console.log('💻 Starting server app');
    const server = await createApp();
    console.log('🎉 App was created');
    process.on('unhandledRejection', (err) => {
      console.error(err);
      process.exit(1);
    });

    // Start the server
    const port = Number.parseInt(String(process.env.PORT || '3000'), 10);
    const host = process.env.HOST || '0.0.0.0';
    await server.listen({ host, port });


    //Esta parte es para cerrar el servidor cuando se recibe una señal de terminación, es decir puede ser por consola cuando se presiona Ctrl+C o por un comando de terminación del sistema.
    for (const signal of ['SIGINT', 'SIGTERM']) {
      process.on(signal, () =>
        server.close().then((err) => {
          console.log(`close application on ${signal}`);
          process.exit(err ? 1 : 0);
        })
      );
    }

    try {
      // console.log('💻 Starting queue');
      // Init amqp server
      // await initAMQPConsumer();
    } catch (error) {
      console.log(error);
    }
    return server;
  } catch (err) {
    throw err;
  }
}
















// import { config } from 'dotenv';
// config();
// import { buildApp } from './app';

// const PORT = Number(process.env.PORT ?? 3000);

// const app = createApp();

// app.listen({ port: PORT, host: '0.0.0.0' })
//   .then((address) => app.log.info(`✅ server up at ${address}`))
//   .catch((err) => {
//     app.log.error(err);
//     process.exit(1);
//   });
