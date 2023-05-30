FROM alpine:3.18

ARG S6_VERSION=v3.1.5.0
ARG S6_DIR=/
ARG S6_SRC_URL="https://github.com/just-containers/s6-overlay/releases/download"

# Install S6 Overlay
RUN mkdir -p $S6_DIR; \
    export SYS_ARCH=$(uname -m); \
    case "$SYS_ARCH" in \
        aarch64 ) export S6_ARCH='aarch64' ;; \
        arm64   ) export S6_ARCH='aarch64' ;; \
        armhf   ) export S6_ARCH='armhf'   ;; \
        arm*    ) export S6_ARCH='arm'     ;; \
        i4*     ) export S6_ARCH='i486'    ;; \
        i6*     ) export S6_ARCH='i686'    ;; \
        s390*   ) export S6_ARCH='s390x'   ;; \
        *       ) export S6_ARCH='x86_64'  ;; \
    esac; \
    untar (){ \
        echo "Downloading $1"; \
        wget --no-check-certificate -O- $1 | tar Jxp -C $S6_DIR; \
    }; \
    \
    echo "Downloading s6 overlay:${S6_ARCH}-${S6_VERSION} for ${SYS_ARCH}" \
        && untar ${S6_SRC_URL}/${S6_VERSION}/s6-overlay-noarch.tar.xz \
        && untar ${S6_SRC_URL}/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.xz

COPY rootfs /

ENTRYPOINT ["/init"]
