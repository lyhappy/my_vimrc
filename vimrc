" 修改leader键
let mapleader = ','
let g:mapleader = ','

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
" 按,m取消高亮搜索结果
nnoremap <silent> <leader>m :nohlsearch<CR>
" 按,h进入16进制模式
nnoremap <leader>h :%!xxd<CR>
" 按,t进入文本模式
nnoremap <leader>t :%!xxd -r<CR>

nnoremap <leader>vs= :vertical resize +10<CR>
nnoremap <leader>vs- :vertical resize -10<CR>

" jump to tagbar
nnoremap <leader>jt :TagbarOpen j<CR>

inoremap <leader>n <esc>l

nnoremap - ddp
nnoremap _ ddkP
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>

" auto comment
autocmd FileType python nnoremap <buffer> <localleader>c I#<space><esc>
autocmd FileType shell nnoremap <buffer> <localleader>c I#<space><esc>
autocmd FileType php nnoremap <buffer> <localleader>c I//<space><esc>
autocmd FileType c nnoremap <buffer> <localleader>c I//<space><esc>

" }}}
" {{{ 注释折叠
augroup ft_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" {{{ for markdown
autocmd FileType markdown nnoremap <leader>br A<br><esc><cr>
autocmd FileType markdown nnoremap <leader>i A \|<esc>
autocmd FileType markdown nnoremap <leader>` viw<esc>a`<esc>hbi`<esc>lel
" }}}

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7
" 打开文件时，同时尝试utf-8和gbk编码
set fencs=utf-8,gbk
set encoding=utf-8

noremap <F10> :call PasteToggle()<cr>

" Go to home and end using capitalized directions
noremap H ^
noremap L $

" 按,py用python执行当前文件
autocmd FileType python nnoremap <silent> <leader>py :call PythonExec()<CR>
" 按,sh用bash执行当前文件
nnoremap <silent> <leader>sh :call ShellExec()<CR>
" 按,ph用php执行当前文件
autocmd FileType php nnoremap <silent> <leader>ph :call PhpExec()<CR> 
" 按,yd用youdao词典翻译当前单词
nnoremap <leader>yd :let a=expand("<cword>")<Bar>exec '!echo ' .a. '&dicDoc ck ' .a<CR>

" 按,du 解码unicode
vnoremap <leader>du :'<,'>call DeUnicode()<cr>

" 按,gU 当前word变为大写
nnoremap <leader>u viwgU
nnoremap <leader>l viwgu

" normal 模式下，gf跳转到php的function 声明行
autocmd FileType php nnoremap <silent><buffer><leader>gf :call GotoPhpFuncDef()<CR>

autocmd FileType java nnoremap <silent><buffer><leader>jc :call JavaCompile()<CR>
autocmd FileType java nnoremap <silent><buffer><leader>jr :call JavaRun()<CR>

" 复制选中区到系统剪切板中
if has('mac')
	vnoremap <leader>y "+y
else
	vnoremap <leader>y "9y
	cnoremap <c-v> <c-r>9
endif

" 滚动Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" {{{ shortcut for ack
function! JavaAck(args)
    let grepprg_bak=&grepprg
    exec "set grepprg=" . g:ackprg
    execute "silent! grep --type=java " . a:args
    botright copen
    let &grepprg=grepprg_bak
    exec "redraw!"
endfunction

command! -nargs=* -complete=file JAck call JavaAck(<q-args>)
" }}}

" 缩进规则 expendtab {{{
augroup expandtab
	autocmd filetype make set noexpandtab
	autocmd FileType * set tabstop=4|set shiftwidth=4|set noexpandtab
	autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
augroup END
" }}}

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
" debian.vim
	 
" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'. Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"
set nocompatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on            " 语法高亮
endif
colorscheme desert        " elflord ron peachpuff default 设置配色方案，vim自带的配色方案保存在/usr/share/vim/vim72/colors目录下
" color dracula

" detect file type
filetype on
filetype plugin on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"have Vim load indentation rules and plugins according to the detected filetype
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.

"set ignorecase        " 搜索模式里忽略大小写
"set smartcase        " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项。只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用。
set autowrite        " 自动把内容写回文件: 如果文件被修改过，在每个 :next、:rewind、:last、:first、:previous、:stop、:suspend、:tag、:!、:make、CTRL-] 和 CTRL-^命令时进行；用 :buffer、CTRL-O、CTRL-I、'{A-Z0-9} 或 `{A-Z0-9} 命令转到别的文件时亦然。
set autoindent        " 设置自动对齐(缩进)：即每行的缩进值与上一行相等；使用 noautoindent 取消设置
"set smartindent        " 智能对齐方式
set tabstop=4        " 设置制表符(tab键)的宽度
set softtabstop=4     " 设置软制表符的宽度    
set shiftwidth=4    " (自动) 缩进使用的4个空格
set cindent            " 使用 C/C++ 语言的自动缩进方式
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s     "设置C/C++语言的具体缩进方式
"set backspace=2    " 设置退格键可用
set showmatch        " 设置匹配模式，显示匹配的括号
set linebreak        " 整词换行
set whichwrap=b,s,<,>,[,] " 光标从行首和行末时可以跳到另一行去
"set hidden " Hide buffers when they are abandoned
"set mouse=a            " Enable mouse usage (all modes)    "使用鼠标
set number            " Enable line number    "显示行号
"set previewwindow    " 标识预览窗口
set history=50        " set command history to 50    "历史记录50条


