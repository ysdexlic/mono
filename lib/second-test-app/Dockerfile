FROM node:15.5.1-alpine3.11 as builder

LABEL org.opencontainers.image.source https://github.com/ysdexlic/mono

WORKDIR /opt/app

COPY package.json yarn.lock ./

RUN yarn config set no-progress && \
    yarn --frozen-lockfile

ENV CI=true

COPY . .

RUN yarn build


FROM node:15.5.1-alpine3.11

WORKDIR /opt/app

ENV CI=true
ENV NODE_ENV=production

COPY package.json yarn.lock ./

RUN yarn config set no-progress && \
    yarn --frozen-lockfile

COPY --from=builder /opt/app/.next .next
COPY --from=builder /opt/app/public public

EXPOSE 3000

CMD [ "yarn", "start" ]

