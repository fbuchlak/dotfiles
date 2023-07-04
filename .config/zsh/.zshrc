stty start undef # prevent ^q
stty stop undef # prevent ^s
stty lnext undef # prevent ^v

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/nnnrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/nnnrc"

setopt autocd
setopt completealiases
setopt interactive_comments
setopt prompt_subst
setopt histignorespace
setopt histignorealldups

autoload -U colors && colors

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

git_branch() {
	git symbolic-ref --short HEAD 2> /dev/null
}

PROMPT='%F{red}[%F{cyan}%n%F{red} %F{magenta}%~%F{red}%}] %F{none}%'
RPROMPT='%F{green}$(git_branch)%F{none}%'

HISTSIZE=500000
SAVEHIST=500000

# vi
bindkey -v
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M isearch '^P' history-incremental-search-backward
bindkey -M isearch '^N' history-incremental-search-forward

# Add text object extension -- eg ci" da(:
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done
