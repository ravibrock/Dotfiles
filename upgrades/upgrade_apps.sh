#!/bin/zsh

# Updates formulae and casks
$BREW_PREFIX/bin/brew upgrade
$BREW_PREFIX/bin/brew cu --cleanup --no-brew-update --no-quarantine --quiet --yes

# Updates App Store apps
OUTDATED=$($BREW_PREFIX/bin/mas outdated | /usr/bin/awk '{print $2}')
if [[ ! -z $OUTDATED ]]; then
    /usr/bin/killall $(echo $OUTDATED)
    $BREW_PREFIX/bin/mas upgrade
fi

# Updates Homebrew itself
$BREW_PREFIX/bin/brew update

# Dumps brewfile
$BREW_PREFIX/bin/brew bundle dump --force --file=$DOTFILES/.brewfile

# Cleans up old versions
$BREW_PREFIX/bin/brew cleanup --prune=all

# Updates tldr documentation
$BREW_PREFIX/bin/tldr --verbose --update

# Syncs nvim plugins
$BREW_PREFIX/bin/nvim --headless "+Lazy! sync" +qa

# Updates zsh plugins if needed
cd ~/.zsh
for folder in *; do
    cd $folder
    $BREW_PREFIX/bin/git pull
    cd ..
done
