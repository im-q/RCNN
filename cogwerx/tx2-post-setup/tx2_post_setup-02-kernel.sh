## Post-JetPack3.2 install setup: Kernel Module prep
# NOTE: run as root (use sudo -s)

# Install prereqs for commands
apt-get update && apt-get -y install libncurses5-dev

# Get kernel source from NVIDIA, unpack to src dir
SRC=https://developer.nvidia.com/embedded/dlc/l4t-sources-28-2
wget -O- $SRC | tar jxvOf - public_release/kernel_src.tbz2 | tar jxvpf - -C /usr/src #ETA: 5 min
gunzip -c /proc/config.gz | perl -p -e 's/CONFIG_LOCALVERSION=""/CONFIG_LOCALVERSION="-tegra"/' | tee /usr/src/kernel/kernel-4.4/.config

# Make module prep
cd /usr/src/kernel/kernel-4.4
make olddefconfig
make prepare
make modules_prepare
make -j6 modules 

# Clean up old, link to new
rm /lib/modules/4.4.38-tegra/build
ln -s /usr/src/kernel/kernel-4.4 /lib/modules/4.4.38-tegra/build
