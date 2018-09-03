FROM rust:stretch as builder
RUN git clone --depth 1 --branch v0.2.2 https://github.com/Spotifyd/spotifyd /spotifyd
RUN apt-get update && apt-get install -y libasound2-dev
RUN cd /spotifyd && cargo build --release

FROM debian:stretch
RUN apt-get update && apt-get install -y libasound2 libasound2-data && rm -rf /var/lib/apt/lists
COPY --from=builder /spotifyd/target/release/spotifyd /spotifyd
RUN useradd --no-create-home --no-user-group --system --uid 19800 --gid audio spotifyd
USER spotifyd:audio
CMD ["/spotifyd", "--no-daemon"]
