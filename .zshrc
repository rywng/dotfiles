cat ~/.config/splash 2> /dev/null || true
echo
echo '\033[0;35m   /w '$(awk -F "=" '/^NAME/ {print $2}' 2> /dev/null < /etc/os-release || uname -o)
echo '\033[0;34m    @ '$HOST

# Install zinit if no zinit is present
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$ZINIT_HOME/zinit.zsh"

# Zinit packages

zinit wait lucid for \
    zdharma-continuum/fast-syntax-highlighting \
    agkozak/zsh-z \
    zpm-zsh/colorize \
    juancldcmt/shortify.zsh

zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit light zsh-users/zsh-autosuggestions
zinit light hlissner/zsh-autopair
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-completions

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# The following lines were added by compinstall

zstyle ':completion:*' auto-description '%F{green}Specify%f: %F{cyan}%d%f'
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format '%F{green}Completing%f %F{yellow}%d%f'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %S%F{green}At %p%f: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 16 numeric
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original false
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '%F{green}Completing%f, with %F{red}%e%f errors'
zstyle ':completion:*' select-prompt %S%F{green}Scrolling%f active: current selection at %F{blue}%p%f%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename ~/.zshrc

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zhistory
HISTSIZE=8192
SAVEHIST=8192
setopt autocd extendedglob nomatch notify auto_pushd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

#edit in vim
export KEYTIMEOUT=1
autoload edit-command-line
zle -N edit-command-line
bindkey '' edit-command-line

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '' history-substring-search-up
bindkey '' history-substring-search-down

bindkey ' ' magic-space

bindkey '' autosuggest-execute

#config location
export GOPATH=$HOME/.cache/go
export LESSHISTFILE=/dev/null
export LYNX_CFG=$HOME/.config/lynx/lynxrc
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config

#settings for software
export FZF_DEFAULT_OPTS="--reverse --cycle --height=40% --border sharp --prompt=🔎"
export GPG_TTY=$(tty) # fixes gpg
export JDK_HOME=/usr/lib/jvm/openjdk-17
export _JAVA_AWT_WM_NONREPARENTING=1
export HISTORY_SUBSTRING_SEARCH_FUZZY=1

#colored output
export MANWIDTH=${MANWIDTH:-78}
test -n "$LS_COLORS" || eval $(dircolors) || echo 'Warning: Unable to set LS_COLORS'
export MANLESS="Manual\ \$MAN_PN\ ?ltline\ %lt?L/%L.:byte\ %bB?s/%s..?\:?pB\ %pB\\%.."
export LESS="--use-color -RSM~"

#local path
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.scripts:${HOME}/cargo/bin:${HOME}/.cache/go/bin:${HOME}/.local/share/nvim/mason/bin"
export MANPATH="${MANPATH}:${HOME}/.local/share/man"

#ccache support
export USE_CCACHE=1
export PATH="/usr/lib/ccache/bin${PATH:+:}$PATH"
