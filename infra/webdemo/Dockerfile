FROM python:alpine
COPY entrypoint.sh /entrypoint.sh
RUN apk update && apk add \
    git
WORKDIR /root
RUN  chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]