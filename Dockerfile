FROM google/cloud-sdk:223.0.0-alpine

LABEL maintainer="vitorarins" \
      description="The cloud-sdk container is used for releases to gke"

RUN curl https://storage.googleapis.com/kubernetes-release/release/v1.10.7/bin/linux/amd64/kubectl --output /google-cloud-sdk/bin/kubectl \
    && chmod +x /google-cloud-sdk/bin/kubectl \
    && kubectl version --client \
    && apk add gettext \
    && rm -rf /var/cache/apk/*

ENV NASHROOT=/nashroot
ENV VERSION=v1.0
ENV PATH=$PATH:$NASHROOT/bin

RUN mkdir -p $NASHROOT \
    && cd $NASHROOT \
    && tarfile="nash-$VERSION-linux-amd64.tar.gz" \
    && wget https://github.com/NeowayLabs/nash/releases/download/$VERSION/$tarfile \
    && tar xvfz $tarfile \
    && rm -f $tarfile