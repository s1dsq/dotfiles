if [ -f ~/.zsh/plugins_before.zsh ]; then
    source ~/.zsh/plugins_before.zsh
fi

if [ -f ~/.shell/aliases.sh ]; then
    source ~/.shell/aliases.sh
fi

if [ -f ~/.shell/functions.sh ]; then
    source ~/.shell/functions.sh
fi

if [ -f ~/.zsh/settings.zsh ]; then
    source ~/.zsh/settings.zsh
fi

if [ -f ~/.zsh/plugins_after.zsh ]; then
    source ~/.zsh/plugins_after.zsh
fi

