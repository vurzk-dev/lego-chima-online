Shader "Chi Ball_V01" {
	Properties {
		_MainTex ("Base texture", 2D) = "white" {}
		_ScrollY ("Base layer Scroll speed Y", Float) = -0.12
		_ScrollX ("Base layer Scroll speed X", Float) = 0
		_DetailTex ("Animated Texture", 2D) = "white" {}
		_Scroll2X ("Detail layer Scroll speed X", Float) = 0
		_Scroll2Y ("Detail layer Scroll speed Y", Float) = -0.2
		_FreshnelPower ("Freshnel Power", Range(0, 5)) = 1.119608
		_Opacity ("Opacity", Range(0, 1)) = 0.5328891
		_HighLightTexture ("HighLight Texture", 2D) = "black" {}
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		LOD 100
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 100
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			ZWrite Off
			GpuProgramID 50160
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    SV_Target0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _FreshnelPower;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_3_1[22];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    u_xlatb1.xyw = lessThan(vec4(0.5, 0.5, 0.0, 0.5), u_xlat1.xyxz).xyw;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.w) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat2 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyw = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat1.xyw * u_xlat1.zzz;
					    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xyw + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat2.xy = vec2(u_xlat22) * vec2(_Opacity, _FreshnelPower);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat3.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * _LightColor0.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat21 = exp2(u_xlat2.x);
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat1.x = u_xlat2.y * u_xlat21;
					    SV_Target0.w = u_xlat21;
					    u_xlat21 = exp2(u_xlat1.x);
					    u_xlat0.xyz = vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD3 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD_DELTA"
			LOD 100
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 121658
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
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
					Keywords { "SPOT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat1.xy;
					    vs_TEXCOORD3.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat1.xy;
					    vs_TEXCOORD1 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
					out float vs_TEXCOORD5;
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
					    vs_TEXCOORD5 = u_xlat0.z;
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
					Keywords { "SPOT" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD2.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD5 = u_xlat1.z;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat1.xy;
					    vs_TEXCOORD3.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat1.xy;
					    vs_TEXCOORD1 = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
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
						vec4 unused_0_0[6];
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlatb1.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat1.xyzx).xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.z) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat1 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.www * (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat22 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat4 = texture(_LightTexture0, vec2(u_xlat22));
					    u_xlat4.xyz = u_xlat4.xxx * _LightColor0.xyz;
					    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat6.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * _Opacity;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat21);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat22) * u_xlat0.xyz;
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat12;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat12.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat12.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlatb1.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat1.xyzx).xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.z) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat1 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.www * (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat2.xyz;
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
					    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = log2(u_xlat18);
					    u_xlat18 = u_xlat18 * 64.0;
					    u_xlat18 = exp2(u_xlat18);
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat4.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat19 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat19 = max(u_xlat19, 0.0);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat19 = log2(u_xlat19);
					    u_xlat19 = u_xlat19 * _Opacity;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat19) * u_xlat0.xyz;
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
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
						vec4 unused_0_0[6];
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlatb1.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat1.xyzx).xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.z) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat1 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xy);
					    u_xlatb21 = 0.0<vs_TEXCOORD3.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat21 = u_xlat2.w * u_xlat21;
					    u_xlat22 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat22));
					    u_xlat21 = u_xlat21 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat3.xyz = _WorldSpaceLightPos0.www * (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat5.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * _Opacity;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat22) * u_xlat0.xyz;
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 unused_0_0[6];
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlatb1.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat1.xyzx).xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.z) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat1 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.www * (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat22 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat22));
					    u_xlat6 = texture(_LightTexture0, vs_TEXCOORD3.xyz);
					    u_xlat22 = u_xlat4.x * u_xlat6.w;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat6.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * _Opacity;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat21);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat22) * u_xlat0.xyz;
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 unused_0_0[6];
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlatb1.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat1.xyzx).xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.z) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat1 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.www * (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat4 = texture(_LightTexture0, vs_TEXCOORD3.xy);
					    u_xlat4.xyz = u_xlat4.www * _LightColor0.xyz;
					    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat6.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * _Opacity;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat21);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat22) * u_xlat0.xyz;
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "FOG_LINEAR" }
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
						vec4 unused_0_0[6];
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlatb1.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat1.xyzx).xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.z) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat1 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.www * (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat22 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat4 = texture(_LightTexture0, vec2(u_xlat22));
					    u_xlat4.xyz = u_xlat4.xxx * _LightColor0.xyz;
					    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat6.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * _Opacity;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat21);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat22) * u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = 0.0;
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
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat12;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat12.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat12.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlatb1.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat1.xyzx).xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.z) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat1 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.www * (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat2.xyz;
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
					    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
					    u_xlat18 = dot(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = log2(u_xlat18);
					    u_xlat18 = u_xlat18 * 64.0;
					    u_xlat18 = exp2(u_xlat18);
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat4.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat19 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat19 = max(u_xlat19, 0.0);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat19 = log2(u_xlat19);
					    u_xlat19 = u_xlat19 * _Opacity;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat19) * u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" "FOG_LINEAR" }
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
						vec4 unused_0_0[6];
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlatb1.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat1.xyzx).xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.z) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat1 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xy);
					    u_xlatb21 = 0.0<vs_TEXCOORD3.z;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat21 = u_xlat2.w * u_xlat21;
					    u_xlat22 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat2 = texture(_LightTextureB0, vec2(u_xlat22));
					    u_xlat21 = u_xlat21 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat21) * _LightColor0.xyz;
					    u_xlat3.xyz = _WorldSpaceLightPos0.www * (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat3.xyz;
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat6.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat6.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat5.xyz;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat22 = dot(u_xlat6.xyz, u_xlat4.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * _Opacity;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat22) * u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_0[6];
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlatb1.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat1.xyzx).xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.z) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat1 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.www * (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat22 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat4 = texture(_LightTextureB0, vec2(u_xlat22));
					    u_xlat6 = texture(_LightTexture0, vs_TEXCOORD3.xyz);
					    u_xlat22 = u_xlat4.x * u_xlat6.w;
					    u_xlat4.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat6.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * _Opacity;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat21);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat22) * u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
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
						vec4 unused_0_0[6];
						vec4 _LightColor0;
						vec4 _TimeEditor;
						vec4 _MainTex_ST;
						vec4 _DetailTex_ST;
						float _ScrollY;
						float _ScrollX;
						float _Scroll2X;
						float _Scroll2Y;
						float _Opacity;
						vec4 _HighLightTexture_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _MainTex;
					uniform  sampler2D _DetailTex;
					uniform  sampler2D _HighLightTexture;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec3 u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat14;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat0 = u_xlat0.xxxx * vec4(_ScrollX, _ScrollY, _Scroll2X, _Scroll2Y) + vs_TEXCOORD0.xyxy;
					    u_xlat14.xy = u_xlat0.zw * _DetailTex_ST.xy + _DetailTex_ST.zw;
					    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_DetailTex, u_xlat14.xy);
					    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat2.xyz = u_xlat2.xyz / u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlatb1.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat1.xyzx).xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz / u_xlat3.xyz;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat2.x;
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : u_xlat2.y;
					        hlslcc_movcTemp.z = (u_xlatb1.z) ? u_xlat0.z : u_xlat2.z;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat1.xy = vs_TEXCOORD0.xy * _HighLightTexture_ST.xy + _HighLightTexture_ST.zw;
					    u_xlat1 = texture(_HighLightTexture, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.www * (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
					    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat5.xyz = vec3(u_xlat21) * vs_TEXCOORD2.xyz;
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat5.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = log2(u_xlat21);
					    u_xlat21 = u_xlat21 * 64.0;
					    u_xlat21 = exp2(u_xlat21);
					    u_xlat4 = texture(_LightTexture0, vs_TEXCOORD3.xy);
					    u_xlat4.xyz = u_xlat4.www * _LightColor0.xyz;
					    u_xlat6.xyz = vec3(u_xlat21) * u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat6.xyz;
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat22 = max(u_xlat22, 0.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * _Opacity;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat21);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat22) * u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Standard"
	CustomEditor "ShaderForgeMaterialInspector"
}