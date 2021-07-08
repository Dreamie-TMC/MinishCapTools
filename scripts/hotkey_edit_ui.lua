function initialize_ui()
	client.SetGameExtraPadding(config["Padding Width"], 0, 100, 0)
	hotkey_keys = {}
	for key, value in pairs(hotkeys) do
		hotkey_keys[#hotkey_keys + 1] = key
	end
	table.sort(hotkey_keys)
	hotkey_index = 1
end

function next_hotkey(forward)
	if forward then
		hotkey_index = hotkey_index + 1
		if hotkey_index > #hotkey_keys then
			hotkey_index = 1
		end
	else
		hotkey_index = hotkey_index - 1
		if hotkey_index == 0 then
			hotkey_index = #hotkey_keys
		end
	end
end

function check_for_save_clicked()
	if mouse["Left"] then
		local width = config["Padding Width"] + 240
		local mouse_x = mouse["X"] + config["Padding Width"]
		local mouse_y = mouse["Y"]
		if mouse_x >= width + 20 and mouse_x <= width + 80 and mouse_y >= 100 and mouse_y <= 120 then
			save()
		elseif mouse_x >= width + 20 and mouse_x <= width + 80 and mouse_y >= 125 and mouse_y <= 145 then
			cancel()
		end
	end
end

function save()
	save_hotkeys()
	hotkey_editing = false
	client.SetGameExtraPadding(config["Padding Width"], 0, 0, 0)
end

function cancel()
	hotkey_editing = false
	client.SetGameExtraPadding(config["Padding Width"], 0, 0, 0)
	load_hotkeys()
end

function key_line_wrapping()
	local strings = {}
	for str in string.gmatch(hotkey_keys[hotkey_index], "([^".." ".."]+)") do
		table.insert(strings, str)
	end
	
	local current_line_length = 0
	local output = ""
	local linecount = 1
	for k, word in pairs(strings) do
		current_line_length = current_line_length + string.len(word) + 1
		if current_line_length > 22 then
			current_line_length = string.len(word)
			output = output .. "\n"
			linecount = linecount + 1
		end
		output = output .. word .. " "
	end
	
	return {word = output, count = linecount}
end

function draw_hotkey_ui()
	local width = config["Padding Width"] + 240
	local key_output = key_line_wrapping()
	gui.drawRectangle(width + 20, 100, 60, 20, "green", "lightgreen")
	gui.drawRectangle(width + 20, 125, 60, 20, "red", "red")
	gui.drawText(width + 22, 105, "Save Hotkeys", "black", nil, 8, "MiniSet2")
	gui.drawText(width + 35, 130, "Cancel", "black", nil, 8, "MiniSet2")
	gui.drawText(width + 5, 30, key_output["word"], "white", nil, 8, "MiniSet2")
	if waiting_for_hotkey then
		gui.drawText(width + 35, 30 + (12 * key_output["count"]) + 15, "Waiting...", "white", nil, 8, "MiniSet2")
	else
		gui.drawText(width + 35, 30 + (12 * key_output["count"]) + 15, "Key: " .. hotkeys[hotkey_keys[hotkey_index]], "white", nil, 8, "MiniSet2")	
	end
end