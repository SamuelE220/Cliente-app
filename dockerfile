# Imagen base ligera de Java 21
FROM eclipse-temurin:21-jdk

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos el archivo JAR al contenedor
COPY clientes-1.jar app.jar

# Exponemos el puerto (ajústalo al puerto real que use tu app, por ejemplo 8090)
EXPOSE 8090

# Comando de arranque
ENTRYPOINT ["java", "-jar", "app.jar"]
