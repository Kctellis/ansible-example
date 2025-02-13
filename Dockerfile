FROM public.ecr.aws/spacelift/runner-ansible:11.1-azure-linux-amd64

USER root

# Install bash and sshpass
RUN apk add --no-cache bash sshpass

# INSTALL azure.azcollection:3.1.0 
RUN ansible-galaxy collection install azure.azcollection:3.1.0 --force

#update azure-cli and other function dependencies
RUN az upgrade --yes

#delete phrase out of requirements.txt so dependency doesnt dail
RUN sed -i '/azure-iot-hub==2.6.1;platform_machine=="x86_64"/d' /ansible/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt

# Add user 'spacelift'
RUN adduser --disabled-password --uid=1983 spacelift && apk add sshpass

ENV SHELL=/bin/bash

USER spacelift

RUN /usr/local/bin/python3.12 -m pip install -r /ansible/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt

# Set bash as default shell
SHELL ["/bin/bash", "-c"]
