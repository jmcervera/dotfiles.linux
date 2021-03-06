# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [[ -n  "$PS1" ]] ; then

    # don't put duplicate lines in the history. See bash(1) for more options
    # don't overwrite GNU Midnight Commander's setting of `ignorespace'.
    #HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
    # ... or force ignoredups and ignorespace
    HISTCONTROL=ignoreboth


    # append to the history file, don't overwrite it
    shopt -s histappend

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
   	HISTSIZE=1000
	HISTFILESIZE=2000

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    #force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	    # We have color support; assume it's compliant with Ecma-48
	    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	    # a case would tend to support setf rather than setaf.)
	    color_prompt=yes
        else
	    color_prompt=
        fi
    fi

    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
    esac

    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        #alias dir='dir --color=auto'
        #alias vdir='vdir --color=auto'

        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi

    # some more ls aliases
    alias ll='ls -l'
    alias la='ls -A'
    alias l='ls -CF'

    # Some git alias
    alias gs='git status '
    alias ga='git add '
    alias gb='git branch '
    alias gc='git commit'
    alias gd='git diff'
    alias go='git checkout '
    alias gk='gitk --all&'


    # Alias definitions.
    # You may want to put all your additions into a separate file like
    # ~/.bash_aliases, instead of adding them here directly.
    # See /usr/share/doc/bash-doc/examples in the bash-doc package.

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi

    export PATH=$HOME/bin:$PATH
    export EDITOR=gvim

    #RUBYLIB=/usr/lib/ruby/1.8/x86_64-linux/ ; export RUBYLIB

    ######################################################################

    # http://rvm.beginrescueend.com/workflow/prompt/
    #PS1="\$(~/.rvm/bin/rvm-prompt i v p g s) $PS1"

    ######################################################################

    #Tammer Saleh: http://tammersaleh.com/posts/a-better-rvm-bash-prompt
    #-------------------------------------------------------------------

    function __git_dirty {
      git diff --quiet HEAD &>/dev/null
      [ $? == 1 ] && echo "!"
    }

    function __git_branch {
      __git_ps1 " %s"
    }

    function __my_rvm_ruby_version {
      local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
      [ "$gemset" != "" ] && gemset="@$gemset"
      local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
      [ "$version" == "1.8.7" ] && version=""
      local full="$version$gemset"
      [ "$full" != "" ] && echo "$full "
    }

    bash_prompt() {
      local NONE="\[\033[0m\]"    # unsets color to term's fg color

      # regular colors
      local K="\[\033[0;30m\]"    # black
      local R="\[\033[0;31m\]"    # red
      local G="\[\033[0;32m\]"    # green
      local Y="\[\033[0;33m\]"    # yellow
      local B="\[\033[0;34m\]"    # blue
      local M="\[\033[0;35m\]"    # magenta
      local C="\[\033[0;36m\]"    # cyan
      local W="\[\033[0;37m\]"    # white

      # emphasized (bolded) colors
      local EMK="\[\033[1;30m\]"
      local EMR="\[\033[1;31m\]"
      local EMG="\[\033[1;32m\]"
      local EMY="\[\033[1;33m\]"
      local EMB="\[\033[1;34m\]"
      local EMM="\[\033[1;35m\]"
      local EMC="\[\033[1;36m\]"
      local EMW="\[\033[1;37m\]"

      # background colors
      local BGK="\[\033[40m\]"
      local BGR="\[\033[41m\]"
      local BGG="\[\033[42m\]"
      local BGY="\[\033[43m\]"
      local BGB="\[\033[44m\]"
      local BGM="\[\033[45m\]"
      local BGC="\[\033[46m\]"
      local BGW="\[\033[47m\]"

      local UC=$W                 # user's color
      [ $UID -eq "0" ] && UC=$R   # root's color

      PS1="$B\$(__my_rvm_ruby_version)$Y\h$W:$EMY\w$EMW\$(__git_branch)$EMY\$(__git_dirty)${NONE} $ "
    }

    bash_prompt
    unset bash_prompt
    ######################################################################


    # bundle exec bash shortcut
    # http://twistedmind.com/bundle-exec-bash-shortcut

    bundle_commands=( spec rspec cucumber cap watchr rails rackup )

    function run_bundler_cmd () {
        if [ -e ./Gemfile ]; then
            echo "bundle exec $@"
            bundle exec $@
        else
            echo "$@"
            $@
        fi
    }

    for cmd in $bundle_commands
    do
        alias $cmd="run_bundler_cmd $cmd"
    done

    ######################################################################


fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
#EOF .bashrc

