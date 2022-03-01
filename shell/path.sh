export MANPATH="/usr/local/man:$MANPATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

PATH=".:$PATH"
PATH="$DOTFILES/bin:$PATH"                           # Look in CWD first
PATH="$HOME/bin:$PATH"                               # Handwritten stuff
# PATH=$GOBIN:$PATH                                    # Go
PATH="/usr/local/bin:$PATH"                          # user bin before system bin
PATH="./node_modules/.bin:$PATH"                     # use local packages before global
PATH="$HOME/.node_global/bin:$PATH"                  # npm installed -g
# PATH="/usr/local/go/bin:$PATH"                       # Go
# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # GNU coreutils
# PATH="$HOME/.rbenv/bin:$PATH"                        # https://github.com/rbenv/rbenv

export PATH
