. /etc/ksh.kshrc

export PKG_PATH=http://mirror.internode.on.net/pub/OpenBSD/`uname -r`/packages/`machine -a`/
export PAGER=less
export EDITOR=vim
export HISTFILE=$HOME/.ksh_history
export PATH=$PATH:/usr/local/jdk-1.7.0/bin/

#gls is required to be installed via pkg_add -v coreutils
alias ls='gls --color=auto'
alias ll='gls --color=auto -a -l -h'
alias la='gls --color=auto -a'

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
