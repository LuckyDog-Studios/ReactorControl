shader_type canvas_item;

uniform float thickness = 12;
uniform float speed = 50.0; // Adjust speed of scrolling

void fragment() {
    vec4 color1 = vec4(76.0 / 255.0, 146.0 / 255.0, 25.0 / 255.0, 0.3); // #4c9219 with low alpha
    vec4 color2 = vec4(145.0 / 255.0, 199.0 / 255.0, 104.0 / 255.0, 0.3); // #91c768 with low alpha

    // Offset scanlines using TIME to create motion
    float offset = mod(FRAGCOORD.y + TIME * speed, thickness) < thickness/2.0 ? 1.0 : 0.0;

    COLOR = mix(color1, color2, offset);
}
