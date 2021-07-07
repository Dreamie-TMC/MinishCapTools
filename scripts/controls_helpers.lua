function update_custom_color_input_display()
	if inputs["A"] then a = 1 else a = 0 end
	if inputs["B"] then b = 1 else b = 0 end
	if inputs["L"] then l = 1 else l = 0 end
	if inputs["R"] then r = 1 else r = 0 end
	if inputs["Start"] then st = 1 else st = 0 end
	if inputs["Select"] then se = 1 else se = 0 end

	if inputs["Up"] then 
		up = 1
		gui.drawPixel(4 + config["Input Viewer"]["x"], 14 + config["Input Viewer"]["y"], 0xA0000000 + color)
		gui.drawPixel(9 + config["Input Viewer"]["x"], 14 + config["Input Viewer"]["y"], 0xA0000000 + color)
	else up = 0 
	end

	if inputs["Down"] then 
		dw = 1 
		gui.drawPixel(4 + config["Input Viewer"]["x"], 19 + config["Input Viewer"]["y"], 0xA0000000 + color)
		gui.drawPixel(9 + config["Input Viewer"]["x"], 19 + config["Input Viewer"]["y"], 0xA0000000 + color)
	else dw = 0 
	end

	if inputs["Left"] then 
		lf = 1 
		gui.drawPixel(4 + config["Input Viewer"]["x"], 14 + config["Input Viewer"]["y"], 0xA0000000 + color)
		gui.drawPixel(4 + config["Input Viewer"]["x"], 19 + config["Input Viewer"]["y"], 0xA0000000 + color)
	else lf = 0 
	end

	if inputs["Right"] then 
		ri = 1 
		gui.drawPixel(9 + config["Input Viewer"]["x"], 14 + config["Input Viewer"]["y"], 0xA0000000 + color)
		gui.drawPixel(9 + config["Input Viewer"]["x"], 19 + config["Input Viewer"]["y"], 0xA0000000 + color)
	else ri = 0 
	end

	for y1=0, 23 do
		for x1=0, 53 do
			if (binary[y1 + 1]:sub(x1 + 1, x1 + 1) == '1') then 
				gui.drawPixel(x1 + config["Input Viewer"]["x"], y1 + config["Input Viewer"]["y"], 0xA0000000 + color)
			end
		end
	end
end


function update_input_display()
	for i = 1, #buttons do
		if inputs[buttons[i]] then
			gui.drawImage("data/"..buttons[i]..".png", config["Input Viewer"]["x"], config["Input Viewer"]["y"])
		end
	end
end