"--状态行设置--
set laststatus=2 " 总显示最后一个窗口的状态行；设为1则窗口数多于一个的时候显示最后一个窗口的状态行；0不显示最后一个窗口的状态行
set ruler            " 标尺，用于显示光标位置的行号和列号，逗号分隔。每个窗口都有自己的标尺。如果窗口有状态行，标尺在那里显示。否则，它显示在屏幕的最后一行上。

"--命令行设置--
set showcmd            " 命令行显示输入的命令
set showmode        " 命令行显示vim当前模式

"--find setting--
set incsearch        " 输入字符串就显示匹配点
set hlsearch       


" 按下F7重新生成tag文件，并更新taglist
" noremap <F7> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
" inoremap <F7> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
" set tags=tags
" set tags+=./tags "add current directory's generated tags file

" {{{ Plugin list
" if has('mac')
	set rtp+=~/.vim/bundle/vundle/Vundle.Vim
" else
"	set rtp+=~/.vim/bundle/Vundle.vim/
" endif
call vundle#begin()
	Plugin 'gmarik/vundle'
"	{{{ NerdTree
	Plugin 'scrooloose/nerdtree'
	autocmd VimEnter * NERDTree
	let NERDTreeWinPos="right"
	let NERDTreeShowBookmarks=1
	let NERDTreeWinSize=30
	wincmd w
	autocmd VimEnter * wincmd w
	nmap <leader>nf :NERDTreeFind<CR>
	
	" let NERDTreeDirArrowExpandable='+'
	" let NERDTreeDirArrowCollapsible='-' 
	map <F4> <ESC> :NERDTreeToggle<CR>
"	}}}
"	{{{ --java complete
	" Plugin 'artur-shaik/vim-javacomplete2'
	" autocmd FileType java setlocal omnifunc=javacomplete#Complete
"	}}}
"	{{{ vim-airline
	Plugin 'bling/vim-airline'
	set laststatus=2
"	}}}
"	{{{ tagbar
	Plugin 'majutsushi/tagbar'
	" for mac os
	" let g:tagbar_ctags_bin='/usr/local/bin/ctags'            "ctags程序的路径
	let g:tagbar_ctags_bin='ctags'            "ctags程序的路径
	let g:tagbar_width=30                    "窗口宽度的设置
	let g:tagbar_left = 1
	map <F3> :Tagbar<CR>
	"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
	"如果是c语言的程序的话，tagbar自动开启
