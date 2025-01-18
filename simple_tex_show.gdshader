shader_type spatial;

uniform sampler2D tex;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = texture(tex, UV).rgb;
	ALPHA = texture(tex, UV).a;
}
