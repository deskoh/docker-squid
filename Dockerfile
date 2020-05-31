ARG BASE_REGISTRY=registry.access.redhat.com
ARG BASE_IMAGE=ubi7/ubi-minimal
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG} as base

RUN microdnf update -y && rm -rf /var/cache/yum
RUN microdnf --nodocs install squid && microdnf clean all && \
    ln -sf /dev/stdout /var/log/squid/access.log && \
    ln -sf /dev/stdout /var/log/squid/cache.log && \
    chown -R squid:squid /var/log/squid && \
    touch /var/run/squid.pid && \
    chown -R squid:squid /var/run/squid.pid;

COPY --chown=root:squid squid.conf /etc/squid/
RUN chmod -R ug-x,o-rwx /etc/squid/squid.conf

COPY --chown=root:squid whitelist_domains.acl /etc/squid/
RUN chmod 660 /etc/squid/whitelist_domains.acl

COPY --chown=squid:squid ./entrypoint.sh /
RUN chmod 700 /entrypoint.sh

USER squid

ENV WHITELIST_DOMAINS=

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/squid", "-N"]
