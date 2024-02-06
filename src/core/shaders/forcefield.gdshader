shader_type canvas_item;


void fragment() {
	vec4 tex_data = texture(TEXTURE, UV + vec2(0.0, TIME));
	COLOR.rgb = tex_data.rgb;
	COLOR.a *= round(abs(cos(TIME * 60.0)));
}

