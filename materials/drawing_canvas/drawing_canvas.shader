shader_type canvas_item;

uniform sampler2D reference;

void fragment() {
	vec4 curTexture = texture(TEXTURE, UV);
	vec4 refTexture = texture(reference, UV);
	
	vec4 color = curTexture;
	
	if(curTexture.a > 0.9 && refTexture.a > 0.9) {
		color = vec4(0, 1, 0, 1);
	} else {
		color.r = 1.0;
		color.g = 0.0;
		color.b = 0.0;
	}
	
	COLOR = color;
}