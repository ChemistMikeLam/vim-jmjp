" indent/jmjp.vim 

" Check if indent is turned off by user 
if get(g:, "jmjpIndentOff", 0) 
	finish 
endif 

setlocal indentexpr=JmjpIndent() 

function! JmjpIndent() abort 
	let l:line = getline(v:lnum) 
	let l:prevLineNum = prevnonblank(v:lnum - 1) 
	let l:prevLine = getline(l:prevLineNum) 
	let l:prevLineIndent = indent(l:prevLineNum) 
	let l:deltaIndent = JmjpNumUnbalDelim(l:prevLine) * &tabstop 
	let l:newIndent = l:prevLineIndent + l:deltaIndent 
	if l:newIndent < 0 
		return 0 
	else 
		return l:newIndent 
	endif 
endfunction 

function! JmjpNumUnbalDelim(lineContent) abort 
	let l:workLine = ""
	if type(a:lineContent) ==# v:t_string 
		let l:workLine = a:lineContent 
	else 
		let l:workLine = string(a:lineContent) 
	endif 
	let l:length = strchars(l:workLine) 
	if l:length <=# 0 
		return 0 
	endif 
	let l:count = 0 
	let l:inStr = 0
	while l:length ># 0 
		let l:workChar = l:workLine[0] 
		if l:inStr 
			if l:workChar ==# '\' 
				let l:workLine = l:workLine[1:] 
				let l:length = l:length - 1 
			elseif l:workChar ==# '"' 
				let l:instr = 0 
			endif 
		else 
			if strridx('([', l:workChar) !=# -1 
				let l:count = l:count + 1 
			elseif strridx(')]', l:workChar) !=# -1 
				let l:count = l:count - 1 
			elseif l:workChar ==# '"' 
				let l:inStr = 1 
			endif 
		endif 
		let l:workLine = l:workLine[1:] 
		let l:length = l:length - 1 
	endwhile 
	return l:count 
endfunction 
