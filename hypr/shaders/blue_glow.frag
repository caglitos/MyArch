#version 300 es
precision mediump float;

uniform sampler2D tex;
in vec2 v_texcoord;
out vec4 fragColor;

void main() {
    vec4 color = texture(tex, v_texcoord);

    vec2 center = vec2(0.5, 0.5);
    float dist = distance(v_texcoord, center);

    float glow = exp(-dist * 6.0);

    vec3 glowColor = vec3(0.1, 0.4, 1.0) * glow * 0.6;

    fragColor = vec4(color.rgb + glowColor, color.a);
}
