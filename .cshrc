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
alias nload	nload -u K tun0

# A righteous umask
umask 22

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin $HOME/bin /usr/pbi/eclipse-i386/bin)

setenv	EDITOR	vi
setenv	PAGER	less
setenv	BLOCKSIZE	K
setenv LSCOLORS ExGxFxdxCxegedabagExEx
setenv CLICOLOR yes
setenv GREP_OPTIONS --color=auto

set cr = "%{\e[31m%}" #Red
set cg = "%{\e[32m%}" #Green
set c0 = "%{\e[0m%}"  #Default color
set noclobber

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
