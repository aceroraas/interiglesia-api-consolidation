import { prisma } from "../services/prismaClient.js";
import bcrypt from 'bcryptjs';
async function main() {

   // Crear múltiples tipos de estado de empleo
   const employeType = await prisma.employmentStatusType.createMany({
      data: [
         { status: 'Empleado' },
         { status: 'Desempleado' },
         { status: 'Cuenta Propia' },
      ],
   });

   // Crear múltiples tipos de estado educacional
   const edutype = await prisma.educationalStatusType.createMany({
      data: [
         { status: 'Analfabeta' },
         { status: 'Sin Estudios' },
         { status: 'Primaria' },
         { status: 'Bachiller' },
         { status: 'Tecnico' },
         { status: 'Tecnico Superior' },
         { status: 'Universitario' },
         { status: 'Posgrado' },
         { status: 'Magister | Master' },
         { status: 'Doctorado' },
      ],
   });

   const contactype = await prisma.profileContactType.createMany({
      data: [
         { type: 'WhatsApp' },
         { type: 'Email' },
         { type: 'Teléfono Movil' },
         { type: 'Teléfono Casa' },
         { type: 'Facebook' },
         { type: 'Twitter' },
         { type: 'Otro' },
      ],
   });

   const dirTypes = await prisma.directionType.createMany({
      data: [
         { direccion: 'Duplex' },
         { direccion: 'Parental' },
         { direccion: 'Jerarquica' }
      ]
   })
   const relTypeFamily = await prisma.familyRelationType.createMany({
      data: [
         { type: 'Hermanos Sangre', dirId: 1 },
         { type: 'Hermanos Crianza', dirId: 1 },
         { type: 'Hermanastros', dirId: 1 },
         { type: 'Esposos', dirId: 1 },
         { type: 'Padres Sangre', dirId: 2 },
         { type: 'Padres Crianza', dirId: 2 },
         { type: 'Padres Adoptivo', dirId: 2 },
         { type: 'Tios', dirId: 2 },

      ],
   });

   const afinityType = await prisma.affinityType.createMany({
      data: [
         { type: 'Vecinos', dirId: 1 },
         { type: 'Amigos', dirId: 1 },
         { type: 'Trabajo', dirId: 1 },
         { type: 'Jefe', dirId: 3 },
      ]
   });

   const structure = await prisma.structureType.createMany({
      data: [
         { type: 'Celula' },
         { type: 'Ministerio' },
         { type: 'Externo' },
      ]
   });

   const memberType = await prisma.memberType.createMany({
      data: [
         { type: 'Servidor' },
         { type: 'Pastor' },
         { type: 'Lider' },
         { type: 'Miembro' },
         { type: 'Visitante' },
         { type: 'Nuevo Creyente' },
      ]
   });

   const condicionmedica = await prisma.medicalConditionType.createMany({
      data: [
         { type: 'Discapacidad' },
         { type: 'Enfermedad' },
         { type: 'Alergia' },
         { type: 'Tratamiento Medico' },
         { type: 'Medicacion' },
         { type: 'No Aplica' },
      ]
   });

   const obstype = await prisma.observationTypes.createMany({
      data: [
         { type: 'Observacion' },
         { type: 'Recomendacion' },
         { type: 'Sugerencia' },
         { type: 'Consolidacion' },
         { type: 'Queja' },
         { type: 'Advertencia' },
         { type: 'Interno' },
      ]
   });

   const ptypes = await prisma.petitionType.createMany({
      data: [
         { type: 'Oracion' },
         { type: 'Economica' },
      ]
   });
   const ptcategory = await prisma.petitionCategories.createMany({
      data: [
         { category: 'Visita' },
         { category: 'Oracion Familiar' },
         { category: 'Economica' },
         { category: 'Comida' },
         { category: 'Otro' },
      ]
   });

   const atentype = await prisma.attentionType.createMany({
      data: [
         { type: 'Visita' },
         { type: 'Economica' },
         { type: 'Consolidador' },
         { type: 'Otro' },
      ]
   });

   // Crear un perfil
   const perfil = await prisma.profile.create({
      data: {
         firstName: 'Ricardo',
         middleName: 'Alberto',
         lastName: 'Acero',
         secondLastName: 'Sanchez',
         birthDate: new Date('1999-02-06'),
         gender: 'Masculino',
         employmentStatus: {
            create: {
               employmentStatusTypeId: 1,
               companyName: 'Tech Solutions',
               position: 'Desarrollador',
            },
         },
         educationStatus: {
            create: {
               educationalStatusTypeId: 7,
               academyId: (await prisma.academyNames.create({ data: { name: "Universidad Politecnica Territorial Jose Antonio Anzoategui - UPTJAA" } })).id,
               career: 'Ingeniería de Sistemas',
            },
         },
         contacts: {
            create: [
               {
                  type: { create: { type: 'Email' } },
                  description: 'acerocol67@gmail.com',
               },
               {
                  type: { create: { type: 'WhatsApp' } },
                  description: '+584248990663',
               },
            ],
         },
      },
   });

   const hashedPassword = await bcrypt.hash(process.env.INSTALL_PASSWORD, 10);
   const user = await prisma.users.create({
      data: {
         username: 'admin',
         password: hashedPassword,
         profileId: perfil.id,
      },
   });
   console.log('Datos de ejemplo insertados:', perfil, user, { INSTALL_PASSWORD: process.env.INSTALL_PASSWORD });
}

main()
   .catch((e) => {
      console.error(e);
      process.exit(1);
   })
   .finally(async () => {
      await prisma.$disconnect();
   });