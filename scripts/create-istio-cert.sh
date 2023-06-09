#!/bin/bash

openssl req -newkey rsa:4096 \
            -x509 \
            -sha256 \
            -days 365 \
            -nodes \
            -out certs/www.case-study.internal.crt \
            -keyout certs/www.case-study.internal.key \
            -subj "/C=DE/ST=Berlin/L=Berlin/O=k/OU=platform-team/CN=k8s.case-study.internal"

kubectl create secret tls web-server-credential \
  --key=certs/k8s.case-study.internal.key \
  --cert=certs/k8s.case-study.internal.crt
