FROM maven:3.8.6-openjdk-8 as build
WORKDIR /app
COPY pom.xml ./
COPY src ./src

RUN mvn -B -f pom.xml clean package -DskipTests

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENV PORT=8080
EXPOSE ${PORT}
ENTRYPOINT [ "java", "-jar", "app.jar" ]
