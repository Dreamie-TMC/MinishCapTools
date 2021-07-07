require("data//default_position")
require("data//binary")

-- Tables
buttons = {"A","B","L","R","Up","Right","Down","Left","Start","Select"}
last_inputs = {}
inputs = {}
keys = {}
mouse = {}

-- States
unlock = false
movie_mode = false
key_hold = false
background = false
chroma = false
custom_color = false
is_textbox_open = false
display_textbox_text = true

-- Toggles, make changable sometime soon
open_default_positions = "K"
reset_counters = "R"
movie_key = "M"
unlock_inputs = "U"
input_bold = "B"
input_chroma = "C"
use_custom_color = "V"
toggle_textbox_text = "T"

-- Variables
hits = 0
total = 0
perfect_advances = 0
total_advances = 0
last_five_text_values = {0, 0, 0, 0, 0}
textbox_delay = 0
frame_counter = 0
frames_lost = 0

-- Custom color stuff
color_file = io.open("color.txt", "r")
color_read = color_file:read()
color = tonumber("0x"..color_read)
color_file:close()

-- Setup window
client.SetGameExtraPadding(100,0,0,0)

-- Controls Actions
function update_input_display()
	for i = 1, #buttons do
		if inputs[buttons[i]] then
			gui.drawImage("data/"..buttons[i]..".png",x,y)
		end
	end
end

function update_custom_color_input_display()
	if inputs["A"] then a = 1 else a = 0 end
	if inputs["B"] then b = 1 else b = 0 end
	if inputs["L"] then l = 1 else l = 0 end
	if inputs["R"] then r = 1 else r = 0 end
	if inputs["Start"] then st = 1 else st = 0 end
	if inputs["Select"] then se = 1 else se = 0 end

	if inputs["Up"] then 
		up = 1
		gui.drawPixel(4+x,14+y, 0xA0000000+color)
		gui.drawPixel(9+x,14+y, 0xA0000000+color)
	else up = 0 
	end

	if inputs["Down"] then 
		dw = 1 
		gui.drawPixel(4+x,19+y, 0xA0000000+color)
		gui.drawPixel(9+x,19+y, 0xA0000000+color)
	else dw = 0 
	end

	if inputs["Left"] then 
		lf = 1 
		gui.drawPixel(4+x,14+y, 0xA0000000+color)
		gui.drawPixel(4+x,19+y, 0xA0000000+color)
	else lf = 0 
	end

	if inputs["Right"] then 
		ri = 1 
		gui.drawPixel(9+x,14+y, 0xA0000000+color)
		gui.drawPixel(9+x,19+y, 0xA0000000+color)
	else ri = 0 
	end

	for y1=0,23 do
		for x1=0,53 do
			if (binary[y1+1]:sub(x1+1,x1+1) == '1') then 
				gui.drawPixel(x1+x, y1+y, 0xA0000000+color)
			end
		end
	end
end

function controls_actions()	
	if unlock then
		if mouse["Left"] then
			x = mouse["X"]
			y = mouse["Y"]
		end
	end
	
	if chroma then
		gui.drawBox(0, 0, 99, 160, 0xFF008CFF, 0xFF008CFF)
	end

	if background then
		gui.drawImage("data/Border.png",x-1,y-1)
	end

	gui.drawImage("data/Layout.png",x,y)

	if custom_color then
		bin()
		update_custom_color_input_display()
	else
		update_input_display()
	end
end

-- Text Mashing Script Actions
function update_textbox_open_close()
	if is_textbox_open then
		if (last_five_text_values[1] == 1 and 
				last_five_text_values[2] == 5) then
			is_textbox_open = false
			textbox_delay = 40
		elseif last_five_text_values[2] == 2 and last_five_text_values[1] == 0 then
			is_textbox_open = false
			textbox_delay = 10
		elseif textbox_delay > 0 then
			textbox_delay = textbox_delay - 1			
		end
	else
		if textbox_delay == 0 then
			if (last_five_text_values[1] == 0 and
					last_five_text_values[2] == 1 and
					last_five_text_values[3] == 1 and
					last_five_text_values[4] == 0) or 
					(last_five_text_values[1] == 0 and
					last_five_text_values[2] == 1 and
					last_five_text_values[3] == 0) or
					(last_five_text_values[1] == 0 and
					last_five_text_values[2] == 1 and
					last_five_text_values[3] == 1 and
					last_five_text_values[4] == 1 and 
					last_five_text_values[5] == 0) then
				is_textbox_open = true
				textbox_delay = 7
			end
		else
			textbox_delay = textbox_delay - 1
		end
	end
