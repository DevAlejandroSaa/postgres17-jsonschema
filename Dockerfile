FROM rust:1.91.1 AS builder

RUN set -eux; \
    apt-get update && apt-get install -y --no-install-recommends \
        git \
        build-essential \
        clang \
        llvm \
        pkg-config \
        libssl-dev \
        libreadline-dev \
        zlib1g-dev \
        bison \
        flex \
        perl \
        ca-certificates \
        libpq-dev \
        postgresql-server-dev-17 \
        && rm -rf /var/lib/apt/lists/*

RUN cargo install cargo-pgrx --version 0.16.1 --locked

ENV PGRX_HOME=/root/.pgrx
RUN cargo pgrx init --pg17 /usr/lib/postgresql/17/bin/pg_config

WORKDIR /src
RUN git clone --branch v0.3.4 https://github.com/supabase/pg_jsonschema.git

WORKDIR /src/pg_jsonschema

RUN cargo pgrx install --pg-config /usr/lib/postgresql/17/bin/pg_config

RUN strip /usr/lib/postgresql/17/lib/pg_jsonschema.so || true

FROM postgres:17

COPY --from=builder /usr/lib/postgresql/17/lib/pg_jsonschema.so /usr/lib/postgresql/17/lib/
COPY --from=builder /usr/share/postgresql/17/extension/pg_jsonschema* /usr/share/postgresql/17/extension/