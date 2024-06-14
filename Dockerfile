# syntax=docker/dockerfile:1.4
FROM golang:bullseye as builder
RUN go install github.com/aptible/supercronic@v0.2.29
RUN go install github.com/hairyhenderson/gomplate/v3/cmd/gomplate@v3.11.7

FROM ubuntu:24.04

ARG KUBECTL_VERSION=1.26.9

RUN <<EOT
  set -e
  apt-get update
  apt-get install -y \
    ca-certificates \
    curl \
    jq \
    pid1 \
  ;
  rm -rf /var/lib/apt/lists/*

  curl -L "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
  chmod +x /usr/local/bin/kubectl
EOT

COPY --from=builder /go/bin/ /usr/local/bin/

COPY fs /

ENTRYPOINT [ "pid1", "--", "/entrypoint.sh" ]
