let s:platform = ''
if has('linux')
	let s:platform = 'linux'
elseif has('osx')
	let s:platform = 'macos'
elseif has('win32')
	let s:platform = 'windows'
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

func lumen#platforms#platform()
	return s:platform
endfunc
