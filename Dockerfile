FROM alpine:latest
ARG SSHPORT=22
ENV PORT=$SSHPORT

# ssh-keygen -A generates all necessary host keys (rsa, dsa, ecdsa, ed25519) at default location.
#RUN    apk update \
#    && apk add openssh \
#    && mkdir /root/.ssh \
#    && chmod 0700 /root/.ssh \
#    && ssh-keygen -A \
#    && sed -i s/^#PasswordAuthentication\ yes/PasswordAuthentication\ no/ /etc/ssh/sshd_config \
#    && sed -i "s/#Port 22/Port ${PORT}/" /etc/ssh/sshd_config

# This image expects AUTHORIZED_KEYS environment variable to contain your ssh public key.

COPY docker-entrypoint.sh docker-entrypoint.sh

#EXPOSE ${PORT}
WORKDIR /
ENTRYPOINT ["/docker-entrypoint.sh"]

# -D in CMD below prevents sshd from becoming a daemon. -e is to log everything to stderr.
CMD ["/usr/sbin/sshd", "-D", "-e"]


