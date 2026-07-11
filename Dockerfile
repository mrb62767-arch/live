FROM quay.io/renokico/browser-streamer:1.0

USER root

# Lower resolution/framerate/bitrate to fit within Render Free tier's 512MB RAM limit
ENV SCREEN_WIDTH=960
ENV SCREEN_HEIGHT=540
ENV VIDEO_FRAMERATE=15
ENV VIDEO_BITRATE=800

# Fix permission issue: Render's build process sometimes strips
# execute permission from entrypoint.sh and other scripts. This restores it.
# Placed last (and with --no-cache-ish uniqueness) so it always re-runs.
RUN chmod +x /*.sh 2>/dev/null; chmod +x ./*.sh 2>/dev/null; find / -maxdepth 3 -name "*.sh" -exec chmod 755 {} \; 2>/dev/null; echo "permissions fixed"

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
