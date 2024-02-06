shader_type canvas_item;


void vertex() {
	VERTEX.y += cos(TIME + UV.x) * 8.0;
}
