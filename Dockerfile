FROM maven:3.8.3-openjdk-17 AS Build
RUN git clone https://github.com/PearlThought/spring-petclinic.git
WORKDIR spring-petclinic
RUN mvn package

FROM openjdk:17-alpine
LABEL author="Tejaswini"
WORKDIR /tmp/
COPY --from=Build spring-petclinic/target/ /tmp/
EXPOSE 8080
CMD ["java","-jar"," target/*.jar"]