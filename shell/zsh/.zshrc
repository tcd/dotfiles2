HISTSIZE=10000
SAVEHIST=10000
export HISTFILE=~/.cache/shell/.zsh_history

export DOTFILES=$HOME/.dotfiles
export SHELL=/usr/bin/zsh

# =============================================================================

# Figure out where we are
source $DOTFILES/shell/set-os.sh

# Source our dotfiles
for file in $DOTFILES/shell/*.sh; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

[[ -f "$DOTFILES/ignore/.private" ]] && source "$DOTFILES/ignore/.private"
source "$DOTFILES/shell/zsh/prompt.zsh"
# source "$DOTFILES/shell/zsh/clipcopy.zsh"
source "$DOTFILES/shell/functions/.fzf.functions.sh"

# =============================================================================
#  Syntax
# =============================================================================
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[builtin]='fg=12'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=13'
ZSH_HIGHLIGHT_STYLES[path]='fg=6'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=7'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=7'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=7'
ZSH_HIGHLIGHT_STYLES[function]='fg=3'
ZSH_HIGHLIGHT_STYLES[command]='fg=2'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=13'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=5'
ZSH_HIGHLIGHT_STYLES[alias]='fg=4'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=12'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=11'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=11'

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=15'

# =============================================================================
# Fix issues with zsh completion:
function fixzsh() {
  rm ~/.zcompdump*;
  rm ~/.antigen/.zcompdump*;
  rm ~/.zplug/zcompdump*;
  exec zsh;
}
# =============================================================================

fpath=($DOTFILES/shell/zsh/completion $fpath)

# dotnet cli completion
# source $DOTFILES/shell/zsh/functions/dotnet.completions.zsh
# source $DOTFILES/shell/zsh/functions/awscli.completions.sh
# Clipboard compat for MacOS/Linux
# source $DOTFILES/shell/zsh/functions/clipcopy.zsh
# source $DOTFILES/shell/zsh/functions/fzf-docker.plugin.zsh

# =============================================================================
# If this option is unset, output flow control via start/stop characters
# (usually assigned to ^S/^Q) is disabled in the shell's editor.
# stty start undef
# stty stop undef
setopt noflowcontrol

# setopt no_case_glob
# setopt correctall

setopt auto_cd            # Implied cd if you just type a directory name
setopt menu_complete
setopt auto_pushd
# setopt auto_list
# setopt clobber
# setopt interactive_comments
# setopt nolistambiguous

# [ -z "$HISTFILE" ] && HISTFILE=$HOME/.cache/shell/.zsh_history
# HISTSIZE=10000
# SAVEHIST=10000

setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
# setopt inc_append_history
setopt APPEND_HISTORY          # append rather than overwrite history file.

# =============================================================================
# zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

autoload -Uz compinit && compinit

# compdef "_files -W ~/.ghq/github.com/ -/" ghq

# =============================================================================
#  Mappings
# =============================================================================
bindkey -e
# make <S-Tab> work *correctly*
bindkey '^[[Z' reverse-menu-complete

# Control + backspace
bindkey '^H' backward-kill-word

# bindkey ";5C" forward-word
# bindkey ";5D" backward-word

bindkey '[C' forward-word
bindkey '[D' backward-word
bindkey "^[[1;5C" forward-word   # Ubuntu
bindkey "^[[1;5D" backward-word  # Ubuntu
# bindkey "^[[1;5C" forward-word   # CentOS 7
# bindkey "^[[1;5D" backward-word  # CentOS 7

# # History Searching
# autoload history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end

# bindkey '^[[A' history-beginning-search-backward-end
# bindkey '^[[B' history-beginning-search-forward-end

WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# =============================================================================
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# export FZF_COMPLETION_TRIGGER='**'

source ~/.zsh/plugins/fzf-marks/fzf-marks.plugin.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/dircolors.sh ] && eval $(dircolors ~/dircolors.sh)

export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

stty erase "^?"
