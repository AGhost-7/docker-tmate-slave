FROM ubuntu:xenial

COPY ./build.sh /tmp/build.sh

RUN /tmp/build.sh && rm /tmp/build.sh

ENV TMATE_KEYS_DIR /keys

ENV TMATE_PORT 2222

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

COPY ./run.sh /run.sh

VOLUME /keys

CMD ["/run.sh"]
