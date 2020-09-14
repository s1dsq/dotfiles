source ~/.shell/functions.sh

if [ -f ~/.shell_local_before ]; then
    source ~/.shell_local_before
fi

if [ -f ~/.zsh_local_before ]; then
    source ~/.zsh_local_before
fi

source ~/.zsh/plugins_before.zsh

source ~/.shell/aliases.sh

source ~/.zsh/settings.zsh

source ~/.zsh/plugins_after.zsh

if [ -f ~/.shell_local_after ]; then
    source ~/.shell_local_after
fi

if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi

