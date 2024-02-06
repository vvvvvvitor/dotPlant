shader_type canvas_item;

uniform vec2 scroll_direction = vec2(1.0, 0.0);


void fragment() {
	vec4 tex_data = texture(TEXTURE, UV + (TIME * scroll_direction) + vec2(0.0, cos(TIME) * 0.02));
	COLOR = tex_data;
}
