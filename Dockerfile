FROM openjdk:17-jdk
VOLUME /oasis-uploads
ARG JAR_FILE=backend/build/libs/app.jar
COPY .env .env
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java"]
CMD ["-jar","app.jar"]