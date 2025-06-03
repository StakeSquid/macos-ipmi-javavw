#!/bin/bash
export DISPLAY=:1
export XAUTHORITY=/root/.Xauthority

# Kill old session if exists
vncserver -kill :1 > /dev/null 2>&1 || true

# Start VNC at desired resolution
vncserver :1 -geometry 1920x1080 -depth 24

# Start noVNC
/opt/novnc/utils/novnc_proxy --vnc localhost:5901 --listen 0.0.0.0:6080 &

# Wait a bit for X session to be ready
sleep 3

# Optional: auto-launch JNLP only if it exists
if [ -f "/data/launch.jnlp" ]; then
  echo "Launching /data/launch.jnlp..."
  javaws /data/launch.jnlp || echo "javaws failed (non-fatal)"
else
  echo "/data/launch.jnlp not found — skipping auto-launch"
fi

# Keep container alive
tail -f /root/.vnc/*.log