shader_type canvas_item;

uniform float glitch_strength_coef = 0.03;

void fragment() {
    vec2 uv = UV;
    
    // === RANDOM JITTER EFFECT ===
    float glitch_strength = sin(TIME * 5.0) * (glitch_strength_coef); // Strength of distortion varies over time
    float scanline_offset = sin(uv.y * 100.0 + TIME * 10.0) * glitch_strength; // Per-line offset
    
    // Add random jumps for a "corrupt frame" effect
    if (fract(sin(TIME * 20.0) * 43758.5453) > 0.9) {
        uv.x += glitch_strength * 3.0; // Sudden horizontal shift
    }

    uv.x += scanline_offset; // Apply per-line distortion

    // === RGB SEPARATION EFFECT ===
    float r = texture(TEXTURE, uv + vec2(0.005, 0.0)).r;
    float g = texture(TEXTURE, uv).g;
    float b = texture(TEXTURE, uv - vec2(0.005, 0.0)).b;

    vec3 col = vec3(r, g, b); // Recombine shifted color channels

    // === RANDOM NOISE EFFECT ===
    float noise = fract(sin(dot(uv + TIME, vec2(12.9898, 78.233))) * 43758.5453);
    col += vec3(noise * 0.1); // Add subtle noise

    // === OCCASIONAL GLITCH BARS (HARD CUTS) ===
    if (fract(sin(TIME * 50.0) * 43758.5453) > 0.97) {
        uv.y += 0.05; // Sudden vertical shift of part of the image
    }

    COLOR = vec4(col, texture(TEXTURE, uv).a);
}
