#!/bin/sh

# cd ~

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
[[ -t 0 ]] && stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# keep PATH free of duplicates
typeset -U path PATH

# history (macOS /etc/zshrc otherwise caps SAVEHIST at 1000)
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_all_dups hist_ignore_space hist_reduce_blanks
setopt share_history inc_append_history extended_history

# case insensitve autocompletion
zmodload zsh/complist			# provides the `menuselect` keymap
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


# beeping is annoying
unsetopt BEEP

# Useful Functions
source "$ZDOTDIR/zsh-functions"
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh


# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-vi-mode"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"

# Key-bindings
command -v ranger >/dev/null && bindkey -s '^o' 'ranger^M'
# bindkey -s '^f' 'zi^M'
# bindkey -s '^s' 'ncdu^M'
command -v fzf >/dev/null && bindkey -s '^f' 'nvim $(fzf)^M'
bindkey -s '^v' 'nvim .^M'
# bindkey -s '^z' 'zi^M'
bindkey '^[[P' delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down
bindkey -r "^u"
bindkey -r "^d"


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

command -v direnv >/dev/null && eval "$(direnv hook zsh)"