"	}}}
"	{{{ YouCompleteMe
	Plugin 'Valloric/YouCompleteMe'
	let g:ycm_server_python_interpreter='/usr/bin/python'
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
	
	nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> 
	" 跳转到定义处
"	}}}
"	{{{ dracula scheme
	Plugin 'dracula/vim'
"	}}}
"	{{{ syntastic
	Plugin 'scrooloose/syntastic'
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 0
	let g:syntastic_check_on_wq = 0
"	}}}
"	{{{ vim-flake8: python static syntax and style checker
	Plugin 'nvie/vim-flake8'
	let python_highlight_all=1
"	}}}
"	{{{ mru: recent files
	Plugin 'mru.vim'
	" nmap <cr> :MRU<cr>
"	}}}
"	{{{ Xdebug for php
	if has('mac')
		silent! echo "no xdebug on mac"
	else
		Plugin 'joonty/vim-xdebug.git'
	endif
"	}}}
"	{{{ Visual-Mark
	Plugin 'Visual-Mark'
	nnoremap <leader>mn :bnext<CR>
	nnoremap <leader>mp :bprevious<CR>
"	}}}
"	{{{	minibufexpl
	Plugin 'minibufexpl.vim'
	let g:miniBufExplMapWindowNavVim = 1 
	let g:miniBufExplMapWindowNavArrows = 1 
	let g:miniBufExplMapCTabSwitchBufs = 0
	" <C-TAB> and <C-S-TAB> 多被终端应用占用，使用tn和tp实现buf循环切换
	noremap <silent>tn <ESC>:MBEbn<CR>
	noremap <silent>tp <ESC>:MBEbp<CR>
	let g:miniBufExplModSelTarget = 1
	let g:miniBufExplMaxHeight=2
	" let g:miniBufExplorerMoreThanOne=0
"	}}}
"	{{{ gtags
	Plugin 'gtags.vim'
	" cscope
	set cscopetag                  " 使用 cscope 作为 tags 命令
	set cscopeprg='gtags-cscope'   " 使用 gtags-cscope 代替 cscope
	
	" gtags
	let GtagsCscope_Auto_Load = 1
	let CtagsCscope_Auto_Map = 1
	let GtagsCscope_Quiet = 1
"	}}}
"	{{{ vim-json-line-format
"	Plugin 'axiaoxin/vim-json-line-format'
"	}}}
"	{{{	ctrlp
	Plugin 'ctrlp.vim'
"	}}}
"	{{{ ack
	Plugin 'ack.vim'
"	}}}
"	{{{ a.vim
	Plugin 'a.vim'
"	}}}
"	{{{ EasyMotion
	Plugin 'EasyMotion'
	let g:EasyMotion_leader_key = '\'
"	}}}
"	{{{ java syntax
	" Plugin 'Java-Syntax-and-Folding'
"	}}}
	Plugin 'Lynx-Offline-Documentation-Browser'
"	Plugin 'vim-ruby'
"	Plugin 'python_fold'
	Plugin 'tmhedberg/SimpylFold'
call vundle#end()
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
" {{{ 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif
endif
" }}}
" {{{ execute shell script in vim
function! ShellExec()
	silent !clear
	let ret = system("bash" . " " . bufname("%") . " 2>&1")
	call ChooseBuf("__Bash_Ret__")
	normal! ggdG
	setlocal buftype=nofile

	call append(0, split(ret, '\v\n'))
	:redraw!
endfunction
" }}}
" {{{ 选择一个命名的缓冲区
function! ChooseBuf(buf_name)
	let bnr = bufwinnr(a:buf_name)
	if bnr > 0
		:exe bnr . "wincmd w"
	else
		silent execute '10split' . a:buf_name
	endif
endfunction
" }}}
" {{{ execute python in vim
function! PythonExec()
	silent !clear
	let ret = system("python" . " " . bufname("%") . " 2>&1")
	call ChooseBuf("__Python_Ret__")
	normal! ggdG
	setlocal buftype=nofile

	call append(0, split(ret, '\v\n'))
	:redraw!
