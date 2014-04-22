. /etc/ksh.kshrc

PKG_PATH=http://ftp.jaist.ac.jp/pub/OpenBSD/`uname -r`/packages/`machine -a`/
PKG_PATH=https://stable.mtier.org/updates/$(uname -r)/$(arch -s):${PKG_PATH}
export PKG_PATH

export PAGER=less
export EDITOR=vim
export HISTFILE=$HOME/.ksh_history
export PATH=$PATH:/usr/local/jdk-1.7.0/bin/

#gls is required to be installed via pkg_add -v coreutils
alias ls='gls --color=auto'
alias ll='gls --color=auto -a -l -h'
alias la='gls --color=auto -a'
alias netcheck='systat if 1'

bind "^[[3~"=delete-char-forward

if [ $TERM = 'vt220' ];then
	export TERM=wsvt25
elif [ $TERM = 'xterm-256color' ];then
	export TERM=xterm
fi

if [ $USER = 'root' ];then
	export PS1='\n\u@\h.\[$(tput setaf 1)\]\l\[$(tput op)\\n\w \\$ '
else	
	export PS1='\n\u@\h.\[$(tput setaf 2)\]\l\[$(tput op)\\n\w \\$ '
fi

set -o csh-history
set -o emacs
