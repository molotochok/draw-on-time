extends TextureButton

class_name InteractableTextureButton

func toggle_visibility(show: bool, toggle_cursor: bool = false):
	modulate.a = 1 if show else 0
	
	if toggle_cursor:
		toggle_cursor_shape(show)

func toggle_disable(should_disable: bool):
	disabled = should_disable
	toggle_cursor_shape(!should_disable)

func toggle_cursor_shape(active: bool):
	set_default_cursor_shape(CURSOR_POINTING_HAND if active else CURSOR_ARROW )