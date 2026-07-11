FROM quay.io/renokico/browser-streamer:1.0

# Fix permission issue: Render's build process sometimes strips
# execute permission from entrypoint.sh. This restores it.
USER root
RUN chmod +x *.sh || chmod +x /*.sh || find / -maxdepth 2 -name "*.sh" -exec chmod +x {} \; || true

# Lower resolution/framerate/bitrate to fit within Render Free tier's 512MB RAM limit
ENV SCREEN_WIDTH=960
ENV SCREEN_HEIGHT=540
ENV VIDEO_FRAMERATE=15
ENV VIDEO_BITRATE=800

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
