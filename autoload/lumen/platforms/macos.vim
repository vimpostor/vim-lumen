let s:exe = resolve(expand('<sfile>:p:h')) . '/macos/watcher'

func lumen#platforms#macos#watch_cmd()
	return [s:exe]
endfunc

func lumen#platforms#macos#parse_line(line)
	if a:line == "Dark_"
		call lumen#dark_hook()
	else
		call lumen#light_hook()
	endif
endfunc

func lumen#platforms#macos#oneshot()
	let out = get(systemlist(printf("%s get || swiftc %s.swift -o %s", s:exe, s:exe, s:exe)), 0)
	if len(out) != 5
		let err = out
		" fallback
		let out = get(systemlist(s:exe . ".swift get"), 0)
	endif

	if len(out) == 5
		call lumen#platforms#macos#parse_line(out)
	else
		call lumen#debug#log_err(err)
		call lumen#debug#log_err(out)
	endif
endfunc
