extends TextureButton

class_name InteractableTextureButton

func toggle_visibility(show: bool, toggle_cursor: bool = false):
  modulate.a = 1 if show else 0
  
  if toggle_cursor:
    set_default_cursor_shape(CURSOR_POINTING_HAND if show else CURSOR_ARROW )