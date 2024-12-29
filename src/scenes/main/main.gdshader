shader_type spatial;
uniform sampler2D surface: source_color;
uniform sampler2D normal_map;

void vertex() {
	// Called for every vertex the material is visible on.
	vec4 color = texture(normal_map, UV);
	VERTEX.y += color.x * 0.2;
	COLOR = color;
}
void fragment() {
	NORMAL_MAP = texture(normal_map, UV).xyz;
}
//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
