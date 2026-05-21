shader_type spatial;
render_mode unshaded;

// texture containing all the stitches
uniform sampler2D stitchType : filter_nearest;
// amount of different stitches in the texture
uniform float stitchAmount = 8.0;
// size (in pixels) of each stitch
uniform float stitchSize = 16.0;
// amount of stitches on the vertical axis (to allow for variations on the same stitch, maybe thicker thread or something -- for later)
uniform float stitchVariationAmount = 1.0;
// viewport that shows the "actual" game happening, before shading
uniform sampler2D imgIn : filter_nearest;
// size of the canvas, should be the same as the incoming viewport image
uniform vec2 canvasSize = vec2(240.0, 135.0);

void fragment() {
	// get viewport game input & canvasUV
	vec2 canvasUV = vec2(UV.x * canvasSize.x, UV.y * canvasSize.y);
	vec4 imgInTexture = texture(imgIn, UV);

	// get stitches as texture (y can be multiplied later if we have variations)
	float stitchSelection = canvasUV.x * (1.0 / stitchAmount) + imgInTexture.r;
	vec2 stitchUV = vec2(stitchSelection, canvasUV.y);
	vec4 stitchTexture = texture(stitchType, stitchUV);

	vec4 stitchesOut = imgInTexture * stitchTexture;
 
	ALBEDO = stitchesOut.rgb;
	ALPHA = stitchesOut.a;

}