FROM quay.io/renokico/browser-streamer:1.0

USER root

# Lower resolution/framerate/bitrate to fit within Render Free tier's 512MB RAM limit
ENV SCREEN_WIDTH=960
ENV SCREEN_HEIGHT=540
ENV VIDEO_FRAMERATE=15
ENV VIDEO_BITRATE=800

# Cache-buster: change this value any time to force Docker to skip old cached
# layers and actually re-run the permission fix below.
ARG CACHEBUST=2

# Fix permission issue: Render's build process sometimes strips
# execute permission from entrypoint.sh and other scripts. This restores it.
RUN chmod +x /*.sh 2>/dev/null; chmod +x ./*.sh 2>/dev/null; find / -maxdepth 3 -name "*.sh" -exec chmod 755 {} \; 2>/dev/null; ls -la /entrypoint.sh ./entrypoint.sh 2>/dev/null; echo "permissions fixed, cachebust=2"

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
