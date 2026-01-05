#version 300 es
precision mediump float;

uniform sampler2D tex;
in vec2 v_texcoord;
out vec4 fragColor;

void main() {
    vec4 c = texture(tex, v_texcoord);
    fragColor = vec4(c.rgb * 1.2, c.a);
}
