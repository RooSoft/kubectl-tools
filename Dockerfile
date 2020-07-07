FROM alpine:latest AS downloader
WORKDIR /home
RUN apk add --no-cache curl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl && \
    chmod +x kubectl
RUN curl -L https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-Linux-x86_64 -o envsubst && \
    chmod +x envsubst

FROM busybox:latest
WORKDIR /home
COPY --from=downloader /home/kubectl /bin/kubectl
COPY --from=downloader /home/envsubst /bin/envsubst

CMD ["/bin/sh"]
