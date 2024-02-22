#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "$(date) - This script must be run as root"
	exit 1
fi

apt update
apt upgrade

apt install \
	zsh \
	zsh-autosuggestions \
	zsh-syntax-highlighting \
	vim \
	gparted \
	snapd \
	build-essential \
	git \
	cmake \
	python3 \
	curl \
	wget \
	gnome-tweaks \
	gnome-shell-extensions \
	gnome-shell-extension-manager \
	gnome-shell-extension-desktop-icons-ng \
	vlc \
	tmux \
	keepass2 \
	wireshark \
	iperf3 \
	wakeonlan \
	htop \
	thunderbird \
	fonts-powerline \
	gimp \
	libreoffice

# install vscode
snap install --classic code

# install spotify
snap install spotify

# install obsidian
snap install obsidian

# install brave
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
apt install -y brave-browser

# install Signal (https://signal.org/download/linux/)
# NOTE: These instructions only work for 64-bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.
# 1. Install our official public software signing key:
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
# 2. Add our repository to your list of repositories:
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list
# 3. Update your package database and install Signal:
sudo apt update && sudo apt install signal-desktop

# install shell color theme base16
# https://github.com/chriskempson/base16-shell
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# install vim-plug
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# make zsh the default shell
chsh -s /bin/zsh

# install SF-Mono-Powerline font
mkdir -p ~/.fonts
git clone https://github.com/Dambe/SF-Mono-Powerline.git ~/src/fonts/SF-Mono-Powerline

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc

# install tmux plugin manager (TPM)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# create symlinks
ln -s ~/src/utils/oh-my-zsh.rc ~/.zshrc
ln -s ~/src/utils/amuse_own.zsh-theme ~/.oh-my-zsh/themes/amuse_own.zsh-theme
source ~/.zshrc

ln -s ~/src/utils/tmux.conf ~/.tmux.conf
ln -s ~/src/utils/vim.rc ~/.vimrc
ln -s ~/src/utils/git.config ~/.gitconfig
ln -s ~/src/utils/xd /usr/local/bin/xd

# install gnome extensions
array=( https://extensions.gnome.org/extension/3628/arcmenu/
	https://extensions.gnome.org/extension/1160/dash-to-panel/
	https://extensions.gnome.org/extension/2087/desktop-icons-ng-ding/
	https://extensions.gnome.org/extension/1476/unlock-dialog-background/
	https://extensions.gnome.org/extension/7/removable-drive-menu/
	https://extensions.gnome.org/extension/4548/tactile/
	https://extensions.gnome.org/extension/1723/wintile-windows-10-window-tiling-for-gnome/
for i in "${array[@]}"
do
    EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
    fi
    gnome-extensions enable ${EXTENSION_ID}
    rm ${EXTENSION_ID}.zip
done

echo "Things to do:"
echo "Download SF Fonts and copy them into ~/.fonts (https://developer.apple.com/fonts/)"
echo "Connect Google Account(s) (Settings > Online Accounts)"
echo "Create and copy SSH Key to GitHub Account for syncing"
echo "Clone GitHub repos"
