first_frame_bomb_fairy = false
last_frame_state = 0

function update_inputs()
	text_check()
	joypad.set(inputs)
	last_inputs = joypad.get()
end

function check_if_r_actionable()
	local states = load_link_states()
	
	if last_frame_state == 24 then
		last_frame_state = states["state"]
		return false
	end
	
	local pulling = states["secondary state"] == 1
	local portal = states["state"] == 21
	local nothing = states["state"] == 1
	local minish_nothing = states["state"] == 9
	
	last_frame_state = states["state"]
	
	if pulling then
		return false
	end
	
	return portal or nothing or minish_nothing
end

function roll_indefinite()
	if check_if_r_actionable() and not last_inputs["R"] then
		inputs["R"] = "True"
	else
		inputs["R"] = "False"
	end
end

function text_check()
	local text = load_textbox_value()
	if text == 1 or text == 2 or text == 3 or text == 4 then
		if not last_inputs["Up"] or not last_inputs["Right"] then
			inputs["B"] = "True"
			inputs["Up"] = "True"
			inputs["Right"] = "True"
			inputs["Down"] = "False"
			inputs["Left"] = "False"
		elseif not last_inputs["Down"] or not last_inputs["Left"] then
			inputs["B"] = "True"
			inputs["Up"] = "False"
			inputs["Right"] = "False"
			inputs["Down"] = "True"
			inputs["Left"] = "True"
		end
	end
	if text == 5 then
		if is_bomb_fairy() and not first_frame_bomb_fairy then
			first_frame_bomb_fairy = true
		elseif is_bomb_fairy() and not last_inputs["Left"] then
			inputs["Left"] = true
		else
			inputs["Start"] = true
			first_frame_bomb_fairy = false
		end
	end
end

function tas_tool_actions()
	inputs = {}
	if keys[hotkeys["Auto Roll"]] then 
		roll_indefinite()
	end

	update_inputs()
end