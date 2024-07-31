FROM postgis/postgis:16-3.4

RUN apt update && \
    apt install postgresql-16-pgrouting -y && \
    apt-get clean

    