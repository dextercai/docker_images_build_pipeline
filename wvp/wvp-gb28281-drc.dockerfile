FROM node:18 AS front_builder

WORKDIR /app

RUN git clone https://github.com/dextercai/wvp-GB28181-pro.git wvp-repo

WORKDIR /app/wvp-repo/web

RUN npm install && \
    npm run build:prod


FROM maven:3.9.10-eclipse-temurin-8 AS builder

RUN java -version && javac -version

WORKDIR /app

RUN git clone https://github.com/dextercai/wvp-GB28181-pro.git wvp-repo

COPY --from=front_builder /app/wvp-repo/src/main/resources/static /app/wvp-repo/src/main/resources/static

RUN ls /app/wvp-repo/src/main/resources/

RUN cd wvp-repo && \
    sed -i '/<repositories>/,/<\/repositories>/d' pom.xml && \
    sed -i '/<pluginRepositories>/,/<\/pluginRepositories>/d' pom.xml && \
    mvn clean package -Dmaven.test.skip=true


FROM eclipse-temurin:8u452-b09-jre AS runtime

WORKDIR /opt/wvp/

COPY --from=builder /app/wvp-repo/target/*.jar /opt/wvp/wvp.jar

EXPOSE 18978/tcp
EXPOSE 8116/tcp
EXPOSE 8116/udp
EXPOSE 8080/tcp

ENTRYPOINT ["java", "-Xms512m", "-Xmx1024m", "-XX:+HeapDumpOnOutOfMemoryError", "-XX:HeapDumpPath=/opt/wvp/debug/", "-jar", "wvp.jar", "--spring.config.location=/opt/wvp/config/application.yml"]

