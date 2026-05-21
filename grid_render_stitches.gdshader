shader_type spatial;
render_mode unshaded;

// texture containing all the stitches
uniform sampler2D stitchType : filter_nearest, repeat_enable;
// amount of different stitches in the texture
uniform float stitchAmount = 8.0;
// size (in pixels) of each stitch
uniform float stitchSize = 16.0;
// amount of stitches on the vertical axis (to allow for variations on the same stitch, maybe thicker thread or something -- for later)
uniform float stitchVariationAmount = 1.0;
// viewport that shows the "actual" game happening, before shading
uniform sampler2D imgInStitch : filter_nearest;
uniform sampler2D imgInCol : filter_nearest;
// size of the canvas, should be the same as the incoming viewport image
uniform vec2 canvasSize = vec2(240.0, 135.0);

void fragment() {
	// get viewport game input & canvasUV
	vec2 canvasUV = vec2(UV.x * canvasSize.x, UV.y * canvasSize.y);
	vec4 imgInTexture = texture(imgInStitch, UV);
	vec4 imgInColor = texture(imgInCol, UV);

	// offset stitch count to align with the tiling
	float stitchOffset = float(int(canvasUV.x) % int(stitchAmount)) / 8.0;
	
	// get stitches as texture (y can be multiplied later if we have variations)
	float stitchSelection = canvasUV.x * (1.0 / stitchAmount) + imgInTexture.r - stitchOffset;
	vec2 stitchUV = vec2(stitchSelection, canvasUV.y);
	vec4 stitchTexture = texture(stitchType, stitchUV);

	vec4 stitchesOut = imgInColor * stitchTexture;
 
	ALBEDO = stitchesOut.rgb;
	ALPHA = stitchesOut.a;

}