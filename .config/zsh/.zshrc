stty start undef
stty stop undef
stty lnext undef

setopt autocd globdots interactive_comments
autoload -U colors compinit && colors && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

################################################################################
# History settings                                                             #
################################################################################
setopt histignorespace histignorealldups

HISTSIZE=500000
SAVEHIST=500000

HISTORY_IGNORE="(exit|history"
HISTORY_IGNORE="$HISTORY_IGNORE|..|~|cd|cd -|cd .."
HISTORY_IGNORE="$HISTORY_IGNORE|? *|?b *|?d *|?g *|search-with-lynx *"
HISTORY_IGNORE="$HISTORY_IGNORE|ls|ll|la"
HISTORY_IGNORE="$HISTORY_IGNORE|powerof|reboot|shutdown"
HISTORY_IGNORE="$HISTORY_IGNORE|rm *"
HISTORY_IGNORE="$HISTORY_IGNORE|bash|sh|zsh"
HISTORY_IGNORE="$HISTORY_IGNORE)"

################################################################################
# Vi keybindings                                                               #
################################################################################
bindkey -v

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done ; unset m c

bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M isearch '^P' history-incremental-search-backward
bindkey -M isearch '^N' history-incremental-search-forward

################################################################################
# Aliases and configuration                                                    #
################################################################################
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] \
    && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/nnnrc" ] \
    && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/nnnrc"

################################################################################
# Zsh plugins                                                                  #
################################################################################
zsh_plugins_path="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins";
#
# zsh-syntax-completions
if [ -f "$zsh_plugins_path/zsh-syntax-completions/zsh-syntax-completions.zsh" ] ; then
    source "$zsh_plugins_path/zsh-syntax-highlighting/zsh-syntax-completions.zsh"
fi

# zsh-autosuggestions
if [ -f "$zsh_plugins_path/zsh-autosuggestions/zsh-autosuggestions.zsh" ] ; then
    source "$zsh_plugins_path/zsh-autosuggestions/zsh-autosuggestions.zsh"
    bindkey '^ ' autosuggest-accept
fi

# zsh-syntax-highlighting
if [ -f "$zsh_plugins_path/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] ; then
    source "$zsh_plugins_path/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

unset zsh_plugins_path

eval "$(starship init zsh)"
