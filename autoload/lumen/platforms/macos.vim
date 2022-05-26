let s:path = resolve(expand('<sfile>:p:h')) . '/macos/watcher'

func lumen#platforms#macos#watch_cmd()
	return [s:path . ".swift"]
endfunc

func lumen#platforms#macos#parse_line(line)
	if a:line == "LDark"
		call lumen#dark_hook()
	else
		call lumen#light_hook()
	endif
endfunc

func lumen#platforms#macos#oneshot()
	let out = system(printf("%s get || swiftc %s.swift", s:path, s:path))
	if len(out) != 6
		" fallback
		let out = system(s:path . ".swift get")
	endif
	call lumen#platforms#macos#parse_line(out)
endfunc
