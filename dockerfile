FROM node:12.22.1

RUN useradd -u 8877 sig
RUN usermod -aG sudo sig
RUN su - sig

RUN mkdir -p /home/sig
RUN chown sig /home/sig

WORKDIR /home/sig

RUN npm install ghost-cli@latest -g

USER sig
RUN ghost install 4.4.0 --local
RUN yarn
RUN ghost config database.connection.host 172.17.0.2
COPY config.production.json config.production.json

EXPOSE 2368
CMD [ "ghost", "run", "--production"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]