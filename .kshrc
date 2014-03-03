. /etc/ksh.kshrc

export PKG_PATH=http://ftp.jaist.ac.jp/pub/OpenBSD/5.4/packages/`machine -a`/
export PAGER=less
export PS1='\n\u@\H\n\W \\$ '
export EDITOR=vim
export HISTFILE=$HOME/.ksh_history
export PATH=$PATH:/usr/local/jdk-1.7.0/bin/

#colorls is required to be installed via pkg_add
alias ls='colorls -G'
alias ll='colorls -G -a -l -h'
alias la='colorls -G -a'

bind "^[[3~"=delete-char-forward

set -o csh-history
set -o emacs
