export PATH=/opt/local/bin/:$PATH
export PATH=/usr/local/mysql/bin/:$PATH
export PATH=/Library/PostgreSQL/8.4/bin/:$PATH
export PATH=/Users/coreyhaines/.gem/ruby/1.8/bin:$PATH
export EDITOR='mvim -f'

export HISTCONTROL=erasedups
export HISTSIZE=10000

shopt -s histappend

alias ding="say 'ding'"

alias d="cd ~/Documents"
alias p="cd ~/Documents/codes"
alias b="cd ~/Documents/blog\ entries"
alias m="cd ~/Documents/codes/mercuryapp-staging"
alias ma="cd ~/Dropbox/mercury_app"

alias vp='mvim ~/.bash_profile'
alias sp='source ~/.bash_profile'

alias console='rails s'
alias server='rails s'
alias ss='rails s'
alias c='rails c'

alias rk='rake'
alias r="rake routes | grep $1"
alias ok='rake cucumber:ok'
alias rs='rake spec'
alias dbmt='rake db:migrate && rake db:test:prepare'
alias spn="time rspec -I lib/mercury_app/ -I spec_no_rails/"
alias spna="time rspec -I lib/mercury_app/ -I spec_no_rails/ spec_no_rails"
alias rspec="time rspec"
alias rake="time rake"

alias ls="/bin/ls -a"
alias rmdir="/bin/rm -fdr"

alias gst='git status'
alias gb='git branch'
alias gpo='git push origin'
alias gph='git push heroku'
alias gc='git commit -v'
alias gco='git checkout'
alias gca='git commit -v -a'
alias ga='git add'

alias rvmrc="echo 'rvm use $1' > .rvmrc"

set list listchars=tab:\ \ ,trail:·

export HISTIGNORE="fg*"
bind '"\C-f": "fg %-\n"'

export GEMDIR=`gem env gemdir`
set -o vi

gemdoc() {
  open $GEMDIR/doc/`$(which ls) $GEMDIR/doc | grep $1 | sort | tail -1`/rdoc/index.html
}

_gemdocomplete() {
  COMPREPLY=($(compgen -W '$(`which ls` $GEMDIR/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _gemdocomplete gemdoc

if [ -f /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion
fi

source ~/dotfiles/git-completion.bash

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local  BLACK="\[\033[0;0m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

PS1="$GREEN\$(parse_git_branch)$BLACK\$ "
PS2='> '
PS4='+ '
}
proml

function directory_to_titlebar {
   local pwd_length=42  # The maximum length we want (seems to fit nicely
                        # in a default length Terminal title bar).
   # Get the current working directory.  We'll format it in $dir.
   local dir="$PWD"

   # Substitute a leading path that's in $HOME for "~"
   if [[ "$HOME" == ${dir:0:${#HOME}} ]] ; then
       dir="~${dir:${#HOME}}"
   fi

   # Append a trailing slash if it's not there already.
   if [[ ${dir:${#dir}-1} != "/" ]] ; then
       dir="$dir/"
   fi

   # Truncate if we're too long.
   # We preserve the leading '/' or '~/', and substitute
   # ellipses for some directories in the middle.
   if [[ "$dir" =~ (~){0,1}/.*(.{${pwd_length}}) ]] ; then
       local tilde=${BASH_REMATCH[1]}
       local directory=${BASH_REMATCH[2]}

       # At this point, $directory is the truncated end-section of the
       # path.  We will now make it only contain full directory names
       # (e.g. "ibrary/Mail" -> "/Mail").
       if [[ "$directory" =~ [^/]*(.*) ]] ; then
           directory=${BASH_REMATCH[1]}
       fi

       # Can't work out if it's possible to use the Unicode ellipsis,
       # '…' (Unicode 2026).  Directly embedding it in the string does not
       # seem to work, and \u escape sequences ('\u2026') are not expanded.
       #printf -v dir "$tilde/\u2026$s", $directory"
       dir="$tilde/...$directory"
   fi

   # Don't embed $dir directly in printf's first argument, because it's
   # possible it could contain printf escape sequences.
   printf "\033]0;%s\007" "$dir"
}

if [[ "$TERM" == "xterm" || "$TERM" == "xterm-color" ]] ; then
 export PROMPT_COMMAND="directory_to_titlebar"
fi


if [[ -s /Users/coreyhaines/.rvm/scripts/rvm ]] ; then source /Users/coreyhaines/.rvm/scripts/rvm ; fi

date

##
# Your previous /Users/coreyhaines/.bash_profile file was backed up as /Users/coreyhaines/.bash_profile.macports-saved_2010-08-16_at_10:21:32
##

# MacPorts Installer addition on 2010-08-16_at_10:21:32: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

