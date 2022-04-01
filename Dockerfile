FROM          node
RUN           adduser --disabled-password  --home /app --gecos "" roboshop
USER          roboshop
WORKDIR       /app
COPY          package.json /app/.
COPY          server.js /app/.
RUN           npm install
ENTRYPOINT    ["node"]
CMD           ["server.js"]
