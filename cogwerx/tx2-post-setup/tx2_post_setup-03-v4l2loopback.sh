## Post-JetPack3.2 install setup: v4l2loopback Kernel Module
# NOTE: run as root (use sudo -s)

# Get source from umlaeute repo
cd /tmp    # or your preferred source dir
git clone https://github.com/umlaeute/v4l2loopback

# Build module, and install
cd /tmp/v4l2loopback
make
make install

# Enable kernel module (ensure you have prepped kernel first, with tx2-post-setup script 02)
depmod -a


















