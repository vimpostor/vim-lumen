func lumen#init()
	let s:is_nvim = has('nvim')

	augroup lumeni
		if v:vim_did_enter
			call lumen#fork_job()
		else
			au VimEnter * call lumen#fork_job()
		endif
	augroup END
endfunc

func lumen#light_hook()
	set background=light
endfunc

func lumen#dark_hook()
	set background=dark
endfunc

func lumen#parse_output(line)
	call lumen#platforms#call("parse_line", [a:line])
endfunc

func lumen#on_stdout(chan_id, data, name)
	let s:lines[-1] .= a:data[0]
	call extend(s:lines, a:data[1:])
	while len(s:lines) > 1
		let line = remove(s:lines, 0)
		call lumen#parse_output(line)
	endwhile
endfunc

func lumen#out_cb(channel, msg)
	call lumen#parse_output(a:msg)
endfunc

func lumen#fork_job()
	au! lumeni

	let command = lumen#platforms#call("watch_cmd")
	if s:is_nvim
		let s:lines = ['']
		let options = {"on_stdout": function('lumen#on_stdout')}
		let s:job = jobstart(command, options)
	else
		let options = {"out_cb": function('lumen#out_cb')}
		let s:job = job_start(command, options)
	endif
endfunc
