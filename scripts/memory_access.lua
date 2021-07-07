function load_textbox_value()
	return memory.read_s8(0x022809, "EWRAM")
end

function load_area_and_room()
	local area = memory.read_s8(0x0BF4, "IWRAM")
	local room = memory.read_s8(0x0BF5, "IWRAM")
	return {Area = area, Room = room}
end