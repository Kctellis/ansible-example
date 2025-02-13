FROM public.ecr.aws/spacelift/runner-ansible:11-azure

USER root
ENV SHELL=/bin/bash

# Set bash as default shell
SHELL ["/bin/bash", "-c"]

RUN adduser --disabled-password --uid=1983 spacelift && apk add sshpass

USER spacelift
CMD ["/bin/bash"]