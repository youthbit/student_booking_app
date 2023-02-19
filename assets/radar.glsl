uniform vec2 iResolution;
uniform vec3 backgroundColor;
uniform vec3 radarColor;
uniform float iTime;

out vec4 fragColor;

float fadeDistance = 1.0;
float resetTimeSec = 4.0;
float radarPingSpeed = 0.3;
vec2 greenPing = vec2(0.0, 0.0);

float RadarPing(
vec2 uv,
vec2 center,
float innerTail,
float frontierBorder,
float timeResetSeconds,
float radarPingSpeed,
float fadeDistance,
float displace
)
{
    vec2 diff = center-uv;
    float r = length(diff);
    float time = 0.3 + mod(iTime + displace, timeResetSeconds) * radarPingSpeed;

    float circle = smoothstep(time - innerTail, time, r) * smoothstep(time + frontierBorder, time, r);
    circle *= smoothstep(fadeDistance, 0.0, r);// fade to 0 after fadeDistance

    return circle;
}

void main()
{
    //normalize coordinates
    vec2 uv = gl_FragCoord.xy / iResolution.xy;//move coordinates to 0..1
    uv = uv.xy*2;// translate to the center
    uv += vec2(-1.0, -1.0);

    float color = RadarPing(uv, greenPing, 0.4, 0.025, resetTimeSec, radarPingSpeed, fadeDistance, 0.0);
    color += RadarPing(uv, greenPing, 0.4, 0.025, resetTimeSec, radarPingSpeed, fadeDistance, resetTimeSec / 3);
    color += RadarPing(uv, greenPing, 0.4, 0.025, resetTimeSec, radarPingSpeed, fadeDistance, resetTimeSec / 3 * 2);

    //return the new color

    fragColor = vec4(mix(backgroundColor, radarColor, color), 1);
}
