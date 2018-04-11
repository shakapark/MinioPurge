FROM minio/mc:RELEASE.2018-02-09T23-07-36Z
RUN apk add --no-cache bash
RUN apk add --update --no-cache coreutils
COPY entrypoint.sh .
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
