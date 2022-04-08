FROM docker.io/bitnami/minideb:buster
LABEL maintainer "aluopy <aluopy@aliyun.com>"

RUN sed -i '1i\deb http://mirrors.aliyun.com/debian/ buster main non-free contrib' /etc/apt/sources.list && \
    sed -i '2i\deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib' /etc/apt/sources.list && \
    sed -i '3i\deb http://mirrors.aliyun.com/debian-security buster/updates main' /etc/apt/sources.list && \
    sed -i '4i\deb-src http://mirrors.aliyun.com/debian-security buster/updates main' /etc/apt/sources.list && \
    sed -i '5i\deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib' /etc/apt/sources.list && \
    sed -i '6i\deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib' /etc/apt/sources.list && \
    sed -i '7i\deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib' /etc/apt/sources.list && \
    sed -i '8i\deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib' /etc/apt/sources.list && \
	apt-get update

# RUN apt-get install -y locales locales-all
RUN apt-get install -y locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8

ENV TZ="Asia/Shanghai" \
    LC_ALL="en_US.UTF-8" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    HOME="/" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-10" \
    OS_NAME="linux"

ARG JAVA_EXTRA_SECURITY_DIR="/bitnami/java/extra-security"

COPY prebuildfs /
# Install required system packages and dependencies
RUN install_packages acl ca-certificates curl gzip libc6 libssl1.1 procps tar xmlstarlet zlib1g
#RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "java" "11.0.14-7" --checksum 900545c4f346a0ece8abf2caf64fd9d4ab7514967d4614d716bf7362b24f828b
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "java" "1.8.242-0" --checksum 3a70f3d1c3cd9bc6ec581b2a10373a2b323c0b9af40402ce8d19aeb0b3d02400
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "tomcat" "9.0.62-0" --checksum 19b1e7b113180f5a17a1155d36a23d5da65e741337d8f89c0e97a9fb6535921c
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "render-template" "1.0.1-10" --checksum 97c2ae4b001c5937e888b920bee7b1a40a076680caac53ded6d10f6207d54565
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "gosu" "1.14.0-7" --checksum d6280b6f647a62bf6edc74dc8e526bfff63ddd8067dcb8540843f47203d9ccf1
RUN apt-get update && apt-get upgrade -y && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives
RUN chmod g+rwX /opt/bitnami

COPY rootfs /
RUN /opt/bitnami/scripts/java/postunpack.sh
RUN /opt/bitnami/scripts/tomcat/postunpack.sh
ENV APP_VERSION="9.0.62" \
    BITNAMI_APP_NAME="tomcat" \
    BITNAMI_IMAGE_VERSION="9.0.62-debian-10-r0" \
    JAVA_HOME="/opt/bitnami/java" \
    PATH="/opt/bitnami/java/bin:/opt/bitnami/tomcat/bin:/opt/bitnami/common/bin:$PATH"

EXPOSE 8009 8080

#USER 1001
#ENTRYPOINT [ "/opt/bitnami/scripts/tomcat/entrypoint.sh" ]
#CMD [ "/opt/bitnami/scripts/tomcat/run.sh" ]
