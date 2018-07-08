function sdp_filter_a()
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
	-- sdp = 'a=sendrecv\n' .. sdp
	session:setVariable('switch_r_sdp', sdp)
	-- session:consoleLog("info", sdp)
	return true
end

function sdp_filter()
	if nil == session then
		return false
	end
	local sdp = session:getVariable('switch_r_sdp')
	if nil == sdp then
		return false
	end
	local tmp = ''
	for word in string.gmatch(sdp, "[^\n]*\n") do
		if nil ~= string.find(word, 'ice') 
			or nil ~= string.find(word, 'candidate') 
			or nil ~= string.find(word, 'rtcp') then
		else
			tmp = tmp .. word
			if nil ~= string.find(word, 'm=audio') 
				or nil ~= string.find(word, 'm=video') then
				-- tmp = tmp .. 'a=sendrecv\n'
			end
		end
	end
	session:setVariable('switch_r_sdp', tmp)
	-- session:consoleLog("info", sdp)
	return true
end

sdp_filter()

