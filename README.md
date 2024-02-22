# Title

## Adding git completion for the Shell

Add the following line to your .bashrc:

```bash
source ~/utils/git-completion.bash
```

## Global git configuration

Create symbolic link to local git.config to use it as global Git configuration:

```bash
ln -s ~/utils/git.config ~/.gitconfig
```

## Git scripts source

git-completion.bash is taken from
<https://raw.githubusercontent.com/git/git/master/contrib/completion/>

```bash
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
```

## Show diff output as two windows in vimdiff

To use you can create a symbolic link to `xd` in `/usr/local/bin`:

```bash
ln -s ~/utils/xd /usr/local/bin/xd
```

Example usage:

```bash
git diff ... |xd
hg diff ... |xd
svn diff ... |xd
cat some.patch |xd
```

You can also preprocess diff output to get more precise results:

```bash
  git diff ... |grep -v ... |sed ... |xd
  cat some.patch |grep -v ... |sed ... |xd
```

## Install oh-my-zsh

Install zsh

```bash
sudo apt install zsh
```

Make zsh the default shell

```bash
chsh -s /bin/zsh
```

Install SF-Mono-Powerline font

```bash
mkdir -p ~/.fonts
git clone <https://github.com/Dambe/SF-Mono-Powerline.git> ~/src/fonts/SF-Mono-Powerline
```

Install oh-my-zsh

```bash
sh -c "$(curl -fsSL <https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh>)"
rm ~/.zshrc
```

Create symlinks

```bash
ln -s ~/src/utils/oh-my-zsh.rc ~/.zshrc
ln -s ~/src/utils/amuse_own.zsh-theme ~/.oh-my-zsh/themes/amuse_own.zsh-theme
source ~/.zshrc
```

## Setup tmux

Install tmux

```bash
sudo apt install tmux
```

Create symlink for tmux configuration

```bash
ln -s ~/src/utils/tmux.conf ~/.tmux.conf
```

Install tmux plugin manager (TPM). Refer to <https://github.com/tmux-plugins/tpm>

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Start tmux using `tmux -2` and run the following command

```bash
tmux source ~/.tmux.conf
```

To install plugins, press `prefix + I` (capital i, as in Install) to fetch the plugins.

## Install shell color theme base16

Refer to <https://github.com/chriskempson/base16-shell>

```bash
git clone <https://github.com/chriskempson/base16-shell.git> ~/.config/base16-shell
```

## Setup vim

Create symlink to vim configuration

```bash
ln -s ~/src/utils/vim.rc ~/.vimrc
```

Install vim Plugin Manager vim-plug.
Refer to <https://github.com/junegunn/vim-plug>

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    <https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim>
```

Open vim and type `:PlugInstall` to install plugins.
