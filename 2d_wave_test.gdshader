shader_type canvas_item;

uniform vec3 vertex_positions[4];

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 a = vertex_positions[0];
	vec3 b = vertex_positions[1];
	vec3 c = vertex_positions[2];
	vec3 d = vertex_positions[3];

	vec3 final_position = b + (d - b) * UV.x + (a - b) * UV.y;

	COLOR = vec4(final_position, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

//	// move the old result back
//	COLOR.b = COLOR.g;
//	COLOR.g = COLOR.r;
//
//	COLOR = texture(TEXTURE, UV);
//
//	vec2 tex_size = vec2(textureSize(TEXTURE, 0));
//	vec2 pixel_size = 1.0 / tex_size;
//
//	if (UV.x - pixel_size.x > 0.0) {
//		COLOR += texture(TEXTURE, UV.x - tex_size);
//	}
//
//	if (UV.x + pixel_size.x < tex_size.x) {
//		COLOR += texture(TEXTURE, UV.x + tex_size);
//	}
//
//	if (UV.y - pixel_size.y > 0.0) {
//		COLOR += texture(TEXTURE, UV.y - tex_size);
//	}
//
//	if (UV.y + tex_size.y < tex_size.y) {
//		COLOR += texture(TEXTURE, UV.y + tex_size);
//	}
//
//	COLOR.r *= 4.0 * 0.25;
//
//  COLOR.b = 0.0;
//  COLOR.g = 0.0;
