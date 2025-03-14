shader_type spatial;
uniform sampler2D surface: filter_nearest;

float get_height(vec2 pos) {
	return texture(surface, pos).r * 10.0;
}

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.y += get_height(UV);
}

void fragment(){
	float offset = 0.01;
	float height_center = get_height(UV);
	float height_right = get_height(UV + vec2(offset, 0.0));
	float height_left = get_height(UV - vec2(offset, 0.0));
	float height_up = get_height(UV + vec2(0.0, offset));
	float height_down = get_height(UV - vec2(0.0, offset));
	vec3 normal = normalize(vec3(height_left - height_right, 2.0 * offset, height_down - height_up));
	NORMAL = normal;

	//ALBEDO = texture(surface, UV).rgb;
	//vec3 east = vec3(UV.x, get_height(UV + vec2(0.5,0)), UV.y);
	//vec3 west = vec3(UV.x, get_height(UV - vec2(0.5,0)), UV.y);
	//vec3 north = vec3(UV.x, get_height(UV + vec2(0,0.5)), UV.y);
	//vec3 south = vec3(UV.x, get_height(UV - vec2(0,0.5)), UV.y);
	//
	//vec3 normal = normalize(cross((west - east), (south - north)));
	////NORMAL = normal;
	//ALBEDO = vec3(0.5, 0, 0.5) + normal * 0.5;
}