endfunction
" }}}
" {{{ execute php in vim
function! PhpExec()
    silent !clear
    let ret = system("php" . " " . bufname("%") . " 2>&1")
	call ChooseBuf("__PHP_Ret__")
    normal! ggdG
    setlocal buftype=nofile

    call append(0, split(ret, '\v\n'))
    :redraw!
endfunction
" }}}
" {{{ for gtags 
au VimEnter * cs add GTAGS
" au VimEnter * call VimEnterCallback()
au BufAdd *.[ch] call FindGtags(expand('<afile>'))
au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))
  
" {{{ FindFiles
function! FindFiles(pat, ...)
     let path = ''
     for str in a:000
         let path .= str . ','
     endfor
  
     if path == ''
         let path = &path
     endif
  
     echo 'finding...'
     redraw
     call append(line('$'), split(globpath(path, a:pat), '\n'))
     echo 'finding...done!'
     redraw
endfunc
" }}}
" {{{ VimEnterCallback
function! VimEnterCallback()
     for f in argv()
         if fnamemodify(f, ':e') != 'c' && fnamemodify(f, ':e') != 'h'
             continue
         endif
  
         call FindGtags(f)
     endfor
endfunc
" }}}
" {{{ FindGtags  
function! FindGtags(f)
     let dir = fnamemodify(a:f, ':p:h')
     while 1
         let tmp = dir . '/GTAGS'
         if filereadable(tmp)
			 echo tmp
             exe 'cs add ' . tmp . ' ' . dir
             break
         elseif dir == '/'
             break
         endif
  
         let dir = fnamemodify(dir, ":h")
     endwhile
endfunc
" }}}
" {{{ UpdateGtags 
function! UpdateGtags(f)
     let dir = fnamemodify(a:f, ':p:h')
     exe 'silent !cd ' . dir . ' && global -u &> /dev/null &'
endfunction
" }}}
" }}} ################################################################

" funcstions
function! DeUnicode()
	let [lnum1, col1] = getpos("'<")[1:2]
	let [lnum2, col2] = getpos("'>")[1:2]
	let lines = getline(lnum1, lnum2)
	let lines[-1] = lines[-1][: col2 - 1]
	let lines[0] = lines[0][col1 - 1:]
  
	let ustr = join(lines, "\n")

	exec '!deunicode "' . ustr .'"'

endfunction
" 
" GotoPhpFuncDef goto function definion in php {{{
function!  GotoPhpFuncDef()
	" echom "GotoPhpFuncDef"
	execute "normal! ?function\<CR>"
endfunction	
" }}}
" {{{ execute javac in vim
function! JavaCompile()
    silent !clear
    let ret = system("javac" . " " . bufname("%") . " 2>&1")
	call ChooseBuf("__Java_Ret__")
    normal! ggdG
    setlocal buftype=nofile

    call append(0, split(ret, '\v\n'))
    :redraw!
endfunction
" }}}
" {{{ execute java in vim
function! JavaRun()
    silent !clear
	let bn = bufname("%")
	let fn = split(bn, '\.')[0]
    let ret = system("java" . " " . fn . " 2>&1")
	call ChooseBuf("__Java_Ret__")
    normal! ggdG
    setlocal buftype=nofile

    call append(0, split(ret, '\v\n'))
    :redraw!
endfunction
" }}}

" {{{ fold java import
function! FoldJavaImport()
	execute "normal! gg/import\<cr>V?import\<cr>jzf"
endfunction
" }}}

" {{{ paste toggle
if !exists('g:paste_toggle')
	let g:_paste_toggle=0
endif

function! PasteToggle()
	if g:_paste_toggle == 0
		let g:_paste_toggle=1
		setlocal paste
	else
		let g:_paste_toggle=0
		setlocal nopaste
	endif
endfunction
" }}}
