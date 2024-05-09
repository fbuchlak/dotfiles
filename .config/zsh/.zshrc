stty start undef
stty stop undef
stty lnext undef

setopt autocd globdots interactive_comments
autoload -U colors compinit; colors
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

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

function vi-yank-xclip {
    zle vi-yank
   echo -n "$CUTBUFFER" | xclip  -selection clipboard
}
zle -N vi-yank-xclip

bindkey -M vicmd "y" vi-yank-xclip
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M isearch '^P' history-incremental-search-backward
bindkey -M isearch '^N' history-incremental-search-forward

# ci"
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M "$m" "$c" select-quoted
  done
done

# ci{, ci(
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}"${(s..)^:-'()[]{}<>bB'}"; do
    bindkey -M "$m" "$c" select-bracketed
  done
done

################################################################################
# Other keybindings                                                            #
################################################################################
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey '^R' history-incremental-search-backward

bindkey -s '^B' '^u tmux\n'
bindkey -s '^F' '^u cd "$(dirname "$(FZF_DEFAULT_COMMAND="fd -t f --min-depth 1" fzf)")"; clear; echo "pwd:\\n\\033[0;31m$(pwd)\\033[0m"\n'
bindkey -s '^G' '^u cd "$(FZF_DEFAULT_COMMAND="fd -H --exclude .dotgit --exclude .cache --exclude .local/state -t d --min-depth 1 --max-depth=2" fzf)"; clear; echo "pwd:\\n\\033[0;31m$(pwd)\\033[0m"\n'
bindkey -s '^O' '^u cd ..\n'

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
# zsh-completions
if [ -f "$zsh_plugins_path/zsh-completions/zsh-completions.plugin.zsh" ] ; then
    source "$zsh_plugins_path/zsh-completions/zsh-completions.plugin.zsh"
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
