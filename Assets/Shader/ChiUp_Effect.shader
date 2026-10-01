Shader "ChiUp_Effect" {
	Properties {
		_MainTex ("Base texture", 2D) = "black" {}
		_ScrollY ("Base layer Scroll speed Y", Float) = -0.12
		_ScrollX ("Base layer Scroll speed X", Float) = 0
		_DetailTex ("Animated Texture", 2D) = "black" {}
		_Scroll2X ("Detail layer Scroll speed X", Float) = 0
		_Scroll2Y ("Detail layer Scroll speed Y", Float) = -0.2
		_TintColor ("Tint Color", Vector) = (0.3676471,0.6860042,1,1)
		_Edgecolor ("Edge color", Vector) = (1,0.5147059,0.5147059,1)
		_Fresnel_Power_Base ("Fresnel_Power_Base", Range(-10, 10)) = 0
		_Fresnel_Power_Animated ("Fresnel_Power_Animated", Range(-10, 10)) = 0
		_Desaturate_Control ("Desaturate_Control", Range(0, 1)) = 0
		[MaterialToggle] _Base_switch ("Base_switch", Float) = 0
		[MaterialToggle] _Animated_switch ("Animated_switch", Float) = 0
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		LOD 100
		Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 100
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 44181
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    SV_Target0.w = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						vec4 _TintColor;
						vec4 _Edgecolor;
						float _Fresnel_Power_Base;
						float _Fresnel_Power_Animated;
						float _Desaturate_Control;
						float _Base_switch;
						float _Animated_switch;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.xy = u_xlat0.xx * vec2(_Fresnel_Power_Base, _Fresnel_Power_Animated);
					    u_xlat0.xy = exp2(u_xlat0.xy);
					    u_xlat1 = _Time.yyyy * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat8.xy = u_xlat1.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
					    u_xlat8.x = u_xlat2.y + u_xlat2.x;
					    u_xlat8.x = u_xlat2.z + u_xlat8.x;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat8.xxx;
					    u_xlat2.xyz = vec3(_Animated_switch) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat4.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat13 = u_xlat1.y + u_xlat1.x;
					    u_xlat13 = u_xlat1.z + u_xlat13;
					    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(u_xlat13);
					    u_xlat1.xyz = vec3(vec3(_Base_switch, _Base_switch, _Base_switch)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + _Edgecolor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_Desaturate_Control, _Desaturate_Control, _Desaturate_Control));
					    SV_Target0.w = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
					    u_xlat0.xyz = u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "SHADOWCASTER"
			LOD 100
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Cull Off
			Offset 1, 1
			GpuProgramID 90516
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
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
					layout(std140) uniform UnityShadows {
						vec4 unused_0_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_0_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat4;
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
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat4 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat4);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat4) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat4;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
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
					layout(std140) uniform UnityShadows {
						vec4 unused_0_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_0_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
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
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "FOG_LINEAR" }
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
					layout(std140) uniform UnityShadows {
						vec4 unused_0_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_0_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat4;
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
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat4 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat4);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat4) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat4;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" "FOG_LINEAR" }
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
					layout(std140) uniform UnityShadows {
						vec4 unused_0_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_0_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
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
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
		}
	}
	Fallback "Particles/Additive"
	CustomEditor "ShaderForgeMaterialInspector"
}