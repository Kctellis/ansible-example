FROM public.ecr.aws/spacelift/runner-ansible:11.1-azure-linux-amd64

USER root

# Install bash and sshpass
RUN apk add --no-cache bash sshpass

# Add user 'spacelift'
RUN adduser --disabled-password --uid=1983 spacelift && apk add sshpass

ENV SHELL=/bin/bash

# Set bash as default shell
SHELL ["/bin/bash", "-c"]

