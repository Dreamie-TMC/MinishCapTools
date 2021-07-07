function is_textbox_start_pattern()
	return (last_five_text_values[1] == 0 and
			last_five_text_values[2] == 1 and
			last_five_text_values[3] == 1 and
			last_five_text_values[4] == 0)
			or
			(last_five_text_values[1] == 0 and
			last_five_text_values[2] == 1 and
			last_five_text_values[3] == 0) 
			or
			(last_five_text_values[1] == 0 and
			last_five_text_values[2] == 1 and
			last_five_text_values[3] == 1 and
			last_five_text_values[4] == 1 and 
			last_five_text_values[5] == 0)
end	

function is_bomb_fairy()
	local position = load_area_and_room()
	if position["Area"] == 41 and position["Room"] == 2 then
		return true
	end
	return false
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
			if is_textbox_start_pattern() then
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

function calculate_frames_lost()
	return (total - hits) + frames_lost
end

function calculate_average_frames_lost()
	if total_advances == 0 then
		return calculate_frames_lost()
	end
	return math.floor(calculate_frames_lost() / total_advances)
end