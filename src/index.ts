import 'dotenv/config';
import { start } from './server';

start()
  .then(() => {
    console.log('🚀 Server running on port', process.env.PORT);
  })
  .catch((err) => {
    console.log(err);
    process.exit(1);
  });