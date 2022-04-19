let s:platform = ''
if has('linux')
	let s:platform = 'linux'
endif

func lumen#platforms#call(func, ...)
	if empty(s:platform)
		return
	endif

	let args = []
	if a:0 > 0
		let args = a:1
	endif
	let Func = function("lumen#platforms#" . s:platform . "#" . a:func, args)
	return Func()
endfunc
