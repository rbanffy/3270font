FROM registry.fedoraproject.org/fedora-minimal:latest

WORKDIR /opt

RUN microdnf install -y fontforge make