shader_type spatial;

                    //    center_x, center_z, width/2, rotation
uniform bool invert1 = false;
uniform vec4 portal1 = vec4(0.0, 0.5, 0.5, 0.0);
uniform bool invert2 = false;
uniform vec4 portal2 = vec4(0.0, -0.5, 0.5, 0.0);

render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;
uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1) = 1.0;
uniform float point_size : hint_range(0,128);
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;


void vertex() {
    UV=UV*uv1_scale.xy+uv1_offset.xy;
}

float f(float x1, float y1, float x2, float y2, float x){
    float slope = (y2 - y1) / (x2 - x1);
    return (slope * x) - (slope * x1) + y1;
   }

bool is_through_portal(vec2 camera_pos, vec2 pixel_pos, vec4 portal){
    float x1 = portal.x - (portal.z * cos(portal.w));
    float y1 = portal.y - portal.z * sin(portal.w);
    float x2 = portal.x + (portal.z * cos(portal.w));
    float y2 = portal.y + portal.z * sin(portal.w);
    float fx1 = f(camera_pos.x, camera_pos.y, pixel_pos.x, pixel_pos.y, x1);
    float fx2 = f(camera_pos.x, camera_pos.y, pixel_pos.x, pixel_pos.y, x2);
    float fxc = f(x1, y1, x2, y2, camera_pos.x);
    float fxp = f(x1, y1, x2, y2, pixel_pos.x);
    return (((fx1 - y1) * (fx2 - y2) < 0.0) && ((fxc - camera_pos.y) * (fxp - pixel_pos.y) < 0.0));
   }


void fragment(){
    vec2 camera_pos = (CAMERA_MATRIX * vec4(0.0, 0.0, 0.0, 1.0)).xz;
    vec2 pixel_pos = (CAMERA_MATRIX * vec4(VERTEX, 1.0)).xz;
    
    bool through_first = is_through_portal(camera_pos, pixel_pos, portal1);
    bool through_second = is_through_portal(camera_pos, pixel_pos, portal2);
    
    vec2 base_uv = UV;
    vec4 albedo_tex = texture(texture_albedo,base_uv);
    ALBEDO = albedo.rgb * albedo_tex.rgb;
    METALLIC = metallic;
    ROUGHNESS = roughness;
    SPECULAR = specular;
    
    if (!(invert1 != through_first) || !(invert2 != through_second)){
        ALPHA = 0.0;
       }
    
   }