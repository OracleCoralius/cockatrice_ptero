FROM ubuntu:26.04

LABEL author="OracleCoralius" maintainer="rodneys.developers@gmail.com"
ENV DEBIAN_FRONTEND=noninteractive

# Install runtime dependencies for Servatrice (Qt5/Qt6) and curl for downloading updates
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tzdata \
    libqt5core5a libqt5network5 libqt5sql5 libqt5sql5-mysql libqt5websockets5 \
    libqt6core6 libqt6network6 libqt6sql6 libqt6sql6-mysql libqt6websockets6 \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/container -m container
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