end

function insert_text_value(value)
	for i = 5, 2, -1 do
		last_five_text_values[i] = last_five_text_values[i - 1]
	end
	last_five_text_values[1] = value
end

function is_unique_input()
	unique = false
	
	if inputs["A"] and not last_inputs["A"] then 
		unique = true
	elseif inputs["R"] and not last_inputs["R"] then
		unique = true
	elseif inputs["Up"] and not last_inputs["Up"] then
		unique = true
	elseif inputs["Down"] and not last_inputs["Down"] then
		unique = true
	elseif inputs["Left"] and not last_inputs["Left"] then
		unique = true
	elseif inputs["Right"] and not last_inputs["Right"] then
		unique = true
	end
	
	return unique
end

function check_inputs(text_value)
	valid = false
	
	if textbox_delay == 0 then
		if inputs["B"] and (text_value == 1 or is_unique_input()) then
			valid = true
		end
	end
	
	return valid
end

function calculate_hit_percentage()
	pct = 100
	if hits ~= total then
		pct = math.floor((hits / total) * 100)
	end
	return pct
end

function calculate_perfect_advances()
	pct = 100
	if perfect_advances ~= total_advances then
		pct = math.floor((perfect_advances / total_advances) * 100)
	end
	return pct
end

function text_mashing_actions()
	text = memory.read_s8(0x022809, "EWRAM")
	if is_textbox_open and last_five_text_values[1] ~= 5 and last_five_text_values[1] ~= 0 then
		if text == 1 or text == 2 or text == 3 or text == 4 or (text == 0 and last_five_text_values[1] == 2) then
			if text == 4 or text == 0 then
				total_advances = total_advances + 1
				if frame_counter == 0 then
					perfect_advances = perfect_advances + 1
				end
			end
			
			if (text == 3 or text == 2) and last_five_text_values[1] == 1 then
				textbox_delay = 2
				frame_counter = 0
			end
			
			if text == 1 and textbox_delay == 0 then
				total = total + 1
			end
			
			if check_inputs(text) then
				if text == 1 then
					hits = hits + 1
				end
			elseif (text == 3 or text == 2) and textbox_delay == 0 then
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
function per_frame_setup()
	if movie_mode and movie.isloaded() and emu.framecount() < movie.length() then
		inputs = movie.getinput(emu.framecount()) 
	else 
		inputs = joypad.get() 
	end
	
	keys = input.get()
	mouse = input.getmouse()
end

function input_loop()
	if keys[open_default_positions] then
		if not key_switch then
			file = io.open("default_position.lua","w")
			file:write("x = " .. x .. "\ny = " .. y)
			file:close()
			key_switch = true
		end
		return
	elseif keys[toggle_textbox_text] then
		if not key_switch then
			display_textbox_text = not display_textbox_text
			key_switch = true
		end
		return
	elseif keys[use_custom_color] then
		if not key_switch then
			custom_color = not custom_color
			key_switch = true
		end
		return
	elseif keys[unlock_inputs] then
		if not key_switch then
			unlock = not unlock 
			key_switch = true 
		end
		return
	elseif keys[input_bold] then
		if not key_switch then
			background = not background 
			key_switch = true 
		end
		return
	elseif keys[movie_key] then
		if not key_switch then
			movie_mode = not movie_mode 
			key_switch = true
		end
		return
	elseif keys[input_chroma] then
		if not key_switch then
			chroma = not chroma 
			key_switch = true
		end
		return
	elseif keys[reset_counters] then
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

function draw_text()
	if unlock then
		gui.pixelText(2,2,"Unlocked") 
	end
	
	if display_textbox_text then
		textbox_text = "Textbox"
		if movie_mode and movie.isloaded() and emu.framecount() < movie.length() then 
			textbox_text = "Movie" 
		end
		gui.drawText(5, 10, textbox_text .. " Speedup\nPct: " .. calculate_hit_percentage() .. "%", "orange", nil, 8, "MiniSet2")
		gui.drawText(5, 35, textbox_text .. " Perfect\nAdvance Pct: " .. calculate_perfect_advances() .. "%", "yellow", nil, 8, "MiniSet2")
		gui.drawText(5, 60, "Total Frames Lost:\n" .. ((total - hits) + frames_lost), "red", nil, 8, "MiniSet2")
		
	end
end

-- Looping code here
while true do
	per_frame_setup()
	input_loop()
	controls_actions()
	text_mashing_actions()
	draw_text()
	emu.frameadvance()
end