from gcc:bullseye as builder

ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'Acquire::Retries "10";' > /etc/apt/apt.conf.d/90retries

# Build dependencies
RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
                       cmake \
                       gsfonts \
                       xdg-utils \
                       qtbase5-dev \
                       libxt-dev \
                       libpaper-dev \
                       libfreetype-dev \
                       libcups2-dev \
                       libjpeg62-turbo-dev \
                       libtiff-dev \
                       libpng-dev \
                       zlib1g-dev \
                       libqt5svg5-dev \
                       libfontconfig1-dev \
                       qttools5-dev \
    && rm -rf rm -rf /var/lib/apt/lists/*

# Create the directory structure for building xpdf
RUN mkdir -p /xpdf-build/pkg /xpdf-build/src

# Fetch the xpdf source code
COPY ./xpdf-4.04.tar.gz /xpdf-build/xpdf-4.04.tar.gz

RUN tar -xf /xpdf-build/xpdf-4.04.tar.gz -C /xpdf-build/src

# Build the source code
WORKDIR /xpdf-build/src/xpdf-4.04
RUN cmake -DCMAKE_BUILD_TYPE=None \
          -DCMAKE_INSTALL_PREFIX=/xpdf-build/pkg \
          -DCMAKE_CXX_COMPILER=g++ .

# Build the project
RUN cmake --build .
# Install the built files in pkg directory
RUN cmake --install .

FROM debian:bullseye-slim AS xpdf

ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'Acquire::Retries "10";' > /etc/apt/apt.conf.d/90retries

# Build dependencies
RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
                       gsfonts \
                       xdg-utils \
                       libqt5core5a \
                       libxt6 \
                       libpaper1 \
                       libfreetype6 \
                       libcups2 \
                       libjpeg62-turbo \
                       libtiff5 \
                       libpng16-16 \
                       zlib1g \
                       libqt5svg5 \
                       libfontconfig1 \
    && rm -rf rm -rf /var/lib/apt/lists/*

COPY --from=builder /xpdf-build/pkg /opt/xpdf
ENV PATH="/opt/xpdf/bin:${PATH}"
