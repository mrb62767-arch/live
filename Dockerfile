FROM quay.io/renokico/browser-streamer:1.0

USER root

# Lower resolution/framerate/bitrate to fit within Render Free tier's 512MB RAM limit
ENV SCREEN_WIDTH=960
ENV SCREEN_HEIGHT=540
ENV VIDEO_FRAMERATE=15
ENV VIDEO_BITRATE=800

# Cache-buster: change this value any time to force Docker to skip old cached
# layers and actually re-run the permission fix below.
ARG CACHEBUST=3

# Fix permission issue: Render's build process sometimes strips
# execute permission from entrypoint.sh and other scripts. This restores it.
# Also patch the hardcoded resolution/framerate values inside the scripts
# themselves, since they override any Dockerfile ENV settings at runtime.
RUN chmod +x /*.sh 2>/dev/null; chmod +x ./*.sh 2>/dev/null; \
    find / -maxdepth 3 -name "*.sh" -exec chmod 755 {} \; 2>/dev/null; \
    sed -i 's/SCREEN_WIDTH=1920/SCREEN_WIDTH=960/g' ./entrypoint.sh 2>/dev/null; \
    sed -i 's/SCREEN_HEIGHT=1080/SCREEN_HEIGHT=540/g' ./entrypoint.sh 2>/dev/null; \
    sed -i 's/VIDEO_FRAMERATE=30/VIDEO_FRAMERATE=15/g' ./ffmpeg.sh 2>/dev/null; \
    sed -i 's/VIDEO_BITRATE=3000/VIDEO_BITRATE=800/g' ./ffmpeg.sh 2>/dev/null; \
    grep -n "SCREEN_WIDTH\|SCREEN_HEIGHT" ./entrypoint.sh; \
    grep -n "VIDEO_FRAMERATE\|VIDEO_BITRATE" ./ffmpeg.sh; \
    echo "permissions and resolution fixed, cachebust=3"

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
