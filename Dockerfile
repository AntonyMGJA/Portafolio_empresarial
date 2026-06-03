# Ejemplo para una página web estática con Ng# Utiliza una imagen base de Node.js para construir el proyecto.
FROM node:18-alpine AS build

# Establece el directorio de trabajo dentro del contenedor.
WORKDIR /app

# Copia los archivos de manifiesto del proyecto para instalar las dependencias.
COPY package*.json ./

# Instala las dependencias del proyecto.
RUN npm install

# Copia el resto de los archivos del proyecto al contenedor.
COPY . .

# Genera el build de la aplicación.
RUN npm run build

# Utiliza una imagen base de Nginx para servir la aplicación estática.
FROM nginx:alpine

# Copia los archivos estáticos generados por Astro en el directorio de servicio de Nginx.
COPY --from=build /app/dist /usr/share/nginx/html

# Expone el puerto por defecto de Nginx.
EXPOSE 80

# Inicia el servidor Nginx cuando el contenedor se ejecute.
CMD ["nginx", "-g", "daemon off;"]