function initialize_ui()
	client.SetGameExtraPadding(config["Padding Width"], 0, 100, 0)
	width = config["Padding Width"] + 240
	gui.drawBox(width + 20, 130, width + 80, 165, "green", "green")
	gui.drawText(width + 30, 135, "Save", "black", nil, 8, "MiniSet2")
end

function save()
	save_hotkeys()
	hotkey_editing = false
	gui.clearGraphics()
	client.SetGameExtraPadding(config["Padding Width"], 0, 0, 0)
end