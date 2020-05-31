# Squid Proxy

Squid proxy with domain whitelisting. Docker image is based on [Red Hat Universal Base Image](https://developers.redhat.com/products/rhel/ubi/).

## QuickStart

```sh
# Build and run docker image
docker build . -t squid
docker run --rm -it -p 3128:3128 squid

# Test Proxy
curl -I https://www.google.com -x localhost:3128
```

## Whitelist Domains Configuration

Default configuration allows only port HTTPS on 443 with whitelist domains specified in `whitelist_dmains.acl`.

```sh
# Option 1: Run with inline environment variables
$ docker run --rm -it --name squid -p 3128:3128 -e WHITELIST_DOMAINS=".x.com
.b.com" squid

# Option 2: Set multi-line environment variable (double quoting variables will preserve whitespace characters)
$ DOMAINS=".google.com
.microsoft.com"
$ docker run --rm -it --name squid -p 3128:3128 -e WHITELIST_DOMAINS="$DOMAINS" squid
```
