#!/bin/sh
echo "$WHITELIST_DOMAINS" >> /etc/squid/whitelist_domains.acl

# Forward args to CMD
exec "$@"
