func lumen#debug#info()
	let job_state = lumen#job_state()
	let platform = lumen#platforms#platform()
	return {'platform': platform, 'job_state': job_state}
endfunc
