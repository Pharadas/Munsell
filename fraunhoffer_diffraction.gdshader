shader_type spatial;
render_mode world_vertex_coords;

uniform vec3 vertex_positions[4];

varying vec3 world_position;

uniform sampler2D blockerPositions;
uniform sampler2D objectTexture;

#define cx_mul(a, b) vec2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x)
#define cx_add(a, b) vec2(a.x + b.x, a.y + b.y)
#define cx_div(a, b) vec2(((a.x*b.x+a.y*b.y)/(b.x*b.x+b.y*b.y)),((a.y*b.x-a.x*b.y)/(b.x*b.x+b.y*b.y)))
#define cx_modulus(a) length(a)
#define cx_conj(a) vec2(a.x, -a.y)
#define cx_arg(a) atan(a.y, a.x)
#define cx_sin(a) vec2(sin(a.x) * cosh(a.y), cos(a.x) * sinh(a.y))
#define cx_cos(a) vec2(cos(a.x) * cosh(a.y), -sin(a.x) * sinh(a.y))
#define cx_exp(a) exp(a.x) * vec2(cos(a.y), sin(a.y))

struct Polarization { // 128 bits
  vec2 Ex; // 64 bits
  vec2 Ey; // 64 bits
};

const ivec2 textureDimensions = ivec2(32, 32);
const vec2 textureStepSize = 1.0 / vec2(textureDimensions);

void vertex() {
    world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec3 a = vertex_positions[0];
	vec3 b = vertex_positions[1];
	vec3 c = vertex_positions[2];
	vec3 d = vertex_positions[3];

	vec3 final_position = b + (d - b) * UV.x + (a - b) * UV.y;

	vec2 light_polarization_definition = vec2(1, 0);
	Polarization polarization = Polarization(vec2(0, 0), vec2(0, 0));

	for (float x = 0.0; x < 1.0; x += textureStepSize.x) {
		for (float y = 0.0; y < 1.0; y += textureStepSize.y) {
			vec2 new_uv = vec2(x, y);
			float a = texture(objectTexture, new_uv).a;

			//if (length(new_uv - 0.5) < 0.2 && length(new_uv - 0.5) < 0.4) {
			float r = length(texture(blockerPositions, new_uv).xyz - final_position) * 1.0;
			float wavelength = 750.0;

			// spherical light source
			float A = a;

			polarization.Ex += cx_mul(vec2(1, 0), cx_mul(vec2(A/r, 0.0), cx_exp(vec2(0.0, r * wavelength)))) * (1.0 / (r * r));
			polarization.Ey += cx_mul(vec2(1, 0), cx_mul(vec2(A/r, 0.0), cx_exp(vec2(0.0, r * wavelength)))) * (1.0 / (r * r));
			//}
		}
	}

	vec2 Ex = polarization.Ex;
	vec2 Ey = polarization.Ey;

    //float result = (cx_mul(Ex, cx_conj(Ex)) + cx_mul(Ey, cx_conj(Ey))).x * 0.0009;
	float result = (cx_mul(Ex, cx_conj(Ex)) + cx_mul(Ey, cx_conj(Ey))).x * 1.0;
	ALBEDO.rgb = vec3(1, 0, 0) * result;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
