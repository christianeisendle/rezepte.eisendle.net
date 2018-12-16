FROM alpine
ARG HUGO_UID


RUN apk add --update \
    py-pygments \
  && rm -rf /var/cache/apk/*

ENV HUGO_VERSION 0.52
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
ENV HUGO_USER hugo

ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} /tmp/hugo.tar.gz
RUN mkdir -p /opt/hugo \
        && tar xzf /tmp/hugo.tar.gz -C /opt/hugo/ \
	&& ln -s /opt/hugo/hugo /usr/bin/hugo \
        && rm /tmp/hugo.tar.gz

RUN mkdir /hugo

RUN adduser -u ${HUGO_UID} -D ${HUGO_USER}
RUN chown ${HUGO_USER} /hugo
USER ${HUGO_USER} 
WORKDIR /hugo

EXPOSE 1313

ENV HUGO_BASE_URL http://localhost:1313
CMD hugo server -b ${HUGO_BASE_URL} --bind=0.0.0.0

