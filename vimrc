" 修改leader键
let mapleader = ','
let g:mapleader = ','

syntax enable
set nocompatible
set autowrite
set tabstop=2           " 设置制表符(tab键)的宽度
set softtabstop=2       " 设置软制表符的宽度
set shiftwidth=2        " (自动) 缩进使用的4个空格
set expandtab           " 将tab键展开为空格
set hlsearch            " 高亮搜索匹配结果
set incsearch           " 输入字符串就显示匹配点
set showmatch           " 设置匹配模式，显示匹配的括号
set autoindent
" set smartindent         " 智能缩进
set number              " 显示行号
set relativenumber
set scrolloff=7         " 光标不触底
set fencs=utf-8,gbk     " 打开文件时，同时尝试utf-8和gbk编码
set encoding=utf-8
set laststatus=2
set ruler
set linebreak           " 整词换行
set history=50          " set command history to 50    "历史记录50条
set mouse=a             " Enable mouse usage (all modes)    "使用鼠标
set whichwrap=b,s,<,>,[,]   " 光标从行首和行末时可以跳到另一行去
set showcmd             " 命令行显示输入的命令
set showmode            " 命令行显示vim当前模式
syntax on

" colors desert

filetype on
filetype plugin on

" 缩进规则 expendtab {{{
augroup expandtab
  autocmd filetype make set noexpandtab
  " autocmd FileType * set ts=2 sts=2 sw=2 | set expandtab
  autocmd FileType python set ts=4 | set sw=4 | set expandtab
  autocmd Filetype html setlocal ts=4 sts=4 sw=4 | set expandtab
  autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 | set expandtab
  autocmd Filetype vue setlocal ts=4 sts=4 sw=4 | set expandtab
augroup END
" }}}

" {{{ 常用功能leader映射
" 使用,ev打开配置文件
nnoremap <silent> <leader>ev :vsp $MYVIMRC<CR>
" 按,sv重载配置文件
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
" 使用,w保存文件
nnoremap <leader>w :w<CR>
inoremap <leader>w <esc>:w<CR>
" 使用,q关闭窗口
nnoremap <leader>q :q<CR>
inoremap <leader>q <esc>:q<CR>

" normal模式下, 使用,h进入或退出16进制模式
nnoremap <leader>h :call HexModelToggle()<CR>

" 查看当前打开文件的git log
nnoremap <leader>gl :call GitLog()<CR>
nnoremap gl :call GitLol()<CR>

" normal模式下，微调窗口宽度
nnoremap <leader>v= :vertical resize +10<CR>
nnoremap <leader>v- :vertical resize -10<CR>

" 按,gU 当前word变为大写
nnoremap <leader>u viwgU
nnoremap <leader>l viwgu
" }}}

" Press H to line head
noremap H ^
" Press L to line end
noremap L $
nnoremap U <C-r>
nnoremap - ddp
nnoremap _ ddkP

" 分屏跳转
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" 滚动Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>

inoremap jk <esc>

nnoremap <leader>yd :let a=expand("<cword>")<Bar>exec '!echo ' .a. '&dic ck ' .a<CR>

" 复制选中区到系统剪切板中
if has('mac')
  vnoremap <leader>y "+y
else
  vnoremap <leader>y "9y
  cnoremap <c-v> <c-r>9
endif

