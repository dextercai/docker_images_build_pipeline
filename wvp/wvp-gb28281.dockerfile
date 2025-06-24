FROM maven:3.9.10-eclipse-temurin-8 AS builder

RUN java -version && javac -version

WORKDIR /app

RUN git clone https://github.com/648540858/wvp-GB28181-pro.git wvp-repo

RUN cd wvp-repo && \
    mvn clean package -Dmaven.test.skip=true


FROM eclipse-temurin:8u452-b09-jre AS runtime

WORKDIR /opt/wvp/

COPY --from=builder /app/wvp-repo/target/*.jar /opt/wvp/wvp.jar

EXPOSE 18978/tcp
EXPOSE 8116/tcp
EXPOSE 8116/udp
EXPOSE 8080/tcp

ENTRYPOINT ["java", "-Xms512m", "-Xmx1024m", 
            "-XX:+HeapDumpOnOutOfMemoryError", "-XX:HeapDumpPath=/opt/wvp/debug/", 
            "-jar", "wvp.jar", 
            "--spring.config.location=/opt/wvp/config/application.yml"]

