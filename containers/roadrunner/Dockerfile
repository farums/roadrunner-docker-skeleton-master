# ----------------------------------------------- Build Time Arguments ---------------------------------------------
ARG PHP_IMAGE_VERSION="8.0-cli-alpine3.12"
ARG COMPOSER_VERSION="2.0"
ARG ROADRUNNER_VERSION="2.0.4"

# ------------------------------------------------- Composer Image -------------------------------------------------
FROM composer:${COMPOSER_VERSION} as composer
# ------------------------------------------------- RoadRunner Image -----------------------------------------------
FROM spiralscout/roadrunner:${ROADRUNNER_VERSION} as roadrunner
# ==================================================================================================================
#                                                  --- BASE PHP ---
# ==================================================================================================================
FROM php:${PHP_IMAGE_VERSION} as base

RUN apk update && apk add --no-cache \
  libzip-dev \
  unzip \
  curl \
  make

# Install PHP Extensions
RUN docker-php-ext-install zip \
  && docker-php-ext-install sockets \
  && docker-php-ext-install opcache \
  && docker-php-ext-enable opcache

ARG WORK_DIR="/app"
WORKDIR ${WORK_DIR}
# ------------------------------------------------ VsCode Setup --------------------------------------------------
FROM base as development

# Copy Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
# Copy RoadRunner
COPY --from=roadrunner /usr/bin/rr /usr/bin/rr
COPY ./docker-dev-entrypoint.sh /usr/local/bin/entrypoint
CMD ["entrypoint"]