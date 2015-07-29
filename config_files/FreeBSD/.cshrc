# $FreeBSD: release/9.1.0/share/skel/dot.cshrc 242850 2012-11-10 06:05:04Z eadler $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
# more examples available at /usr/share/examples/csh/
#

alias h		history 25
alias j		jobs -l
alias ls	ls -G
alias la	ls -aF
alias lf	ls -FA
alias ll	ls -lAF
alias top	top -P
alias netcheck	systat -if 1
alias curl  "curl --retry-delay 2 --retry 10 -L -k -O -C -"
alias paperscreen "xcalib -red 1.5 0 65 -green 1.5 0 60 -blue 1.5 0 25 -alter"

# A righteous umask
umask 22

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin $HOME/Apps/bin $HOME/.vim/bundle/perlomni.vim/bin)

setenv	EDITOR	vim
setenv	PAGER	less
setenv	BLOCKSIZE	K
setenv LSCOLORS ExGxFxdxCxegedabagExEx
setenv CLICOLOR yes
setenv GREP_OPTIONS --color=auto
setenv XMODIFIERS @im=fcitx
setenv GTK_IM_MODULE fcitx
setenv GTK3_IM_MODULE fcitx
setenv NODE_PATH ~/Apps/node_modules/
setenv TERM xterm-256color

#Display raw control characters to prevent the weird formatting issue in perldoc
setenv LESS "-r -f" 

limit coredumpsize 0

set cr = "%{\e[31m%}" #Red
set cg = "%{\e[32m%}" #Green
set c0 = "%{\e[0m%}"  #Default color
set noclobber
set nobeep
set savehist = (100 merge)

if ($?prompt) then
	# An interactive shell -- set some stuff up
	if ($uid == 0) then
		set user = root
		set prompt = "%B%U%n%u@%m.$cr%l$c0%b %c2 %B%#%b "
	else
		set prompt = "%B%U%n%u@%m.$cg%l$c0%b %c2 %B%%%b "
	endif

	set filec
	set history = 1000
	set savehist = (1000 merge)
	set autolist = ambiguous
	# Use history to aid expansion
	set autoexpand
	set autorehash
	set complete='enhance'
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey '\e[1~' beginning-of-line      # Home
		bindkey '\e[3~' delete-char            # Delete
		bindkey '\e[4~' end-of-line            # End
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif

endif

fortune | cowsay
eval `perl -I$HOME/perl5/lib/perl5 -Mlocal::lib`
