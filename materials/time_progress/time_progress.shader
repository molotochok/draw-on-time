shader_type canvas_item;

uniform float max_time;
uniform float curr_time;

uniform float red_factor = 0.9f;
uniform float green_factor = 0.9f;
uniform float blue_factor = 0.15f;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	if(UV.x * max_time < max_time - curr_time) {
		color.a = 0f;
	} else {
		float div = curr_time / max_time;
		color.r *= (1.0 - div) * red_factor;
		color.g *= div * green_factor;
		color.b *= blue_factor;
	}
	
	COLOR = color;
}