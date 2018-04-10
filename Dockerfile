FROM minio/mc:RELEASE.2018-02-09T23-07-36Z

ENV MINIO=minio_needed_to_be_purge
# List of bucket separate by ; all buckets if empty
ENV BUCKETS
# Number of retention days
ENV RETENTION=7

RUN apk add --no-cache bash
RUN apk add --update --no-cache coreutils

COPY entrypoint.sh .
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
