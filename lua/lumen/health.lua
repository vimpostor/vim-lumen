local M = {}

M.check = function()
	vim.health.report_start("lumen report")
	local info = vim.fn['lumen#debug#info']()

	if info.platform:len() then
		vim.health.report_ok(string.format("Platform %s is supported", info.platform))
	else
		vim.health.report_error("Platform is not supported")
	end

	if vim.regex('%run'):match_str(info.job_state) == nil then
		vim.health.report_ok("Background job is running")
	else
		vim.health.report_error(string.format("Background job is not running: %s", info.job_state))
	end

	if next(info.job_errors) == nil then
		vim.health.report_ok("No job errors reported")
	else
		vim.health.report_warn("Job reported errors", info.job_errors)
	end
end

return M
