# Download Base Image
FROM nginx:latest

# Set environment variables
ARG domain
ARG RSYNC_PASSWORD
ENV VIRTUAL_HOST $domain
ENV LETSENCRYPT_HOST $domain

# Copy cron
ADD cron /etc/cron.d/fdroid-t

# Copy nginx
ADD nginx /etc/nginx/sites-available/fdroid

# Setting up environment
RUN mkdir -p /var/www/fdroid/fdroid/repo && \
    envsubst < /etc/cron.d/fdroid-t > /etc/cron.d/fdroid && \
    rm /etc/cron.d/fdroid-t && \
    envsubst < /etc/nginx/sites-available/fdroid \
    > /etc/nginx/sites-available/fdroid.conf && \
    rm /etc/nginx/sites-available/fdroid && \
    apt update && \
    apt install -y rsync nano cron htop iproute2 tzdata curl supervisor && \
    chown -R www-data:www-data /var/www/fdroid && \
    chmod 0644 /etc/cron.d/fdroid && \
    ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    ln -s /etc/nginx/sites-available/fdroid.conf /etc/nginx/conf.d/ && \
    service cron start


# Nginx & Cron foreground mode
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
