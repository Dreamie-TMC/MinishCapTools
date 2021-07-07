function load_required_file_data()
	-- Custom input viewer coloring
	local color_file = io.open("config/color.txt", "r")
	color_read = color_file:read()
	color = tonumber("0x"..color_read)
	color_file:close()
	
	-- Configuration Load
	local config_file = io.open("config/Config.json", "r")
	local config_data = config_file:read("*a")
	config_file:close()
	config = json.decode(config_data)
	
	-- Hotkey JSON Load
	local hotkey_file = io.open("config/hotkeys.json", "r")
	local data = hotkey_file:read("*a")
	hotkey_file:close()
	hotkeys = json.decode(data)
end

function update_configuration(key, value)
	-- For boolean flags, pass nil to swap the flag
	if value == nil then
		config[key] = not config[key]
	else
		config[key] = value
	end
	local config_file = io.open("config/Config.json", "w")
	local data = json.encode(config)
	config_file:write(data)
	config_file:close()
end

function per_frame_setup()
	if config["Movie Mode"] and movie.isloaded() and emu.framecount() < movie.length() then
		inputs = movie.getinput(emu.framecount()) 
	else 
		inputs = joypad.get() 
	end
	
	keys = input.get()
	mouse = input.getmouse()
end

function input_loop()
	if keys[hotkeys["Disable Textbox Features"]] then
		if not key_switch then
			update_configuration("Track Textboxes", nil)
			key_switch = true
		end
		return
	elseif keys[hotkeys["Disable Input Viewer"]] then
		if not key_switch then
			update_configuration("Show Input Viewer", nil)
			key_switch = true
		end
		return
	elseif keys[hotkeys["Use Custom Button Color"]] then
		if not key_switch then
			update_configuration("Use Custom Button Colors", nil)
			key_switch = true
		end
		return
	elseif keys[hotkeys["Unlock Input Display"]] then
		if not key_switch then
			unlock = not unlock 
			key_switch = true 
		end
		return
	elseif keys[hotkeys["Input Display Border"]] then
		if not key_switch then
			update_configuration("Input Display Border", nil)
			key_switch = true 
		end
		return
	elseif keys[hotkeys["Movie Mode"]] then
		if not key_switch then
			update_configuration("Movie Mode", nil)
			key_switch = true
		end
		return
	elseif keys[hotkeys["Extended Background Chroma"]] then
		if not key_switch then
			update_configuration("Background Chroma", nil)
			key_switch = true
		end
		return
	elseif keys[hotkeys["Reset Textbox Counters"]] then
		if not key_switch then
			hits = 0
			total = 0
			perfect_advances = 0
			total_advances = 0
			frames_lost = 0
			key_switch = true
		end
		return
	end
	
	key_switch = false
end