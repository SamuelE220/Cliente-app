# =========================
# Etapa 1: Build del JAR
# =========================
FROM eclipse-temurin:21-jdk AS builder

# Directorio de trabajo
WORKDIR /app

# Copiamos todo el proyecto
COPY . .

# Ejecutamos Gradle para construir el JAR, ignorando tests
RUN ./gradlew build --no-daemon -x test

# =========================
# Etapa 2: Imagen final
# =========================
FROM eclipse-temurin:21-jdk

# Directorio de trabajo
WORKDIR /app

# Creamos carpeta para los JARs
RUN mkdir -p /app/libs

# Copiamos todos los JARs desde la etapa builder
COPY --from=builder /app/build/libs/*.jar /app/libs/

# Ajusta al nombre exacto de tu JAR principal
ENTRYPOINT ["java", "-jar", "/app/libs/clientes-1.0-SNAPSHOT.jar"]

# Puerto que usa tu app
EXPOSE 8090
