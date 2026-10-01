Shader "Shader Forge/ChiUp_Surface" {
	Properties {
		_MainTex ("MainTex", 2D) = "black" {}
		_TintColor ("Main Color", Vector) = (0.5,0.5,0.5,1)
		_FresnelPower ("Fresnel Power", Range(0, 100)) = 0
		_EmissiveStrength ("Emissive Strength", Range(0, 10)) = 6.45384
		_FreshnelColor ("Freshnel Color", Vector) = (0.5,0.5,0.5,1)
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 54791
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
						vec4 _TintColor;
						float _FresnelPower;
						float _EmissiveStrength;
						vec4 _FreshnelColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _FresnelPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _FreshnelColor.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(vec3(_EmissiveStrength, _EmissiveStrength, _EmissiveStrength)) + u_xlat0.xyz;
					    u_xlat6 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat6 = u_xlat6 * _ProjectionParams.z;
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat6 = u_xlat6 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat6);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
	CustomEditor "ShaderForgeMaterialInspector"
}