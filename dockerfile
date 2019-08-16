# Download Base Image
FROM nginx:latest

# Set environment variables
ARG domain
ARG RSYNC_PASSWORD
ENV VIRTUAL_HOST $domain
ENV LETSENCRYPT_HOST $domain

# Copy cron
ADD cron /etc/cron.d/fdroid

# Copy nginx
ADD nginx /etc/nginx/sites-available/fdroid

# Setting up environment
RUN mkdir -p /var/www/fdroid/fdroid/repo && \
    envsubst < /etc/cron.d/fdroid > /etc/cron.d/fdroid.cron && \
    rm /etc/cron.d/fdroid && \
    envsubst < /etc/nginx/sites-available/fdroid \
    > /etc/nginx/sites-available/fdroid.conf && \
    rm /etc/nginx/sites-available/fdroid && \
    apt update && \
    apt install -y rsync nano cron htop iproute2 tzdata curl && \
    chown -R www-data:www-data /var/www/fdroid && \
    chmod 0644 /etc/cron.d/fdroid.cron && \
    ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    ln -s /etc/nginx/sites-available/fdroid.conf /etc/nginx/conf.d/ && \
    service cron start


# Nginx foreground mode
CMD nginx -g 'daemon off;'
