" nvim config
" sneaky

" vars {{{
syntax on
filetype indent plugin on
set termguicolors
fu! SetColor(group, attr, color)
  let gui = a:color =~ '^#'
  let text = printf('hi %s %s%s=%s', a:group, gui ? 'gui' : 'cterm', a:attr, a:color)
  echo text
endf

" cursor blinking
set guicursor=a:blinkon1

set clipboard+=unnamedplus
set fdm=marker
set bg=dark
set shiftwidth=2
set sts=2
set ts=2
set laststatus=1
set so=3
set magic
set et
set sta
set tgc
set rnu
set cul
set ai
set si
set nu
set undofile
" }}}
" vim plug {{{
call plug#begin('~/.config/nvim/plugged')

" browsing
" Plug 'yuratomo/w3m.vim'

" Plug 'hhsnopek/vim-firewatch'
" development
" Plug 'morhetz/gruvbox'
Plug 'sainnhe/edge'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'chrisbra/Colorizer'
" parentheses
Plug 'tpope/vim-surround'

" sql
" Plug 'has2k1/sql.vim', { 'for': 'sql' }
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }

" clojure
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }
" Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
" Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
" Plug 'tpope/vim-salve', { 'for': 'clojure' }

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go'}

" linter
" Plug 'w0rp/ale', {'for': ['javascript', 'javascript.jsx', 'clojure']}

" javascript
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx']}
Plug 'flowtype/vim-flow', {'for': ['javascript', 'javascript.jsx']}

" elixir
Plug 'elixir-editors/vim-elixir'
Plug 'digitaltoad/vim-pug'

" docker
" Plug 'ekalinin/Dockerfile.vim', {'for': 'dockerfile'}

call plug#end()
" }}}
" colorscheme {{{
" overrides
function! s:patch_colorscheme()
  " bg #262729
  hi! link elixirAlias Yellow
  hi! link elixirDefine Yellow
  hi! link elixirModuleDefine Yellow
  hi! link elixirModuleDeclaration Yellow
  hi! link elixirVariable Purple
  hi! link elixirInclude Blue
  hi CursorLine guibg=#262729 guifg=NONE
  hi CursorLineNr guibg=#262729 guifg=NONE
  hi CursorLineNr guibg=#262729 guifg=NONE
endfunction

autocmd! Colorscheme edge call s:patch_colorscheme()

set background=dark
let g:edge_transparent_background = 1
colorscheme edge
" }}}
" foldtext {{{
function! CustomFoldtext()
    " remove comments
    let line = substitute(getline(v:foldstart),
          \'\v\s*(' . substitute(&cms, '\s*%s', '', '') . '+)\s*', '', 'g')
    " remove marker
    let line = substitute(line, '\s*' . split(&foldmarker, ',')[0] . '\s*', '', 'g')
    let line = repeat(v:folddashes, 2) . ' ' . line
    let w = get(g:, 'custom_foldtext_max_width', winwidth(0)) - &foldcolumn - (&number ? 4 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat(" ", 4)
    let lineCount = line("$")
    let expansionString = repeat(' ', w - strwidth(foldSizeStr.line.foldLevelStr))
    return line . expansionString . foldSizeStr . foldLevelStr
endf
set foldtext=CustomFoldtext()
" }}}
" colorscheme {{{
" overrides
function! s:patch_colorscheme()
  " bg #262729
  hi! link elixirAlias Yellow
  hi! link elixirDefine Yellow
  hi! link elixirModuleDefine Yellow
  hi! link elixirModuleDeclaration Yellow
  hi! link elixirVariable Purple
  hi! link elixirInclude Blue
  hi CursorLine guibg=#262729 guifg=NONE
  hi CursorLineNr guibg=#262729 guifg=NONE
endfunction

autocmd! Colorscheme edge call s:patch_colorscheme()

set background=dark
colorscheme edge
" }}}
" key bindings {{{
" normal mode {{{
nnoremap <silent><F11> :Goyo<CR>
nnoremap <silent><S-P> :Ag<CR>
nnoremap <silent><C-P> :FZF<CR>
nnoremap <silent><ESC> :nohl<CR>
nnoremap <silent><F4> :qa<CR>

" highlight binding
nnoremap <F10> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}
" insert mode {{{
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}
" terminal mode {{{
" tnoremap <Esc> <C-\><C-n>
" }}}

" }}}
" FZF {{{
let $FZF_DEFAULT_COMMAND = 'fd --type f'
" let $FZF_DEFAULT_OPTS .= '--color fg:#b7bec9,bg:#262729,hl:#5ebaa5,fg+:#b7bec9,bg+:#262729,hl+:#5ebaa5 --color info:#a1bf78,prompt:#a1bf78,pointer:#5ebaa5,marker:#5ebaa5,header:#a1bf78'
" let $FZF_DEFAULT_OPTS .= '--inline-info'
" bugfix maybe fixed
" let g:fzf_layout = { 'window': 'enew' }
let g:fzf_buffers_jump = 1
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Cyan'],
  \ 'fg+':     ['fg', 'Normal'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Cyan'],
  \ 'info':    ['fg', 'Green'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Green'],
  \ 'pointer': ['fg', 'Cyan'],
  \ 'marker':  ['fg', 'Cyan'],
  \ 'spinner': ['fg', 'Cyan'],
  \ 'header':  ['fg', 'Green'] }
" }}}
" autocmd {{{

" restore last position
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif


" remove whitespace
function TrimWhitespace()
  let s:will_edit = search('s*$', 'ncpw')
  if s:will_edit > 0
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfunction
autocmd BufWritePre * call TrimWhitespace()


" }}}
