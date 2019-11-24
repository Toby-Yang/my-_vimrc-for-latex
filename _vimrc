source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"#add by yangll on Nov 23, 2019###############

"vim: fdm=marker fdl=0 fdls=0
"General settings {{{
"Not for vi {{{
set nocp
"}}}
"Line number {{{
set nu
"}}}
"Auto change to the current directory {{{
set acd
"}}}
"Auto complete of vim command-line {{{
set wmnu
set wildmode=longest,list,full
"}}}
"Increase search {{{
set incsearch
"}}}
"Show position of cursor at status line {{{
set ruler
"}}}
"Syntex highlighting {{{
syntax on
"}}}
"Autochdir {{{
au BufEnter * silent! lcd %:p:h
"}}}
"Allow backspace in insert mode {{{
set backspace=2
"}}}
"No beep {{{
set vb
"}}}
"Shorter spaces {{{
set shiftwidth=2 tabstop=2
"}}}
"Auto indent {{{
if has('autocmd')
  filetype plugin indent on
endif
"}}}
"Copy indent {{{
set autoindent
"}}}
"Smart indent {{{
set smartindent
"}}}
"Smart table {{{
set smarttab
"}}}
"Use space for tab {{{
set expandtab
"}}}
"Set wrap, list disables line break {{{
set wrap lbr tw=0 wm=0 nolist
"}}}
"Remove menu/tool bar {{{
set go=ae
"}}}
"Share clipboard {{{
set clipboard=unnamed
"}}}
"}}}
"Encodings {{{
"Encoding for file {{{
set fenc=utf-8
"}}}
"Encoding for file's content {{{
"If you want gvim under windws prompt
"callback of shell command correctly
"you need the following settings:
"set enc=chinese
set enc=utf-8
scriptencoding utf-8
"}}}
"Encoding for term {{{
set termencoding=utf-8
"}}}
"Supported encoding {{{
set fencs=usc-bom,
      \utf-8,
      \chinese,
      \cp936,
      \gb18030,
      \big5,
      \euc-jp,
      \euc-kr,
      \latin1
"}}}
"Supported filefomart {{{
"auto detect mac,unix,dos
"""set ffs=mac,unix,dos
"}}}
"Vim message encoding {{{
language messages en_US.utf-8
"language messages zh_CN.utf-8
"}}}
"}}}
"User functions {{{
"Toggle Verbose mode {{{
function! ToggleVerbose()
  if !&verbose
    set verbosefile=~/desktop/vimtex.log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
endfunction
"}}}
"TeX live preiview {{{
fu! TexLivePreview()
  if filewritable( bufname( '%' ) )
    silent update %
  endif
endfu
au CursorHoldI,CursorHold *.tex call TexLivePreview()
"}}}
"}}}
"User variables {{{
"let $USRVIMD =$HOME.'\vimfiles\myvim\'
let $USRVIMD ='D:\Vim\vimfiles\myvim\'
let $USRPLUGD=$USRVIMD.'plugged\'
let $USRTEMPD=$USRVIMD.'vimtemp\'
let $LASTWKDR=$USRVIMD.'sessions\'
"}}}
"Plugins {{{


call plug#begin( $USRPLUGD )
"for latex
Plug 'lervag/vimtex'
"for powerline
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
"for soloarlized
Plug 'altercation/vim-colors-solarized'


"for snip
"Plug 'Sirver/ultisnips'
Plug 'honza/vim-snippets'
"cannot use ultisnips,because it need 32py3"
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

call plug#end()


"}}}
"Plugin configuration {{{
"Vimtex {{{
if isdirectory( $USRPLUGD . 'vimtex' )
  let g:tex_flavor = "latex"
  let g:vimtex_quickfix_open_on_warning = 0
  let g:vimtex_quickfix_mode = 2
  let g:vimtex_view_general_viewer='sumatrapdf'
  let g:vimtex_compiler_latexrun_engines = {
        \ '-' : 'xelatex'
        \}
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
  let g:vimtex_view_general_options
        \ = '-reuse-instance -forward-search @tex @line @pdf'
        \ . ' -inverse-search "gvim --servername ' . v:servername
        \ . ' --remote-send \"^<C-\^>^<C-n^>'
        \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
        \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
        \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
        \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
endif
"}}}
"Airline configuration {{{
if isdirectory( $USRPLUGD . 'vim-airline' )
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#whitespace#enabled = 1
  let g:airline_theme='powerlineish'
  let g:Powerline_symbols= 'fancy'
  "
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  "unicode symbols
"  let g:airline_symbols.crypt = ''
"  let g:airline_symbols.linenr = '¶'
"  let g:airline_symbols.maxlinenr = ''
"  let g:airline_symbols.branch = ''
"  let g:airline_symbols.paste = 'Þ'
"  let g:airline_symbols.readonly = ''
"  let g:airline_symbols.spell = 'SPELL'
"  let g:airline_symbols.notexists = '∄'
"  let g:airline_symbols.whitespace = 'Ξ'

  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = 'Ɇ'
  let g:airline_symbols.whitespace = 'Ξ'

  "the font
"  set guifont=DejaVu_Sans_Mono_for_Powerline:h16:cANSI:qDRAFT
  set guifont=DejaVu_Sans_Mono_for_Powerline:h9:cANSI:qDRAFT
endif
"}}}
"Solarized {{{
if isdirectory( $USRPLUGD . 'vim-colors-solarized' )
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  set t_Co=256
  syntax enable
  if has('gui_running')
    set bg=light
  else
    set   bg=dark
  endif
  colo solarized
endif
"}}}
"Ultisnips {{{
if isdirectory( $USRPLUGD . 'ultisnips' )
  "Add ultisnips plugin dir to path
  set rtp -=$USRPLUGD.'ultisnips'
  "Add snippets dir to rtp
  if isdirectory( $USRVIMD )
    set rtp +=$USRVIMD
  endif
  "Set snippet search dir
  if isdirectory( $USRVIMD )
    let g:UltiSnipsSnippetsDir = $USRVIMD. 'UltiSnips'
    "Disable build-in i_CTRL-X_CTRL-K
    inoremap <c-x><c-k> <c-x><c-k>
  endif
endif
"}}}
"}}}
"User keymaps {{{
"copy to clipboard
vnoremap ;x "*y
"past from clipboard
vnoremap ;p "*p
"show math short key
nnoremap ;m :VimtexImapsList<cr>
"reload vimtex
nnoremap ;r :VimtexReload<cr>
"clean call of vimtex
nnoremap ;n :VimtexClean<cr>
"execute call of vimtex
nnoremap ;c :VimtexCompile<cr>
"preview
nnoremap ;v :VimtexView<cr>
"toggle of errors
nnoremap ;e :VimtexErrors<cr>
"toggle table of topic
nnoremap ;t :VimtexTocToggle<cr>
"next window
nnoremap nw <c-w><c-w>
"}}}
"Auto cmd {{{
"Automatical source vimrc on write 
au! BufWritePost $MYVIMRC source $MYVIMRC
"Auto change markdown file to tex fileformat
au! BufEnter *.md set ft=tex
"Go to last file(s) if invoked without arguments.
set ssop-=options
set ssop-=terminal
set ssop-=help
set ssop+=winpos
set ssop+=resize
autocmd VimLeave * nested if (!isdirectory($LASTWKDR)) |
      \ call mkdir($LASTWKDR) |
      \ endif |
      \ execute "mksession! ". $LASTWKDR . "Session.vim"

autocmd VimEnter * nested if argc() == 0 && filereadable($LASTWKDR . "Session.vim") |
      \ execute "source ". $LASTWKDR. "Session.vim"

"#############################################