call has('python3')
" {{{ use vim-plug manage plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" {{{ plugin list
call plug#begin('~/.vim/plugged')
  " {{{ dracula scheme
  Plug 'dracula/vim', {'tag': '1.5.0', 'as': 'dracula' }
  " }}}
  " {{{ vim-airline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
    " let g:airline_theme='atomic'
    let g:airline_theme='dracula'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
    let g:airline#extensions#tabline#show_tab_nr = 1
    let g:airline#extensions#tabline#formatter = 'jsformatter'
    let g:airline#extensions#tabline#buffer_nr_show = 0
    let g:airline#extensions#tabline#fnametruncate = 16
    let g:airline#extensions#tabline#fnamecollapse = 2
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    set laststatus=2
  " }}}
  " {{{ ale
  Plug 'w0rp/ale'
    let g:ale_set_highlights = 0
    let g:ale_change_sign_column_color = 0
    let g:ale_sign_column_always = 1
    let g:ale_sign_error = '✖'
    let g:ale_sign_warning = '⚠'
    let g:ale_echo_msg_error_str = '✖'
    let g:ale_echo_msg_warning_str = '⚠'
    let g:ale_echo_msg_format = '%severity% %s% [%linter%% code%]'
    let g:ale_fixers = {
        \   'javascript': ['eslint'],
        \   'vue': ['eslint'],
        \}
    let g:ale_fixers = {}
    let g:ale_fixers['javascript'] = ['prettier']
    let g:ale_fixers['typescript'] = ['prettier', 'tslint']
    let g:ale_fixers['json'] = ['prettier']
    let g:ale_fixers['css'] = ['prettier']
    let g:ale_javascript_prettier_use_local_config = 1
    let g:ale_fix_on_save = 0
    nnoremap <silent> <leader>ak :ALENext<cr>
    nnoremap <silent> <leader>aj :ALEPrevious<cr>
  " }}}

  " {{{ NERDTree
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    " set runtimepath+=~/.vim/plugged/nerdtree
    " so ~/.vim/plugged/nerdtree/autoload/nerdtree.vim
    let NERDTreeWinPos='left'
    let NERDTreeShowBookmarks=1
    let NERDTreeWinSize=30
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    nnoremap <leader>nf :NERDTreeFind<CR>
    nnoremap <F4> :NERDTreeToggle<CR>
    nnoremap <leader>k :NERDTree<CR>

  Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTree' }
    let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
        \ }
  " }}}

    " {{{ EasyMotion
    Plug 'easymotion/vim-easymotion'
        let g:EasyMotion_leader_key = '\'
    " }}}

    " {{{ NERDcommenter
    Plug 'scrooloose/nerdcommenter'
      " Add spaces after comment delimiters by default
      let g:NERDSpaceDelims = 1
      " Use compact syntax for prettified multi-line comments
      let g:NERDCompactSexyComs = 1
      " Align line-wise comment delimiters flush left instead of following code indentation
      let g:NERDDefaultAlign = 'left'
      " Set a language to use its alternate delimiters by default
      let g:NERDAltDelims_java = 1
      " Add your own custom formats or override the defaults
      let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

      " Allow commenting and inverting empty lines (useful when commenting a
      let g:NERDCommentEmptyLines = 1

      " Enable trimming of trailing whitespace when uncommenting
      let g:NERDTrimTrailingWhitespace = 1
    " }}}
    " Plugin for fe
    " {{{ vim-javascript
    Plug 'pangloss/vim-javascript'
        let javascript_enable_domhtmlcss = 1
    Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
    " }}}
    " Plug 'JavaScript-Indent'
    " {{{ vim-es6
    Plug 'isRuslan/vim-es6'
    " }}}
    " {{{ vim-vue
    Plug 'posva/vim-vue'
        " au BufNewFile,BufRead *.vue setf vue.html.javascript.css
        au BufNewFile,BufRead *.vue setf vue
        autocmd FileType vue syntax sync fromstart
    " }}}
    " {{{ git
    Plug 'airblade/vim-gitgutter'
    " }}}
    " {{{ snippet
    Plug 'SirVer/ultisnips'
    " Plug 'MarcWeber/vim-addon-mw-utils'
    " Plug 'tomtom/tlib_vim'
    " Plug 'garbas/vim-snipmate'

    " Optional:
    Plug 'honza/vim-snippets'
    " }}}

    " {{{ YCM
    function! BuildYCM(info)
        " info is a dictionary with 3 fields
        " - name:   name of the plugin
        " - status: 'installed', 'updated', or 'unchanged'
        " - force:  set on PlugInstall! or PlugUpdate!
        if a:info.status == 'installed' || a:info.force
            !./install.py
        endif
    endfunction
    Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
        " let g:ycm_server_python_interpreter='/usr/local/bin/python'
        " 自动补全配置
        set completeopt=longest,menu
        "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif
        "离开插入模式后自动关闭预览窗口
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        "回车即选中当前项
        "上下左右键的行为 会显示其他信息
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" :
        "\<PageDown>"
        inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" :
        "\<PageUp>"

        "youcompleteme  默认tab  s-tab 和自动补全冲突
        "let g:ycm_key_list_select_completion=['<c-n>']
        let g:ycm_key_list_select_completion = ['<Down>']
        "let g:ycm_key_list_previous_completion=['<c-p>']
        let g:ycm_key_list_previous_completion = ['<Up>']
        let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

        let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
        let g:ycm_min_num_of_chars_for_completion=2	"
        " 从第2个键入字符就开始罗列匹配项
        let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
        let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
        " nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
        " force recomile with
        " syntastic
        " nnoremap <leader>lo :lopen<CR>	"open locationlist
        " nnoremap <leader>lc :lclose<CR>	"close locationlist
        inoremap <leader><leader> <C-x><C-o>
        "在注释输入中也能补全
        let g:ycm_complete_in_comments = 1
        "在字符串输入中也能补全
        let g:ycm_complete_in_strings = 1
        "注释和字符串中的文字也会被收入补全
        let g:ycm_collect_identifiers_from_comments_and_strings = 0

        " 跳转到定义处
        nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
    " }}}

    " {{{	ctrlp
    " Plug 'kien/ctrlp.vim'
    " }}}
    " {{{ ack
    Plug 'mileszs/ack.vim'
    " }}}
    " {{{ minibufexpl
    " Plug 'vim-scripts/minibufexpl.vim'
    "     let g:miniBufExplMapWindowNavVim = 1
    "     let g:miniBufExplMapWindowNavArrows = 1
    "     let g:miniBufExplMapCTabSwitchBufs = 0
    "     " <C-TAB> and <C-S-TAB> 多被终端应用占用，使用tn和tp实现buf循环切换
    "     noremap <silent>tn <ESC>:MBEbn<CR>
    "     noremap <silent>tp <ESC>:MBEbp<CR>
    "     let g:miniBufExplModSelTarget = 1
    "     let g:miniBufExplMaxHeight=2
    "     let g:miniBufExplorerMoreThanOne=0
    "	}}}
  Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
    " !autocmd! User goyo.vim echom 'Goyo is now loaded!'
  " {{{ vim-fugitive
  Plug 'tpope/vim-fugitive'
    nnoremap <leader>gw :Gwrite<cr>
    nnoremap <leader>gc :Gcommit<cr>
    nnoremap <leader>gs :Gstatus<cr>
    nnoremap <leader>gl :Glog<cr>
    nnoremap <leader>gb :Gblame<cr>
    nnoremap <leader>gd :Gdiff<cr>
  " }}}
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'vim-vdebug/vdebug', { 'for': 'python' }
  " Plug 'jaredly/vim-debug', {'tag': '1.5.4', 'do': 'python setup.py install'}
call plug#end()
" }}}

colors dracula

highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="100"

" set term=screen-256color-italic
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

hi Normal guibg=NONE ctermbg=NONE

" {{{ 注释折叠
augroup ft_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" {{{ Hex Model Toggle
if !exists('g:_hex_model_toggle')
  let g:_hex_model_toggle=0
endif
function! HexModelToggle()
  if g:_hex_model_toggle == 0
    let g:_hex_model_toggle=1
    execute ":%!xxd<cr>"
  else
    let g:_hex_model_toggle=0
    execute ":%!xxd -r<cr>"
  endif
endfunction
" }}}

" {{{ Git log
function! GitLog()
  let bn = bufname("%")
  execute "!git lg " . bn
endfunction
function! GitLol()
  let bn = bufname("%")
  execute "!git lol " . bn
endfunction
" }}}

" {{{ 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
  "如果文件类型为.sh文件
  if &filetype == 'sh'
    call setline(1, "\#!/bin/bash")
  endif

  "如果文件类型为python
  if &filetype == 'python'
    call setline(1, "\#!/usr/bin/env python")
    call append(1, "\# encoding: utf-8")
  endif

  normal G
  normal o
  normal o
endfunc
" }}}
"
