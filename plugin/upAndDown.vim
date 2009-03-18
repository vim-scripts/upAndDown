"=============================================================================
" File:        upAndDown.vim
" Author:      Frédéric Hardy (fhardy at noparking.net)
" Last Change: Wed Mar 18 11:38:45 CET 2009
" Licence:     GPL version 2.0 license
" GetLatestVimScripts: 2586 10240 :AutoInstall: upAndDown.vim
"=============================================================================
if !exists('upAndDown_enable')
	let s:keepCpo= &cpo
	setlocal cpo&vim

	if !hasmapto('<Plug>upAndDownUp')
		nmap <unique> <silent> <S-Up> <Plug>upAndDownUp
	endif

	nnoremap <unique> <script> <Plug>upAndDownUp <SID>moveUp
	nnoremap <SID>moveUp :<C-u>call <SID>moveUp()<CR>

	if !hasmapto('<Plug>upAndDownDown')
		nmap <unique> <silent> <S-Down> <Plug>upAndDownDown
	endif

	nnoremap <unique> <script> <Plug>upAndDownDown <SID>moveDown
	nnoremap <SID>moveDown :<C-u>call <SID>moveDown()<CR>

	if !hasmapto('<Plug>upAndDownInsertUp')
		imap <unique> <silent> <S-Up> <Plug>upAndDownInsertUp
	endif

	inoremap <unique> <script> <Plug>upAndDownInsertUp <SID>moveInsertUp
	inoremap <SID>moveInsertUp <C-o>:<C-u>call <SID>moveUp()<CR>

	if !hasmapto('<Plug>upAndDownInsertDown')
		imap <unique> <silent> <S-Down> <Plug>upAndDownInsertDown
	endif

	inoremap <unique> <script> <Plug>upAndDownInsertDown <SID>moveInsertDown
	inoremap <SID>moveInsertDown <C-o>:<C-u>call <SID>moveDown()<CR>

	if !hasmapto('<Plug>upAndDownVisualUp')
		vmap <unique> <silent> <S-Up> <Plug>upAndDownVisualUp
	endif

	vnoremap <unique> <script> <Plug>upAndDownVisualUp <SID>moveVisualUp
	vnoremap <SID>moveVisualUp :<C-u>call <SID>moveVisualUp()<CR>

	if !hasmapto('<Plug>upAndDownVisualDown')
		vmap <unique> <silent> <S-Down> <Plug>upAndDownVisualDown
	endif

	vnoremap <unique> <script> <Plug>upAndDownVisualDown <SID>moveVisualDown
	vnoremap <SID>moveVisualDown :<C-u>call <SID>moveVisualDown()<CR>

	function s:moveUp()
		call s:moveUpWithArgs(".", "")
	endfunction

	function s:moveDown()
		call s:moveDownWithArgs(".", "")
	endfunction

	function s:moveVisualUp()
		echomsg 'UP'
		call s:moveUpWithArgs("'<", "'<,'>")
		normal gv
	endfunction

	function s:moveVisualDown()
		call s:moveDownWithArgs("'>", "'<,'>")
		normal gv
	endfunction

	function s:moveUpWithArgs(line, range)
		call s:move(a:range . 'move ' . (line(a:line) - v:count1 - 1 < 0 ? '0' : a:line . ' -' . (v:count1 + 1)))
	endfunction

	function s:moveDownWithArgs(line, range)
		call s:move(a:range . 'move ' . (line(a:line) + v:count1 > line('$') ? '$' : a:line . ' +' . v:count1))
	endfunction

	function s:move(arg)
		let column = virtcol('.')
		execute 'silent! ' . a:arg
		execute 'normal! ' . column . '|'
	endfunction

	let &cpo= s:keepCpo
	unlet s:keepCpo

	let g:upAndDown_enable = 1
endif

finish
