FROM quay.io/renokico/browser-streamer:1.0

# Fix permission issue: Render's build process sometimes strips
# execute permission from entrypoint.sh. This restores it.
USER root
RUN chmod +x *.sh || chmod +x /*.sh || find / -maxdepth 2 -name "*.sh" -exec chmod +x {} \; || true

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
