shader_type canvas_item;

uniform sampler2D reference;
uniform vec4 correctColor;
uniform vec4 wrongColor;

void fragment() {
	vec4 curTexture = texture(TEXTURE, UV);
	vec4 refTexture = texture(reference, UV);
	
	vec4 color = curTexture;
	
	if(curTexture.a > 0.9) {
		color = refTexture.a > 0.9 ? correctColor : wrongColor
	}
	
	COLOR = color;
}