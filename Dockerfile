FROM public.ecr.aws/spacelift/runner-ansible:11.1-azure-linux-amd64

USER root

# Install sshpass
RUN apk add --no-cache  sshpass

# INSTALL azure.azcollection:3.1.0 
RUN ansible-galaxy collection install azure.azcollection:3.1.0 --force

#update azure-cli and other function dependencies
RUN az upgrade --yes

#delete phrase out of requirements.txt
RUN sed -i '/azure-iot-hub==2.6.1;platform_machine=="x86_64"/d' /ansible/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt

# Add user 'spacelift'
RUN adduser --disabled-password --uid=1983 spacelift && apk add sshpass


USER spacelift

# Spacelift also highly recommends building a custom runner image as this step takes about 5 minutes to run out of the box.
RUN /usr/local/bin/python3.12 -m pip install -r /ansible/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt

