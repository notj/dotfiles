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

" colorscheme
" Plug 'sainnhe/edge'
" Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
" Plug 'olimorris/onedarkpro.nvim'
" Plug 'AlexvZyl/nordic.nvim', { 'branch': 'main' }
" Plug 'EdenEast/nightfox.nvim'

" search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" git
Plug 'tpope/vim-fugitive'

" completions
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-ragtag'

" file
Plug 'tpope/vim-vinegar'

" sql
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }

" clojure
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }

" go
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go'}

" javascript
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx']}
Plug 'flowtype/vim-flow', {'for': ['javascript', 'javascript.jsx']}

" elixir
Plug 'elixir-editors/vim-elixir'

" tf
Plug 'hashivim/vim-terraform', {'for': 'tf'}

" lsp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()
" }}}
" colorscheme {{{
" overrides
function! s:patch_colorscheme()
  " bg #262729

  " hi! link elixirInclude Blue
  " hi! link elixirVariable Blue
  " hi! link elixirModuleDeclaration Yellow

  " hi! link elixirDefine Red
  " hi! link elixirModuleDefine Red
  " hi! link elixirPrivateDefine Red
  " hi! link elixirBlockDefinition Red

  " hi! link elixirOperator Blue
  " hi! link elixirKeyword Blue

  " hi! link elixirAlias Yellow
  " hi! link elixirAtom Cyan
  " hi! link elixirExUnitMacro Red

  " hi! link elixirVariable Purple

  hi CursorLine guibg=#262729 guifg=NONE
  hi CursorLineNr guibg=#262729 guifg=NONE
  hi CursorLineNr guibg=#262729 guifg=NONE
endfunction

autocmd! Colorscheme sonokai call s:patch_colorscheme()

set background=dark
let g:edge_transparent_background = 1
let g:everforest_transparent_background = 1
let g:sonokai_transparent_background = 1
let g:sonokai_style = 'espresso'

colorscheme sonokai
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
" key bindings {{{
" normal mode {{{
nnoremap <silent><F11> :Goyo<CR>
nnoremap <silent><S-P> :Ag<CR>
nnoremap <silent><C-P> :Files<CR>
nnoremap <silent><ESC> :nohl<CR>
" nnoremap <silent><F4> :qa<CR>
nnoremap <silent>cp :let @+ = expand("%:p")<CR>

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
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
"
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

" enable file quickfix list
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" set default ag options
let $AG_DEFAULT_OPTIONS = '--hidden --ignore .git'
let g:fzf_preview_window = ['right:50%', 'ctrl-_']
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, $AG_DEFAULT_OPTIONS, fzf#vim#with_preview(), <bang>0)
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

" terminal escape compat with fzf
if has("nvim")
  au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au! FileType fzf tunmap <buffer> <Esc>
endif
" }}}
" treesitter {{{
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"elixir", "heex", "eex"}, -- only install parsers for elixir and heex
  -- ensure_installed = "all", -- install parsers for all supported languages
  sync_install = false,
  ignore_install = { },
  highlight = {
    enable = true,
    disable = { },
    additional_vim_regex_highlighting = true,
  },
}
EOF
" }}}
