" Disable vi compatibility
set nocompatible
" Show line number
set nu
" Enable syntax
syntax on
" Auto indent
set autoindent
set cindent
" Incremental case-insensitive search 
set hlsearch
set ignorecase
set incsearch
" Color schmeme
colorscheme maui
" Default file encoding
set encoding=utf-8
" Specify tags file
set tags+=./tags
" Tab length
set tabstop=4
" Indent length
set softtabstop=4
set shiftwidth=4
" Use tab at the start of a line or paragraph
set smarttab
set expandtab
" Disable mouse
set mouse-=a
" Disable backup file
set nobackup
" Disable undo file
set noundofile
" Enable line highlight
set cursorline
" Enable column highlight
set cursorcolumn
" Fold block by syntax
set foldmethod=syntax
" Disable block fold on startup
set nofoldenable
" 256-color support
set t_Co=256
" Set lines left to the margin
set scrolloff=3
" Completion option
set completeopt=menu,preview,longest
" Show status line always
set cmdheight=2
set laststatus=2
" Auto-Completion for Vim command
set wildmenu
" Default Omni Function
set omnifunc=syntaxcomplete#Complete
" Do not search included files to speed up Ctrl-P
set complete-=i
" Switch to the other buffer without saving current buffer
set hidden
" Jump to the window already displaying desired buffer instead of creating new
" one
set switchbuf=useopen

" Save read-only file after editing
command Sudow w !sudo tee % >/dev/null

" Navigate through buffers
nmap <C-l> :bnext<CR>
nmap <C-k> :bprevious<CR>

" Refresh ctags files upon saving
autocmd BufWritePost *
      \ if filereadable('tags') |
      \   call system('exctags -R --languages-force='.&ft) |
      \   echo "Tag refreshed." |
      \ endif

"Read Manpage in vim
"runtime! ftplugin/man.vim
runtime! runtime/ftplugin/man.vim

"Auto-install plugins and colorscheme
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  !curl -fLo ~/.config/nvim/colors/maui.vim --create-dirs https://raw.githubusercontent.com/darkgeek/vim-maui/master/colors/maui.vim
  execute 'colorscheme maui'
  !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Begin Plug
call plug#begin('~/.config/nvim/plugged')

" Plugins 
Plug 'junegunn/vim-plug'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'kshenoy/vim-signature'
Plug 'easymotion/vim-easymotion'
Plug 'honza/vim-snippets'
Plug 'c9s/perlomni.vim', { 'for': 'perl' }
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'

" End Plug
call plug#end()            

" [ultisnips] Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" [ultisnips] If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" [UltiSnips] Set my own snippets
let g:UltiSnipsSnippetDirectories=["darkgeek_snippets"]

" [CtrlP] Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" [CtrlP] Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" [CtrlP] Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" [CtrlP] Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
nmap <leader>bt :CtrlPTag<cr>

" [NERDtree] List files in this project
nmap <Leader>fl :NERDTreeToggle<CR>
" [NERDtree] NERDtree window size
let NERDTreeWinSize=32
" [NERDTree] NERDTree window position
let NERDTreeWinPos="left"
" [NERDTree] Show hidden files
let NERDTreeShowHidden=1
" [NERDTree] Don't show extra help information
let NERDTreeMinimalUI=1
" [NERDTree] Delete buffers as well after removing a file
let NERDTreeAutoDeleteBuffer=1

" [syntastic] Settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_perl_checkers = ['perl', 'podchecker']
let g:syntastic_enable_perl_checker = 1
let g:syntastic_mode_map = {
        \ "mode": "passive",
        \ "active_filetypes": ["perl"],
        \ "passive_filetypes": [] }

" [tagbar] Show tag list on left
let tagbar_left=1 
" [tagbar] List tags shortcut
nnoremap <Leader>tl :TagbarToggle<CR> 
" [tagbar] Tagbar window size
let tagbar_width=32 
" [tagbar] Don't show extra help information
let g:tagbar_compact=1

