#!/bin/bash

# Función para generar el MD5
generate_md5() {
    local input="$1"
    echo -n "$input" | md5sum | awk '{print $1}'
}

# Función para generar JWT_SECRET
generate_jwt_secret() {
    echo $(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")
}

# Función para generar INSTALL_PASSWORD
generate_install_password() {
    echo $(node -e "console.log(require('crypto').randomBytes(5).toString('hex'))")
}

# Función para generar INSTALL_HASH
generate_install_hash() {
    echo $(node -e "console.log(require('crypto').randomBytes(16).toString('hex'))")
}

# Función para actualizar o añadir una variable en el archivo .env
update_or_add_env_var() {
    local var_name=$1
    local var_value=$2
    if grep -q "^${var_name}=" .env; then
        sed -i "s/^${var_name}=.*/${var_name}=${var_value}/" .env
    else
        echo "${var_name}=${var_value}" >> .env
    fi
}

# Verificar si node está instalado
if ! command -v node &> /dev/null; then
    echo "node no está instalado. Por favor, instala node antes de continuar."
    exit 1
fi

# Verificar si npm está instalado
if ! command -v npm &> /dev/null; then
    echo "npm no está instalado. Por favor, instala npm antes de continuar."
    exit 1
fi

# Verificar si el módulo crypto está disponible en node
if ! node -e "require('crypto')" &> /dev/null; then
    echo "El módulo crypto no está disponible en node. Por favor, asegúrate de tener una versión de node que incluya crypto."
    exit 1
fi

# Verificar si el archivo .env existe
if [ -f .env ]; then
    echo "El archivo .env ya existe. Actualizando variables..."
else
    echo "El archivo .env no existe. Creando archivo..."
    touch .env
fi

# Verificar si se pasaron argumentos
if [ $# -ge 5 ]; then
    USER_DB=$1
    PASSWORD_DB=$2
    NAME_DB=$3
    HOST_DB=$4
    PORT_DB=$5
    ENTITY_HASH=${6:-$(read -p "Ingrese el ENTITY_HASH: " ENTITY_HASH && echo $ENTITY_HASH)}
    INSTALL_TOKEN=${7:-$(read -p "Ingrese el INSTALL_TOKEN: " INSTALL_TOKEN && echo $INSTALL_TOKEN)}
elif [ $# -eq 4 ]; then
    USER_DB=$1
    PASSWORD_DB=$2
    NAME_DB=$3
    HOST_DB=$4
    PORT_DB="5432"
    ENTITY_HASH=$(read -p "Ingrese el ENTITY_HASH: " ENTITY_HASH && echo $ENTITY_HASH)
    INSTALL_TOKEN=$(read -p "Ingrese el INSTALL_TOKEN: " INSTALL_TOKEN && echo $INSTALL_TOKEN)
elif [ $# -eq 3 ]; then
    USER_DB=$1
    PASSWORD_DB=$2
    NAME_DB=$3
    HOST_DB="localhost"
    PORT_DB="5432"
    ENTITY_HASH=$(read -p "Ingrese el ENTITY_HASH: " ENTITY_HASH && echo $ENTITY_HASH)
    INSTALL_TOKEN=$(read -p "Ingrese el INSTALL_TOKEN: " INSTALL_TOKEN && echo $INSTALL_TOKEN)
else
    # Solicitar usuario, contraseña, host y puerto
    read -p "Ingrese el usuario de la base de datos: " USER_DB
    read -p "Ingrese la contraseña de la base de datos: " PASSWORD_DB
    read -p "Ingrese el nombre de la base de datos (por defecto: se generará automáticamente): " NAME_DB
    read -p "Ingrese el host de la base de datos (por defecto: localhost): " HOST_DB
    HOST_DB=${HOST_DB:-localhost}
    read -p "Ingrese el puerto de la base de datos (por defecto: 5432): " PORT_DB
    PORT_DB=${PORT_DB:-5432}
fi

# Generar el nombre de la base de datos si no se proporcionó
if [ -z "$NAME_DB" ]; then
    # Obtener el timestamp actual y el nombre del equipo
    TIMESTAMP=$(date +%s)
    HOSTNAME=$(hostname)
    # Generar el MD5
    NAME_DB=$(generate_md5 "${TIMESTAMP}${HOSTNAME}")
fi

# Generar JWT_SECRET
JWT_SECRET=$(generate_jwt_secret)
# Generar INSTALL_PASSWORD
INSTALL_PASSWORD=$(generate_install_password)
# Generar INSTALL_HASH
INSTALL_HASH=$(generate_install_hash)


# Actualizar o añadir variables en el archivo .env
update_or_add_env_var "USER_DB" "$USER_DB"
update_or_add_env_var "PASSWORD_DB" "$PASSWORD_DB"
update_or_add_env_var "NAME_DB" "$NAME_DB"
update_or_add_env_var "HOST_DB" "$HOST_DB"
update_or_add_env_var "PORT_DB" "$PORT_DB"
update_or_add_env_var "DATABASE_URL" "postgresql://$USER_DB:$PASSWORD_DB@$HOST_DB:$PORT_DB/$NAME_DB?schema=public"
update_or_add_env_var "JWT_SECRET" "$JWT_SECRET"
update_or_add_env_var "INSTALL_PASSWORD" "$INSTALL_PASSWORD"
update_or_add_env_var "ENTITY_HASH" "$ENTITY_HASH"
update_or_add_env_var "INSTALL_TOKEN" "$INSTALL_TOKEN"
update_or_add_env_var "INSTALL_HASH" "$INSTALL_HASH"

echo "Archivo .env creado con éxito."
echo "INSTALL_PASSWORD: $INSTALL_PASSWORD"

# Verificar si Prisma está instalado 
if ! npm list -g prisma &> /dev/null; then
    echo "Prisma no está instalado. Instalando Prisma..."
    npm install -g prisma
fi

# Verificar si @prisma/client, express, bcryptjs y jsonwebtoken están instalados
if ! npm list @prisma/client express bcryptjs jsonwebtoken dotenv cors get-port &> /dev/null; then
    echo "Instalando @prisma/client, express, bcryptjs y jsonwebtoken dotenv cors get-port..."
    npm install @prisma/client express bcryptjs jsonwebtoken dotenv cors get-port
fi

# Ejecutar la migración de Prisma
npx prisma migrate dev --name init

# Ejecutar Prisma Studio
npx prisma studio
