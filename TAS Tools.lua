indefinite = "L"
inputs = {}
last_frame_inputs = {}

function update_inputs()
	text_check()
	joypad.set(inputs)
	last_frame_inputs = joypad.get()
	emu.frameadvance()
	inputs = {}
end

function check_if_r_actionable()
	state = memory.read_s8(0x116c, "IWRAM")
	other_state = memory.read_s16_le(0x1172, "IWRAM")
	pulling = other_state == 3
	portal = state == 21
	nothing = state == 1
	minish_nothing = state == 9
	if pulling then
		return false
	end
	
	return portal or nothing or minish_nothing
end

function roll_indefinite()
	inputs["R"] = "True"
	update_inputs()
	while keys[indefinite] do
		if check_if_r_actionable() then
			inputs["R"] = "False"
			update_inputs()
			inputs["R"] = "True"
		end
		update_inputs()
		keys = input.get()
	end
end

function text_check()
	text = memory.read_s8(0x022809, "EWRAM")
	if text == 1 or text == 2 or text == 3 or text == 4 then
		if not last_frame_inputs["Up"] or not last_frame_inputs["Right"] then
			inputs["B"] = "True"
			inputs["Up"] = "True"
			inputs["Right"] = "True"
			inputs["Down"] = "False"
			inputs["Left"] = "False"
		elseif not last_frame_inputs["Down"] or not last_frame_inputs["Left"] then
			inputs["B"] = "True"
			inputs["Up"] = "False"
			inputs["Right"] = "False"
			inputs["Down"] = "True"
			inputs["Left"] = "True"
		end
	end
end

while true do
	if movie.mode() != "RECORD" then
		return
	end
	
	keys = input.get()
	if (keys[indefinite]) then 
		roll_indefinite()
	end
	
	update_inputs()
end