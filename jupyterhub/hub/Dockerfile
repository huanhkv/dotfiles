ARG JUPYTERHUB_VERSION

FROM quay.io/jupyterhub/jupyterhub:$JUPYTERHUB_VERSION

RUN apt update \
    && apt upgrade -y \
    && apt install -y python3-dev default-libmysqlclient-dev build-essential pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip 

RUN pip install dockerspawner jupyterhub-nativeauthenticator mysqlclient
