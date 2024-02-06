shader_type canvas_item;

uniform float wind_speed = 5.0;
uniform float wind_force = 1.0;


void vertex() {
	VERTEX.x += cos((TIME * wind_speed) * UV.y ) * wind_force;
}

