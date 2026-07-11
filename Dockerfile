FROM quay.io/renokico/browser-streamer:1.0

# Fix permission issue: Render's build process sometimes strips
# execute permission from entrypoint.sh. This restores it.
USER root
RUN chmod +x ./entrypoint.sh || chmod +x /entrypoint.sh || true

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
