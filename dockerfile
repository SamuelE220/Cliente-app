# =========================
# Etapa 1: Build del JAR
# =========================
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app
COPY . .

# Dar permisos de ejecución al wrapper de Gradle
RUN chmod +x ./gradlew
RUN ./gradlew build --no-daemon -x test

# =========================
# Etapa 2: Imagen final
# =========================
FROM eclipse-temurin:21-jdk
WORKDIR /app
RUN mkdir -p /app/libs
COPY --from=builder /app/build/libs/*.jar /app/libs/

# Ejecutar automáticamente cualquier JAR que esté en /app/libs
ENTRYPOINT ["sh", "-c", "java -jar /app/libs/$(ls /app/libs | head -n1)"]

EXPOSE 8090
