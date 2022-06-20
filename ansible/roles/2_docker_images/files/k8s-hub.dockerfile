FROM jupyterhub/k8s-hub:1.2.0

ARG NB_USER=jovyan
ARG NB_UID=1000
ARG HOME=/home/jovyan

USER root
RUN pip3 uninstall jupyterhub-ldapauthenticator -y
RUN pip3 install jupyterhub-ldap-authenticator

USER ${NB_USER}
CMD ["jupyterhub", "--config", "/usr/local/etc/jupyterhub/jupyterhub_config.py"]
