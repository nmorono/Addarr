FROM python:alpine

WORKDIR /app

ARG PUID=1234
ARG PGID=1234

# Install requirements
RUN apk add --no-cache \
            transmission-cli

# Copy files to container
COPY . /app

# Create a group and user
RUN addgroup -S appgroup -g$PGID && adduser -S appuser -G appgroup -u$PUID && chown -R appuser:appgroup /app
USER appuser

# Install ans build Addarr requirements, make symlink to redirect logs to stdout
RUN	pip install --no-cache-dir -r requirements.txt --upgrade

ENTRYPOINT ["python", "/app/addarr.py"]
