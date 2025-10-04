# =========================
# Etapa 1: Build del JAR
# =========================
FROM eclipse-temurin:21-jdk AS builder

# Directorio de trabajo
WORKDIR /app

# Copiamos todo el proyecto
COPY . .

# Ejecutamos Gradle para construir el JAR
# --no-daemon evita problemas de demonios de Gradle en CI/CD
RUN ./gradlew build --no-daemon

# =========================
# Etapa 2: Imagen final
# =========================
FROM eclipse-temurin:21-jdk

# Directorio de trabajo
WORKDIR /app

# Copiamos el JAR desde la etapa builder
COPY --from=builder /app/build/libs/*.jar app.jar

# Exponemos el puerto de la app (ajusta si es necesario)
EXPOSE 8090

# Comando de arranque
ENTRYPOINT ["java", "-jar", "app.jar"]
