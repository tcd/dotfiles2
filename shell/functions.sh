# @description Create a directory(s) and cd to it.
#
# @param $1 string Folder or folders to make.
take() {
  mkdir -p "$1"
  cd "$1" || return
}


# @description Define an alias.
watdo() {
  alias | grep "$1"
}

# @description Add all changes and commit with a message.
#
# @param $1 string String for commit message.
komet() {
  git add . && git commit -m "$1" # TODO: filter the input here
}

# # @description Open a manpage with Neovim.
# nman() {
#   nvim -c 'set filetype=man $1'
# }

# @description Copy the contents of a file to your clipboard.
# @param $1 string Name of the file to copy.
yank() {
  cat "$1" | clip.exe;
}

# # @description Copy the contents of your clipboard to a file.
# # @param $1 string Name of the file paste to.
# put() {
#   clippaste > "$1";
# }

# @description Prints an array of colors to test for True Color support.
#
# @noargs
kuler() {
  awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
      r = 255-(colnum*255/76);
      g = (colnum*510/76);
      b = (colnum*255/76);
      if (g>255) g = 510-g;
      printf "\033[48;2;%d;%d;%dm", r,g,b;
      printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
      printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
  }'
}

# @description List escape codes for FN keys.
#
# @noargs
fn_codes() {
  for x in {1..30}; do
    echo -n "F$x "
    tput kf$x | cat -A
    echo
  done
}

# @description Determine size of a file or total size of a directory.
#
# @noargs
siz() {
  if du -b /dev/null >/dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* ./*
  fi
}
