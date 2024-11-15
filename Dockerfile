
FROM maven:3.8.6-openjdk-11 AS build


WORKDIR /app


COPY pom.xml .
RUN mvn dependency:go-offline


COPY src ./src


RUN mvn package


FROM openjdk:11-jre-slim


WORKDIR /app


COPY --from=build /app/target/Calculator-1.0-SNAPSHOT.jar app.jar


ENTRYPOINT ["java", "-jar", "app.jar"]
