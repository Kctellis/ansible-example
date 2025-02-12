FROM public.ecr.aws/spacelift/runner-ansible:10.2-azure-linux-amd64

USER root

RUN adduser --disabled-password --uid=1983 spacelift && apk add sshpass

# Adjust permissions and run the required commands
RUN chmod 644 /mnt/workspace/source/ansible/myazure_rm.yml && \
    sed -i '/azure-iot-hub==2.6.1;platform_machine=="x86_64"/d' /mnt/workspace/source/ansible/.spacelift/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt && \
    /usr/local/bin/python3.12 -m pip install -r /mnt/workspace/source/ansible/.spacelift/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt

USER spacelift
