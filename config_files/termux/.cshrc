# $FreeBSD: release/9.1.0/share/skel/dot.cshrc 242850 2012-11-10 06:05:04Z eadler $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
# more examples available at /usr/share/examples/csh/
#

alias h		history 25
alias j		jobs -l
alias ls	ls --color=auto
alias la	ls --color=auto -aF
alias lf	ls --color=auto -FA
alias ll	ls --color=auto -lAF
alias mv 'mv -i'
alias cp 'cp -i'

# A righteous umask
umask 22

set path = (/data/data/com.termux/files/usr/bin /data/data/com.termux/files/usr/bin/applets $HOME/Apps/bin $HOME/bin)

setenv	EDITOR	vim
setenv	PAGER	less
setenv	BLOCKSIZE	K
setenv LSCOLORS ExGxFxdxCxegedabagExEx
setenv CLICOLOR yes
setenv GREP_OPTIONS --color=auto
setenv XMODIFIERS @im=fcitx
setenv GTK_IM_MODULE fcitx
setenv GTK3_IM_MODULE fcitx
setenv TERM xterm-256color

#Display raw control characters to prevent the weird formatting issue in perldoc
setenv LESS "-r -f" 

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

# Bind Ctrl-Left and Ctrl-Right to word jumping in line editing
bindkey '\e[1;5C' vi-word-fwd
bindkey '\e[1;5D' vi-word-back

fortune | cowsay
