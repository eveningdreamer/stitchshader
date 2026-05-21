shader_type spatial;

uniform sampler2D defaultGrid : filter_nearest;
uniform vec2 canvasSize = vec2(240.0, 135.0);
uniform vec3 backgroundColor: source_color = vec3(1.0, 1.0, 1.0);


void fragment() {
	// set base grid
	vec2 uvBaseGrid = UV * canvasSize * 0.5;
	vec4 gridTexture = texture(defaultGrid, uvBaseGrid);

	// set modifiable color for the base grid
	vec4 gridTextureColor = vec4(backgroundColor.rgb * gridTexture.rgb, gridTexture.a);
 
	ALBEDO = gridTextureColor.rgb;
	ALPHA = gridTexture.a;

}