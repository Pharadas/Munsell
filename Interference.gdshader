shader_type spatial;
render_mode world_vertex_coords;

uniform vec3 vertex_positions[4];
uniform vec3 light_positions[4];
uniform float light_distances[4];
uniform int num_of_light_sources;

varying vec3 world_position;

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

void vertex() {
    world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec3 a = vertex_positions[0];
	vec3 b = vertex_positions[1];
	vec3 c = vertex_positions[2];
	vec3 d = vertex_positions[3];

	vec3 final_position = b + (d - b) * (1.0 - UV.y) + (a - b) * UV.x;

	vec2 light_polarization_definition = vec2(1, 0);
	Polarization polarization = Polarization(vec2(0, 0), vec2(0, 0));

    float wavelength = 0.001;

	for (int i = 0; i < 2; i++) {
		float z = sqrt(pow(light_distances[i], 2) + pow(length(light_positions[i].xyz - final_position), 2));
		float w0 = 5.0;
		float n = 1.0;
		float z_r = (PI * w0 * w0 * n) / wavelength;
		float w_z = w0 * sqrt(1.0 + pow(z / z_r, 2.0));
		float R_z = z * (1.0 + pow(z_r / z, 2.0));
		float gouy_z = atan(z / z_r);
		float k = (2.0 * PI * n) / wavelength;

		float radius = length(light_positions[i].xyz - final_position);
		vec2 first_part_x_hat = cx_mul(vec2(1, 0), vec2((w0 / w_z) * exp(-pow(radius, 2.0) / pow(w_z, 2.0)), 0));
		vec2 first_part_y_hat = cx_mul(vec2(0, 0), vec2((w0 / w_z) * exp(-pow(radius, 2.0) / pow(w_z, 2.0)), 0));
		vec2 second_part = cx_exp(vec2(0.0, k * z + k * (pow(radius, 2.0) / (2.0 * R_z)) - gouy_z));

		polarization.Ex += cx_mul(first_part_x_hat, second_part);
		polarization.Ey += cx_mul(first_part_y_hat, second_part);

	}

	vec2 Ex = polarization.Ex;
	vec2 Ey = polarization.Ey;

    //float result = (cx_mul(Ex, cx_conj(Ex)) + cx_mul(Ey, cx_conj(Ey))).x * 0.0009;
	float result = (cx_mul(Ex, cx_conj(Ex)) + cx_mul(Ey, cx_conj(Ey))).x;
	ALBEDO.rgb = vec3(1, 0, 0) * result * 0.5;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
