function sdp_filter()
	if nil == session then
		return false
	end
	local sdp = session:getVariable('switch_r_sdp')
	if nil == sdp then
		return false
	end
	sdp = string.gsub(sdp, '[^\n]*ice[^\n]*\n', '')
	sdp = string.gsub(sdp, '[^\n]*candidate[^\n]*\n', '')
	sdp = string.gsub(sdp, '[^\n]*rtcp[^\n]*\n', '')
	-- sdp = sdp .. 'a=sendrecv\n'
	session:setVariable('switch_r_sdp', sdp)
	-- session:consoleLog("info", sdp)
	return true
end

sdp_filter()

