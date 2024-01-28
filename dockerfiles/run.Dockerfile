FROM gcr.io/buildpacks/google-22/run

USER root

RUN apt-get update && apt-get install -y \
    gdbmtool libgdbm-dev rocksdb-tools librocksdb-dev

USER cnb
