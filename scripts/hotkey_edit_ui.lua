function initialize_ui()
	client.SetGameExtraPadding(config["Padding Width"], 0, 100, 0)
	hotkey_keys = {}
	for key, value in pairs(hotkeys) do
		hotkey_keys[#hotkey_keys + 1] = key
	end
	table.sort(hotkey_keys)
	hotkey_index = 1
end

function save()
	save_hotkeys()
	hotkey_editing = false
	client.SetGameExtraPadding(config["Padding Width"], 0, 0, 0)
end

function key_line_wrapping()
	local strings = {}
	for str in string.gmatch(hotkey_keys[hotkey_index], "([^".." ".."]+)") do
		table.insert(strings, str)
	end
	
	local current_line_length = 0
	local output = ""
	for k, word in pairs(strings) do
		current_line_length = current_line_length + string.len(word) + 1
		if current_line_length > 22 then
			current_line_length = string.len(word)
			output = output .. "\n"
		end
		output = output .. word .. " "
	end
	
	return output
end

function draw_hotkey_ui()
	local width = config["Padding Width"] + 240
	gui.drawRectangle(width + 20, 110, 60, 20, "green", "lightgreen")
	gui.drawText(width + 22, 115, "Save Hotkeys", "black", nil, 8, "MiniSet2")
	gui.drawText(width + 5, 30, key_line_wrapping(), "white", nil, 8, "MiniSet2")
end