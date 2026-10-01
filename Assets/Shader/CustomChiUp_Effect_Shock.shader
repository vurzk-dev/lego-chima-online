Shader "Custom/ChiUp_Effect_Shock" {
	Properties {
		_Texture2 ("Texture2", 2D) = "black" {}
		_TintColor ("Color", Vector) = (0.5,0.5,0.5,1)
		_Texture1 ("Texture1", 2D) = "black" {}
		_Texture1ScrollX ("Texture1 Scroll X", Range(-2, 2)) = 0
		_Texture1ScrollY ("Texture1 Scroll Y", Range(-2, 2)) = -0.8547009
		_Texture2ScrollX ("Texture2 Scroll X", Range(-2, 2)) = 0
		_Texture2ScrollY ("Texture2 Scroll Y", Range(-2, 2)) = -0.5641025
		_Multiplier ("Multiplier", Range(0, 5)) = 2.736801
		_Opacity ("Opacity", Range(-10, 10)) = 3.386022
		_Variable1 ("Variable1", Float) = 0.6
		_WaveLength ("WaveLength", Float) = 0.35
		_Frequency ("Frequency", Float) = 8
		_Strength ("Strength", Float) = 2.5
		_FresnelPower ("FresnelPower", Range(-1, 1)) = -0.02533219
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 50460
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD4;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(_Multiplier);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 _Texture2_ST;
						vec4 _TintColor;
						vec4 _Texture1_ST;
						float _Texture1ScrollX;
						float _Texture1ScrollY;
						float _Texture2ScrollX;
						float _Texture2ScrollY;
						float _Multiplier;
						float _Opacity;
						vec4 unused_0_10;
						float _FresnelPower;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_2_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD4;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat9 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat3.x = (-_Opacity) + 1.0;
					    u_xlat6 = u_xlat0.x * u_xlat3.x;
					    u_xlat6 = exp2(u_xlat6);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat9 = u_xlat0.x * _Opacity;
					    u_xlat0.x = u_xlat0.x * unused_0_10.z;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat1.x = u_xlat9 * _Opacity;
					    u_xlatb4 = _Opacity>=u_xlat3.x;
					    u_xlatb3 = u_xlat3.x>=_Opacity;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat1.x = u_xlat1.x * u_xlat4;
					    u_xlat4 = u_xlat3.x * u_xlat4;
					    u_xlat3.x = u_xlat3.x * u_xlat6 + u_xlat1.x;
					    u_xlat6 = u_xlat9 * _Opacity + (-u_xlat3.x);
					    SV_Target0.w = u_xlat4 * u_xlat6 + u_xlat3.x;
					    u_xlat1 = vec4(_Texture1ScrollX, _Texture1ScrollY, _Texture2ScrollX, _Texture2ScrollY) * _Time.yyyy + vs_TEXCOORD0.xyxy;
					    u_xlat3.xy = u_xlat1.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    u_xlat1.xy = u_xlat1.zw * _Texture2_ST.xy + _Texture2_ST.zw;
					    u_xlat1 = texture(_Texture2, u_xlat1.xy);
					    u_xlat2 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(_Multiplier);
					    u_xlat9 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
					    return;
					}"
				}
			}
		}
		Pass {
			Name "SHADOWCASTER"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Cull Off
			Offset 1, 1
			GpuProgramID 106421
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD1;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat4 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat4);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat4) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat4;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD1;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD1;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat4 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat4);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat4) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat4;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _Variable1;
						float _WaveLength;
						float _Frequency;
						float _Strength;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_3_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD1;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_ObjectToWorld[1].xz;
					    u_xlat0.xy = unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * _Variable1 + u_xlat0.x;
					    u_xlat2 = _Frequency * _Time.y;
					    u_xlat0.x = u_xlat0.x * _WaveLength + u_xlat2;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Strength;
					    u_xlat0.xyz = u_xlat0.xxx * in_TEXCOORD1.yyy + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
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