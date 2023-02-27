#!/bin/bash

# تعیین نام ورودی و نام خروجی فایل داکری
INPUT_FILE="my_app.jar"
DOCKER_IMAGE_NAME="my_app_image"

# تعیین نام کانتینر
CONTAINER_NAME="my_app_container"

# ساخت دایرکتوری و کپی فایل ورودی
mkdir -p /tmp/docker-build
cp $INPUT_FILE /tmp/docker-build

# ساخت فایل Dockerfile
cat << EOF > /tmp/docker-build/Dockerfile
FROM openjdk:11-jre-slim
COPY $INPUT_FILE /app.jar
CMD ["java", "-jar", "/app.jar"]
EOF

# ساخت تصویر داکری
cd /tmp/docker-build
docker build -t $DOCKER_IMAGE_NAME .

# حذف دایرکتوری و فایل‌های موقتی
cd ~
rm -rf /tmp/docker-build

