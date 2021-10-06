echo '\033[0;36m      _              '
echo '\033[0;36m     (_)_ _____ ____ '
echo '\033[0;36m    / / // / _ `/ _ \'
echo '\033[0;36m __/ /\_,_/\_,_/_//_/'
echo '\033[0;36m|___/                '
echo
echo '\033[0;35m   /w '$(awk -F "=" '/^NAME/ {print $2}' < /etc/os-release )
echo '\033[0;34m    @ '$HOST

#Install zinit if no zinit is present
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zinit/bin/zinit.zsh"

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search

zinit ice lucid wait
zinit light zdharma/fast-syntax-highlighting
zinit ice lucid wait
zinit light agkozak/zsh-z

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zstyle ':completion:*' auto-description 'specify: %F{magenta}%d%f'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %F{magenta}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %F{blue}%p%s%f  %l
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/juan/.zshrc'
autoload -Uz compinit
compinit
HISTFILE=~/.cache/.zhistory
HISTSIZE=8192
SAVEHIST=8192
setopt autocd extendedglob nomatch notify auto_pushd
unsetopt beep
zmodload zsh/complist

#vi mone
bindkey -v
export KEYTIMEOUT=1

#edit in vim
autoload edit-command-line
zle -N edit-command-line
bindkey '' edit-command-line

export ZSHZ_CASE=smart
export ZSHZ_DATA="$HOME/.cache/z"
zz () {
  cd `z -l $* | fzf | awk '{print $2}'`
}
alias zc="z -c"


n ()
{
  # Block nesting of nnn in subshells
  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi
  NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  nnn "$@" "-G"
  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null
  fi
}

# get cheat sheet
cb () {
  curl -s cht.sh/$* | bat --decorations never
}

#start mpv detached
dmpv () {
  mpv $* &> /dev/null &
  disown
}

#config location
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export GOPATH=$HOME/.cache/go
export LESSHISTFILE=/dev/null
export LYNX_CFG=$HOME/.config/lynx/lynxrc
export WINEPREFIX="$HOME/.config/wine"
export TASKRC=$HOME/.config/task/taskrc

#settings for software
export FZF_DEFAULT_OPTS="--reverse --cycle --height=40% --border sharp --prompt=🔎"
export GPG_TTY=$(tty) # fixes gpg

#colored output
export LESS_TERMCAP_md=$'\e[01;35m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;100;37m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;36m'
export LESS_TERMCAP_ue=$'\e[0m'
export MANWIDTH=${MANWIDTH:-78}
export MANLESS="Manual\ \$MAN_PN\ ?ltline\ %lt?L/%L.:byte\ %bB?s/%s..?\:?pB\ %pB\\%.."
export LESS="-RSM~"

#local path
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.scripts:${HOME}/cargo/bin:${HOME}/.cache/go/bin"
export MANPATH="${MANPATH}:${HOME}/.local/share/man"

#ccache support
export USE_CCACHE=1
export PATH="/usr/lib/ccache/bin${PATH:+:}$PATH"

alias     b='bat -n'
alias btctl='bluetoothctl'
alias    cp='cp -iv'
alias    df='df -h'
alias  diff='diff --color=auto'
alias     e='emerge'
alias  free='free -h'
alias     g='git'
alias  grep='grep --color=auto'
alias  info="info --vi-keys"
alias    ip='ip -color=auto'
alias    la='ls -a --color=auto'
alias    ll='ls -l --color=auto'
alias    ls='ls --color=auto'
alias   nya='doas'
alias     p='python'
alias    se='doas emerge'
alias    sp='doas pacman'
alias   ssh='TERM="xterm-256color" ssh'
alias    sv='doasedit.sh'
alias     t='task'
alias     v='nvim'
alias    vw='nvim -c VimwikiIndex'
alias yt-dl='youtube-dl --sub-lang en,zh-Hant --audio-format best'

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey ' ' magic-space
