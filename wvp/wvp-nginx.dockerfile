FROM node:18 AS builder

WORKDIR /app

RUN git clone https://github.com/648540858/wvp-GB28181-pro.git wvp-repo

WORKDIR /app/wvp-repo/web

RUN npm install && \
    npm run build:prod



FROM nginx:1.27.5-alpine AS runtime

WORKDIR /opt/

COPY --from=builder /app/wvp-repo/web/dist ./

CMD ["nginx","-g","daemon off;"]