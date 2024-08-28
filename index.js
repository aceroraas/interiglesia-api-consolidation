import express from 'express';
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import cors from 'cors';
import getPort from 'get-port';

const prisma = new PrismaClient();
const app = express();
app.use(express.json());
app.use(cors());

const JWT_SECRET = process.env.JWT_SECRET;
const generatePortRange = (start, end) => {
   return Array.from({ length: end - start + 1 }, (_, i) => start + i);
};
// Middleware para registrar solicitudes
app.use((req, res, next) => {
   if (req.method === 'POST' || req.method === 'GET') {
      console.log(JSON.stringify({
         method: req.method,
         url: req.url,
         path: req.path,
         params: req.params,
         query: req.query,
         body: req.body
      }, null, 2));
   }
   next();
});

(async () => {
   const portRange = generatePortRange(3000, 3100);
   const port = await getPort({ port: portRange });
   app.listen(port, () => {
      console.log(`Servidor escuchando en el puerto ${port}`);
   });
   console.log(`Puerto disponible: ${port}`);
})();