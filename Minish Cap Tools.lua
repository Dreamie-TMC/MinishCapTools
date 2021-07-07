require("scripts//binary")
require("scripts//memory_access")
require("scripts//text_mash_helpers")
require("scripts//controls_helpers")
require("scripts//io_handler")
require("scripts//hotkey_edit_ui")
json = require "scripts//json"

load_required_file_data()

-- Other global variables we use
-- config : a table of configuration data
-- hotkeys : a table of hotkey data

-- Tables
buttons = {"A","B","L","R","Up","Right","Down","Left","Start","Select"}
last_inputs = {}
inputs = {}
keys = {}
mouse = {}

-- Configuration
unlock = false
key_hold = false
is_textbox_open = false
hotkey_editing = false
waiting_for_hotkey = false

-- Variables
hits = 0
total = 0
perfect_advances = 0
total_advances = 0
last_five_text_values = {0, 0, 0, 0, 0}
textbox_delay = 0
frame_counter = 0
frames_lost = 0

-- Setup window
client.SetGameExtraPadding(config["Padding Width"], 0, 0, 0)

-- Generic Actions
function generic_actions()	
	if config["Background Chroma"] then
		gui.drawBox(0, 0, config["Padding Width"] - 1, 160, 0xFF008CFF, 0xFF008CFF)
	end
end

-- Controls Actions
function controls_actions()	
	if unlock then
		if mouse["Left"] then
			local x = mouse["X"] + (config["Padding Width"] - 25)
			local y = mouse["Y"] - 12
			update_configuration("Input Viewer", {x = x, y = y})
		end
	end

	if config["Input Display Border"] then
		gui.drawImage("data/Border.png", config["Input Viewer"]["x"] - 1, config["Input Viewer"]["y"] - 1)
	end

	gui.drawImage("data/Layout.png", config["Input Viewer"]["x"], config["Input Viewer"]["y"])

	if config["Use Custom Button Colors"] then
		bin()
		update_custom_color_input_display()
	else
		update_input_display()
	end
end

-- Text Mashing Script Actions
function text_mashing_actions()
	local text = load_textbox_value()
	if is_textbox_open and last_five_text_values[1] ~= 0 then
		if text == 1 or text == 2 or text == 3 or text == 4 or text == 5  or (text == 0 and last_five_text_values[1] == 2) then
			if text == 4 or text == 0 or (text == 1 and last_five_text_values[1] == 5) then
				total_advances = total_advances + 1
				if frame_counter == 0 then
					perfect_advances = perfect_advances + 1
				end
			end
			
			if text == 5 and last_five_text_values[1] ~= 5 then
				if is_bomb_fairy() then
					textbox_delay = 3
				else
					textbox_delay = 1
				end
				frame_counter = 0
			end
			
			if (text == 3 or text == 2) and last_five_text_values[1] == 1 then
				textbox_delay = 2
				frame_counter = 0
			end
			
			if text == 1 and textbox_delay == 0 and last_five_text_values[1] ~= 5 then
				total = total + 1
			end
			
			if check_inputs(text) then
				if text == 1 then
					hits = hits + 1
				end
			elseif (text == 3 or text == 2 or text == 5 ) and textbox_delay == 0 then
				frame_counter = frame_counter + 1
				frames_lost = frames_lost + 1
			end
		end
	end
	
	last_inputs = inputs
	insert_text_value(text)
	update_textbox_open_close()
end

-- Shared
function draw_text()
	if config["Show Input Viewer"] and unlock then
		gui.pixelText(2,2,"Unlocked") 
	end
	
	if config["Track Textboxes"] then
		local textbox_text = "Textbox"
		if config["Movie Mode"] and movie.isloaded() and emu.framecount() < movie.length() then 
			textbox_text = "Movie" 
		end
		gui.drawText(5, 10, textbox_text .. " Speedup\nPct: " .. calculate_hit_percentage() .. "%", "orange", nil, 8, "MiniSet2")
		gui.drawText(5, 35, textbox_text .. " Perfect\nAdvance Pct: " .. calculate_perfect_advances() .. "%", "yellow", nil, 8, "MiniSet2")
		gui.drawText(5, 60, "Total Frames Lost:\n" .. calculate_frames_lost(), "red", nil, 8, "MiniSet2")
		gui.drawText(5, 85, "Average Frames Lost:\n" .. calculate_average_frames_lost(), "red", nil, 8, "MiniSet2")
	end
	
	if hotkey_editing then
		draw_hotkey_ui()
	end
end

-- Looping code here
while true do
	per_frame_setup()
	input_loop()
	
	generic_actions()
	
	if config["Show Input Viewer"] then
		controls_actions()
	end
	
	if config["Track Textboxes"] then	
		text_mashing_actions()
	end
	
	if not config["Speedrun Mode"] and hotkey_editing and not waiting_for_hotkey then
		check_for_save_clicked()
	end
	
	draw_text()
	emu.frameadvance()
end