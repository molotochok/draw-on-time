shader_type canvas_item;

uniform float max_time;
uniform float curr_time;

uniform vec4 start_color = vec4(0, 1, 0, 1);
uniform vec4 end_color = vec4(1, 0, 0, 1);

uniform bool update_color = true;
uniform bool update_size = true;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	if(update_size && UV.x * max_time < max_time - curr_time) {
		color.a = 0f;
	}
	
	if(update_color) {
		float div = curr_time / max_time;
		color.r *= mix(start_color.r, end_color.r, 1f - curr_time / max_time);
		color.g *= mix(start_color.g, end_color.g, 1f - curr_time / max_time);
		color.b *= mix(start_color.b, end_color.b, 1f - curr_time / max_time);
	}
	
	COLOR = color;
}