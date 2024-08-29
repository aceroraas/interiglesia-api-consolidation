import express from 'express';
import cors from 'cors';
import getPort from 'get-port';
import { generatePortRange } from './services/generatePortRange.js';
import { logger } from './middleware/logger.js';

const app = express();
app.use(express.json());
app.use(cors());
app.use(logger);


(async () => {
   const portRange = generatePortRange(3000, 3100);
   const port = await getPort({ port: portRange });
   app.listen(port, () => {
      console.log(`Servidor escuchando en el puerto ${port}`);
   });
   console.log(`Puerto disponible: ${port}`);
})();