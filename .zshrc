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
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

zinit wait lucid for \
    zdharma-continuum/fast-syntax-highlighting \
    agkozak/zsh-z \
    zpm-zsh/colors \
    rywng/colorize \
    rywng/shortify.zsh

zinit ice wait lucid atinit"bindkey '^ ' autosuggest-execute" atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Atuin history
if ! command -v atuin &> /dev/null ; then
    zinit ice as"command" from"gh-r" bpick"atuin-*.tar.gz" mv"atuin*/atuin -> atuin" \
        atclone"./atuin init zsh --disable-up-arrow > init.zsh; ./atuin gen-completions --shell zsh > _atuin" \
        atpull"%atclone" src"init.zsh"
    zinit light atuinsh/atuin
else
    zinit ice wait lucid \
	atclone"atuin init zsh --disable-up-arrow > init.zsh; atuin gen-completions --shell zsh > _atuin" \
	atpull"%atclone" src"init.zsh"
    if [ -f /usr/share/atuin/shell-init/zsh ] ; then
	zinit snippet /usr/share/atuin/shell-init/zsh # Gentoo installation
    else
	zinit light atuinsh/atuin # other distros
    fi
fi


# Conditional loading of software
if  ! command -v bat &> /dev/null ; then
    zinit ice wait lucid as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
    zinit light sharkdp/bat
fi

if ! command -v direnv &> /dev/null ; then
    zinit ice wait from"gh-r" as"program" mv"direnv* -> direnv" \
        atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
        pick"direnv" src="zhook.zsh" for \
        direnv/direnv
fi

# nix setup
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
    . ~/.nix-profile/etc/profile.d/nix.sh;
    zinit ice wait lucid
    zinit light nix-community/nix-zsh-completions
fi # added by Nix installer

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Set ls colors for GNU/Linux, BSDs doesn't need this
if [[ $(uname) = "Linux" ]]; then
    test -n "$LS_COLORS" || eval $(dircolors) || echo 'Warning: Unable to set LS_COLORS'
fi

# The following lines were added by compinstall
zstyle ':completion:*' auto-description '%F{green}Specify%f: %F{cyan}%d%f'
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format '%F{green}Completing%f %F{yellow}%d%f'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original false
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '%F{green}Completing%f, with %F{red}%e%f errors'
zstyle ':completion:*' select-prompt '%S%F{green}Scrolling%f active: current selection at %F{blue}%p%f%s'
zstyle ':completion:*' substitute 0
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/ryan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTSIZE=2048
setopt autocd autopushd extendedglob nomatch hist_ignore_dups
unsetopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install

# Pure prompt
zstyle ':prompt:pure:git:stash' show yes
zstyle ':prompt:pure:prompt:success' color default

#edit in vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '' edit-command-line

# better CTRL-w
autoload -Uz select-word-style
select-word-style bash

bindkey ' ' magic-space

# config & cache location
export GOPATH=$HOME/.cache/go
export LESSHISTFILE=/dev/null
export LYNX_CFG=$HOME/.config/lynx/lynxrc
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export ZSHZ_DATA=$HOME/.cache/z

# settings for software
export BAT_THEME="base16"
export FZF_DEFAULT_OPTS="--reverse --cycle --height=40% --border sharp --prompt=🔎"
export GPG_TTY=$(tty) # fixes gpg
export LESS="-i $LESS"
export MANROFFOPT="-c"
export MANWIDTH=${MANWIDTH:-78}
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# local path
export MANPATH="${MANPATH}:${HOME}/.local/share/man"
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.scripts:${HOME}/.cache/go/bin:${HOME}/.cargo/bin:${HOME}/.local/share/nvim/mason/bin"
export PATH="/usr/lib/ccache/bin${PATH:+:}$PATH" # ccache support
