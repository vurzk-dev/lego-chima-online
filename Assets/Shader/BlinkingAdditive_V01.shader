Shader "BlinkingAdditive_V01" {
	Properties {
		_MainTexture ("MainTexture", 2D) = "white" {}
		_ColorMultiptier ("Color Multiptier", Range(0, 1)) = 1
		_TintColor ("Color", Vector) = (1,0,0,1)
		_Flashing_Speed ("Flashing_Speed", Float) = 5
		[MaterialToggle] _Normal_Sin ("Normal_Sin", Float) = 0
		_Duty_cyclefactor ("Duty_cycle factor", Range(-1, 1)) = 0.1738886
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 32709
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					void main()
					{
					    u_xlat0 = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0 * _Flashing_Speed;
					    u_xlat0 = sin(u_xlat0);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0;
					    u_xlatb2.y = u_xlat0>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0) + u_xlat2.x;
					    u_xlat0 = _Normal_Sin * u_xlat2.x + u_xlat0;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    SV_Target0.xyz = abs(vec3(u_xlat0)) * u_xlat2.xyz;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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
						vec4 _TimeEditor;
						vec4 _MainTexture_ST;
						vec4 _TintColor;
						float _ColorMultiptier;
						float _Flashing_Speed;
						float _Normal_Sin;
						float _Duty_cyclefactor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD1;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bvec2 u_xlatb2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0.x = u_xlat0.x * _Flashing_Speed;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlatb2.x = _Duty_cyclefactor>=u_xlat0.x;
					    u_xlatb2.y = u_xlat0.x>=_Duty_cyclefactor;
					    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
					    u_xlat2.z = u_xlatb2.y ? float(1.0) : 0.0;
					;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
					    u_xlat2.x = u_xlat2.x + u_xlat2.z;
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = _Normal_Sin * u_xlat2.x + u_xlat0.x;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTexture_ST.xy + _MainTexture_ST.zw;
					    u_xlat1 = texture(_MainTexture, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorMultiptier);
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = abs(u_xlat0.xxx) * u_xlat2.xyz;
					    u_xlat6 = vs_TEXCOORD1 / _ProjectionParams.y;
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