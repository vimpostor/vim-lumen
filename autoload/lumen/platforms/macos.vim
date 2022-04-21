let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

func lumen#platforms#macos#watch_cmd()
	return [s:path . "/macos/watcher.swift"]
endfunc

func lumen#platforms#macos#parse_line(line)
	if a:line == "Dark"
		call lumen#dark_hook()
	else
		call lumen#light_hook()
	endif
endfunc

func lumen#platforms#macos#oneshot()
	let out = system(join(lumen#platforms#macos#watch_cmd() + ["get"]))
	call lumen#platforms#macos#parse_line(out)
endfunc
