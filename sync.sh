if [ -z "$1" ]; then
    echo "Usage: $0 <host>"
    exit 1
fi

HOST=$1
RSYNC="rsync -rv --exclude .git --exclude venv --exclude __pycache__'"
USER=${USER:-bazzite}

set -e

meson build/ -Dforce_fallback_for=stb,libdisplay-info,libliftoff,wlroots,vkroots
ninja -C build/
scp build/src/gamescope ${HOST}:gamescope

ssh $HOST /bin/bash << EOF
    sudo rpm-ostree usroverlay --hotfix
    sudo mv ~/gamescope /usr/bin/gamescope
    bazzite-session-select gamescope
    # sudo reboot
EOF
