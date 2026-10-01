Shader "Custom/Waterfall 06" {
	Properties {
		_MainTex ("Flow Tex", 2D) = "white" {}
		_Color ("Color", Vector) = (1,1,1,1)
		_FlowU ("Flow Speed U (Min:x Max:y)", Vector) = (1,1,0,0)
		_FlowV ("Flow Speed V (Min:x Max:y)", Vector) = (1,1,0,0)
		_Brightness ("Brightness", Float) = 1
		_Gamma ("Gamma", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 38600
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
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
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
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
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
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
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unused_3_0;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD2;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD5.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[31];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_14[2];
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
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat18 = u_xlat1.y * u_xlat1.y;
					    u_xlat18 = u_xlat1.x * u_xlat1.x + (-u_xlat18);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat3.x = dot(unity_SHAr, u_xlat1);
					    u_xlat3.y = dot(unity_SHAg, u_xlat1);
					    u_xlat3.z = dot(unity_SHAb, u_xlat1);
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat2.xyz + u_xlat0.xyz;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unused_3_0;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD2;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD5.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
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
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD4 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD4 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD4 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD4 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD4 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD4 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unused_3_0;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD2;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD5.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD3.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD5.y = u_xlat2.x;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD5.x = u_xlat1.z;
					    vs_TEXCOORD6.x = u_xlat1.x;
					    vs_TEXCOORD7.x = u_xlat1.y;
					    vs_TEXCOORD6.z = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat0.z;
					    vs_TEXCOORD6.y = u_xlat2.y;
					    vs_TEXCOORD7.y = u_xlat2.z;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[31];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_14[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat18 = u_xlat1.z / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    vs_TEXCOORD4 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat18 = u_xlat1.y * u_xlat1.y;
					    u_xlat18 = u_xlat1.x * u_xlat1.x + (-u_xlat18);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat3.x = dot(unity_SHAr, u_xlat1);
					    u_xlat3.y = dot(unity_SHAg, u_xlat1);
					    u_xlat3.z = dot(unity_SHAb, u_xlat1);
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat2.xyz + u_xlat0.xyz;
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
						vec4 unused_0_0[7];
						vec4 _MainTex_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unused_3_0;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD2;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD5.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_3_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_3_2[4];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					float u_xlat14;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat12 = roundEven(vs_COLOR0.x);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat12 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = u_xlat1.y * u_xlat2.x;
					    u_xlat12 = u_xlat12 * vs_COLOR0.z;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Gamma;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Brightness;
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat5.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat5.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat5.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat5.x = u_xlat5.x + u_xlat5.x;
					    u_xlat5.xyz = vs_TEXCOORD1.xyz * (-u_xlat5.xxx) + (-u_xlat0.xyz);
					    u_xlat2.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat1 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat13 = u_xlat1.w + -1.0;
					    u_xlat13 = unity_SpecCube0_HDR.w * u_xlat13 + 1.0;
					    u_xlat13 = u_xlat13 * unity_SpecCube0_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13);
					    u_xlat13 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD1.xyz;
					    u_xlat13 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat14 = u_xlat13 + u_xlat13;
					    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat14)) + u_xlat0.xyz;
					    u_xlat14 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat13 = u_xlat13;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.y = (-u_xlat13) + 1.0;
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 3.53466082;
					    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
					    u_xlat4 = u_xlat0.y * -2.98023224e-08 + 0.220916301;
					    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat12) * _Color.xyz + u_xlat0.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_3_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_3_2[4];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					float u_xlat14;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat12 = roundEven(vs_COLOR0.x);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat12 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = u_xlat1.y * u_xlat2.x;
					    u_xlat12 = u_xlat12 * vs_COLOR0.z;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Gamma;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Brightness;
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat5.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat5.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat5.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat5.x = u_xlat5.x + u_xlat5.x;
					    u_xlat5.xyz = vs_TEXCOORD1.xyz * (-u_xlat5.xxx) + (-u_xlat0.xyz);
					    u_xlat2.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat1 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat13 = u_xlat1.w + -1.0;
					    u_xlat13 = unity_SpecCube0_HDR.w * u_xlat13 + 1.0;
					    u_xlat13 = u_xlat13 * unity_SpecCube0_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13);
					    u_xlat13 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD1.xyz;
					    u_xlat13 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat14 = u_xlat13 + u_xlat13;
					    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat14)) + u_xlat0.xyz;
					    u_xlat14 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat13 = u_xlat13;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.y = (-u_xlat13) + 1.0;
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 3.53466082;
					    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
					    u_xlat4 = u_xlat0.y * -2.98023224e-08 + 0.220916301;
					    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat12) * _Color.xyz + u_xlat0.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_3_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_3_2[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat12)) + (-u_xlat0.xyz);
					    u_xlat1 = textureLod(unity_SpecCube0, u_xlat1.xyz, 6.0);
					    u_xlat12 = u_xlat1.w + -1.0;
					    u_xlat12 = unity_SpecCube0_HDR.w * u_xlat12 + 1.0;
					    u_xlat12 = u_xlat12 * unity_SpecCube0_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat13 = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat3.y = (-u_xlat12) + 1.0;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat13)) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat4 = u_xlat0.y * -2.98023224e-08 + 0.220916301;
					    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat0.z = 1.0;
					    u_xlat0 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat0.x * 3.53466082;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = roundEven(vs_COLOR0.x);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat2.x = u_xlat12 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = u_xlat1.y * u_xlat2.x;
					    u_xlat12 = u_xlat12 * vs_COLOR0.z;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Gamma;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Brightness;
					    SV_Target0.xyz = vec3(u_xlat12) * _Color.xyz + u_xlat0.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_3_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_3_2[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat12)) + (-u_xlat0.xyz);
					    u_xlat1 = textureLod(unity_SpecCube0, u_xlat1.xyz, 6.0);
					    u_xlat12 = u_xlat1.w + -1.0;
					    u_xlat12 = unity_SpecCube0_HDR.w * u_xlat12 + 1.0;
					    u_xlat12 = u_xlat12 * unity_SpecCube0_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat13 = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat3.y = (-u_xlat12) + 1.0;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat13)) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat4 = u_xlat0.y * -2.98023224e-08 + 0.220916301;
					    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat0.z = 1.0;
					    u_xlat0 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat0.x * 3.53466082;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = roundEven(vs_COLOR0.x);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat2.x = u_xlat12 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = u_xlat1.y * u_xlat2.x;
					    u_xlat12 = u_xlat12 * vs_COLOR0.z;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Gamma;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Brightness;
					    SV_Target0.xyz = vec3(u_xlat12) * _Color.xyz + u_xlat0.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_2_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_2_2[4];
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec2 u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = roundEven(vs_COLOR0.x);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat4.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat4.xy = vs_COLOR0.xy * u_xlat4.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat4.xy * _Time.xx;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.y = 0.0;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.z = 0.0;
					    u_xlat4.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat4.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.y;
					    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Gamma;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Brightness;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
					    u_xlat2 = textureLod(unity_SpecCube0, u_xlat2.xyz, 6.0);
					    u_xlat12 = u_xlat2.w + -1.0;
					    u_xlat12 = unity_SpecCube0_HDR.w * u_xlat12 + 1.0;
					    u_xlat12 = u_xlat12 * unity_SpecCube0_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12);
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat1.x = u_xlat12 * u_xlat12;
					    u_xlat1.x = u_xlat12 * u_xlat1.x;
					    u_xlat12 = u_xlat12 * u_xlat1.x;
					    u_xlat12 = u_xlat12 * -2.98023224e-08 + 0.220916301;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_2_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_2_2[4];
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec2 u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = roundEven(vs_COLOR0.x);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat4.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat4.xy = vs_COLOR0.xy * u_xlat4.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat4.xy * _Time.xx;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.y = 0.0;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.z = 0.0;
					    u_xlat4.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat4.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.y;
					    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Gamma;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Brightness;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
					    u_xlat2 = textureLod(unity_SpecCube0, u_xlat2.xyz, 6.0);
					    u_xlat12 = u_xlat2.w + -1.0;
					    u_xlat12 = unity_SpecCube0_HDR.w * u_xlat12 + 1.0;
					    u_xlat12 = u_xlat12 * unity_SpecCube0_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12);
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat1.x = u_xlat12 * u_xlat12;
					    u_xlat1.x = u_xlat12 * u_xlat1.x;
					    u_xlat12 = u_xlat12 * u_xlat1.x;
					    u_xlat12 = u_xlat12 * -2.98023224e-08 + 0.220916301;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat30;
					float u_xlat31;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat2.xy = vs_COLOR0.xy * u_xlat2.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat2.xy = u_xlat2.xy * _Time.xx;
					    u_xlat31 = roundEven(vs_COLOR0.x);
					    u_xlat31 = u_xlat31 * 2.0 + -1.0;
					    u_xlat3.x = u_xlat31 * u_xlat2.x;
					    u_xlat3.y = 0.0;
					    u_xlat2.xw = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = texture(_MainTex, u_xlat2.xw);
					    u_xlat2.z = 0.0;
					    u_xlat2.xy = u_xlat2.zy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat31 = u_xlat2.y * u_xlat3.x;
					    u_xlat31 = u_xlat31 * vs_COLOR0.z;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * _Gamma;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * _Brightness;
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD1.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlatb2 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb2){
					        u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat2.x = inversesqrt(u_xlat2.x);
					        u_xlat4.xyz = u_xlat2.xxx * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat2.x = min(u_xlat5.y, u_xlat5.x);
					        u_xlat2.x = min(u_xlat5.z, u_xlat2.x);
					        u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat2.x = u_xlat4.w + -1.0;
					    u_xlat2.x = unity_SpecCube0_HDR.w * u_xlat2.x + 1.0;
					    u_xlat2.x = u_xlat2.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlatb33 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb33){
					        u_xlatb33 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb33){
					            u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat33 = inversesqrt(u_xlat33);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat33);
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat33 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat33 = min(u_xlat7.z, u_xlat33);
					            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, 6.0);
					        u_xlat12.x = u_xlat6.w + -1.0;
					        u_xlat12.x = unity_SpecCube1_HDR.w * u_xlat12.x + 1.0;
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * u_xlat12.xxx;
					        u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = abs(u_xlat30) + u_xlat1.x;
					    u_xlat10.x = u_xlat10.x + 9.99999975e-06;
					    u_xlat10.x = 0.5 / u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * 0.999999881;
					    u_xlat10.x = max(u_xlat10.x, 9.99999975e-05);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat1.x * u_xlat10.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat10.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat10.x = -abs(u_xlat30) + 1.0;
					    u_xlat20 = u_xlat10.x * u_xlat10.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat10.x = u_xlat10.x * -2.98023224e-08 + 0.220916301;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat10.xyz;
					    SV_Target0.xyz = vec3(u_xlat31) * _Color.xyz + u_xlat0.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat2.xy = vs_COLOR0.xy * u_xlat2.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat2.xy = u_xlat2.xy * _Time.xx;
					    u_xlat28 = roundEven(vs_COLOR0.x);
					    u_xlat28 = u_xlat28 * 2.0 + -1.0;
					    u_xlat3.x = u_xlat28 * u_xlat2.x;
					    u_xlat3.y = 0.0;
					    u_xlat2.xw = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = texture(_MainTex, u_xlat2.xw);
					    u_xlat2.z = 0.0;
					    u_xlat2.xy = u_xlat2.zy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat28 = u_xlat2.y * u_xlat3.x;
					    u_xlat28 = u_xlat28 * vs_COLOR0.z;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Gamma;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Brightness;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlatb29 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb29){
					        u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat29 = inversesqrt(u_xlat29);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat29 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat29 = min(u_xlat4.z, u_xlat29);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat29) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat2.x = u_xlat5.w + -1.0;
					        u_xlat2.x = unity_SpecCube1_HDR.w * u_xlat2.x + 1.0;
					        u_xlat2.x = u_xlat2.x * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat5.xyz * u_xlat2.xxx;
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = abs(u_xlat27) + u_xlat1.x;
					    u_xlat9.x = u_xlat9.x + 9.99999975e-06;
					    u_xlat9.x = 0.5 / u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * 0.999999881;
					    u_xlat9.x = max(u_xlat9.x, 9.99999975e-05);
					    u_xlat9.x = sqrt(u_xlat9.x);
					    u_xlat9.x = u_xlat1.x * u_xlat9.x;
					    u_xlat1.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat9.x = -abs(u_xlat27) + 1.0;
					    u_xlat18 = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat9.x = u_xlat9.x * -2.98023224e-08 + 0.220916301;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    SV_Target0.xyz = vec3(u_xlat28) * _Color.xyz + u_xlat0.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat2.xy = vs_COLOR0.xy * u_xlat2.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat2.xy = u_xlat2.xy * _Time.xx;
					    u_xlat28 = roundEven(vs_COLOR0.x);
					    u_xlat28 = u_xlat28 * 2.0 + -1.0;
					    u_xlat3.x = u_xlat28 * u_xlat2.x;
					    u_xlat3.y = 0.0;
					    u_xlat2.xw = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = texture(_MainTex, u_xlat2.xw);
					    u_xlat2.z = 0.0;
					    u_xlat2.xy = u_xlat2.zy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat28 = u_xlat2.y * u_xlat3.x;
					    u_xlat28 = u_xlat28 * vs_COLOR0.z;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Gamma;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Brightness;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlatb29 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb29){
					        u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat29 = inversesqrt(u_xlat29);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat29 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat29 = min(u_xlat4.z, u_xlat29);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat29) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat2.x = u_xlat5.w + -1.0;
					        u_xlat2.x = unity_SpecCube1_HDR.w * u_xlat2.x + 1.0;
					        u_xlat2.x = u_xlat2.x * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat5.xyz * u_xlat2.xxx;
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = abs(u_xlat27) + u_xlat1.x;
					    u_xlat9.x = u_xlat9.x + 9.99999975e-06;
					    u_xlat9.x = 0.5 / u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * 0.999999881;
					    u_xlat9.x = max(u_xlat9.x, 9.99999975e-05);
					    u_xlat9.x = sqrt(u_xlat9.x);
					    u_xlat9.x = u_xlat1.x * u_xlat9.x;
					    u_xlat1.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat9.x = -abs(u_xlat27) + 1.0;
					    u_xlat18 = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat9.x = u_xlat9.x * -2.98023224e-08 + 0.220916301;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    SV_Target0.xyz = vec3(u_xlat28) * _Color.xyz + u_xlat0.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat2.xy = vs_COLOR0.xy * u_xlat2.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat2.xy = u_xlat2.xy * _Time.xx;
					    u_xlat28 = roundEven(vs_COLOR0.x);
					    u_xlat28 = u_xlat28 * 2.0 + -1.0;
					    u_xlat3.x = u_xlat28 * u_xlat2.x;
					    u_xlat3.y = 0.0;
					    u_xlat2.xw = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = texture(_MainTex, u_xlat2.xw);
					    u_xlat2.z = 0.0;
					    u_xlat2.xy = u_xlat2.zy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat28 = u_xlat2.y * u_xlat3.x;
					    u_xlat28 = u_xlat28 * vs_COLOR0.z;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Gamma;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Brightness;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlatb29 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb29){
					        u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat29 = inversesqrt(u_xlat29);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat29 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat29 = min(u_xlat4.z, u_xlat29);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat29) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat2.x = u_xlat5.w + -1.0;
					        u_xlat2.x = unity_SpecCube1_HDR.w * u_xlat2.x + 1.0;
					        u_xlat2.x = u_xlat2.x * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat5.xyz * u_xlat2.xxx;
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = abs(u_xlat27) + u_xlat1.x;
					    u_xlat9.x = u_xlat9.x + 9.99999975e-06;
					    u_xlat9.x = 0.5 / u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * 0.999999881;
					    u_xlat9.x = max(u_xlat9.x, 9.99999975e-05);
					    u_xlat9.x = sqrt(u_xlat9.x);
					    u_xlat9.x = u_xlat1.x * u_xlat9.x;
					    u_xlat1.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat9.x = -abs(u_xlat27) + 1.0;
					    u_xlat18 = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat9.x = u_xlat9.x * -2.98023224e-08 + 0.220916301;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    SV_Target0.xyz = vec3(u_xlat28) * _Color.xyz + u_xlat0.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat27 = roundEven(vs_COLOR0.x);
					    u_xlat27 = u_xlat27 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat27 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat27 = u_xlat1.y * u_xlat2.x;
					    u_xlat27 = u_xlat27 * vs_COLOR0.z;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Gamma;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Brightness;
					    u_xlat1.xyz = vec3(u_xlat27) * _Color.xyz;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * -2.98023224e-08 + 0.220916301;
					    SV_Target0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat27 = roundEven(vs_COLOR0.x);
					    u_xlat27 = u_xlat27 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat27 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat27 = u_xlat1.y * u_xlat2.x;
					    u_xlat27 = u_xlat27 * vs_COLOR0.z;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Gamma;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Brightness;
					    u_xlat1.xyz = vec3(u_xlat27) * _Color.xyz;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * -2.98023224e-08 + 0.220916301;
					    SV_Target0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat27 = roundEven(vs_COLOR0.x);
					    u_xlat27 = u_xlat27 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat27 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat27 = u_xlat1.y * u_xlat2.x;
					    u_xlat27 = u_xlat27 * vs_COLOR0.z;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Gamma;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Brightness;
					    u_xlat1.xyz = vec3(u_xlat27) * _Color.xyz;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * -2.98023224e-08 + 0.220916301;
					    SV_Target0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_4_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_4_2[4];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					float u_xlat14;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat12 = roundEven(vs_COLOR0.x);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat12 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = u_xlat1.y * u_xlat2.x;
					    u_xlat12 = u_xlat12 * vs_COLOR0.z;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Gamma;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Brightness;
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat5.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat5.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat5.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat5.x = u_xlat5.x + u_xlat5.x;
					    u_xlat5.xyz = vs_TEXCOORD1.xyz * (-u_xlat5.xxx) + (-u_xlat0.xyz);
					    u_xlat2.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat1 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat13 = u_xlat1.w + -1.0;
					    u_xlat13 = unity_SpecCube0_HDR.w * u_xlat13 + 1.0;
					    u_xlat13 = u_xlat13 * unity_SpecCube0_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13);
					    u_xlat13 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD1.xyz;
					    u_xlat13 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat14 = u_xlat13 + u_xlat13;
					    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat14)) + u_xlat0.xyz;
					    u_xlat14 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat13 = u_xlat13;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.y = (-u_xlat13) + 1.0;
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 3.53466082;
					    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
					    u_xlat4 = u_xlat0.y * -2.98023224e-08 + 0.220916301;
					    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat12) * _Color.xyz + u_xlat0.xyz;
					    u_xlat12 = vs_TEXCOORD4;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_4_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_4_2[4];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					float u_xlat14;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat12 = roundEven(vs_COLOR0.x);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat12 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = u_xlat1.y * u_xlat2.x;
					    u_xlat12 = u_xlat12 * vs_COLOR0.z;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Gamma;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Brightness;
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat5.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat5.x, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat5.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat5.x = u_xlat5.x + u_xlat5.x;
					    u_xlat5.xyz = vs_TEXCOORD1.xyz * (-u_xlat5.xxx) + (-u_xlat0.xyz);
					    u_xlat2.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat1 = textureLod(unity_SpecCube0, u_xlat5.xyz, 6.0);
					    u_xlat13 = u_xlat1.w + -1.0;
					    u_xlat13 = unity_SpecCube0_HDR.w * u_xlat13 + 1.0;
					    u_xlat13 = u_xlat13 * unity_SpecCube0_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat13);
					    u_xlat13 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat3.xyz = vec3(u_xlat13) * vs_TEXCOORD1.xyz;
					    u_xlat13 = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat14 = u_xlat13 + u_xlat13;
					    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat14)) + u_xlat0.xyz;
					    u_xlat14 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat13 = u_xlat13;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.y = (-u_xlat13) + 1.0;
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat0.z = 1.0;
					    u_xlat3 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat3.x * 3.53466082;
					    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
					    u_xlat4 = u_xlat0.y * -2.98023224e-08 + 0.220916301;
					    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat12) * _Color.xyz + u_xlat0.xyz;
					    u_xlat12 = vs_TEXCOORD4;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_4_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_4_2[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat12)) + (-u_xlat0.xyz);
					    u_xlat1 = textureLod(unity_SpecCube0, u_xlat1.xyz, 6.0);
					    u_xlat12 = u_xlat1.w + -1.0;
					    u_xlat12 = unity_SpecCube0_HDR.w * u_xlat12 + 1.0;
					    u_xlat12 = u_xlat12 * unity_SpecCube0_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat13 = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat3.y = (-u_xlat12) + 1.0;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat13)) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat4 = u_xlat0.y * -2.98023224e-08 + 0.220916301;
					    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat0.z = 1.0;
					    u_xlat0 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat0.x * 3.53466082;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = roundEven(vs_COLOR0.x);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat2.x = u_xlat12 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = u_xlat1.y * u_xlat2.x;
					    u_xlat12 = u_xlat12 * vs_COLOR0.z;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Gamma;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Brightness;
					    u_xlat0.xyz = vec3(u_xlat12) * _Color.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD4;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_4_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_4_2[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat12)) + (-u_xlat0.xyz);
					    u_xlat1 = textureLod(unity_SpecCube0, u_xlat1.xyz, 6.0);
					    u_xlat12 = u_xlat1.w + -1.0;
					    u_xlat12 = unity_SpecCube0_HDR.w * u_xlat12 + 1.0;
					    u_xlat12 = u_xlat12 * unity_SpecCube0_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat13 = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat3.y = (-u_xlat12) + 1.0;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat13)) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat3.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat3.zw = u_xlat3.xy * u_xlat3.xy;
					    u_xlat0.xy = u_xlat3.xy * u_xlat3.xw;
					    u_xlat0.xy = u_xlat3.zy * u_xlat0.xy;
					    u_xlat4 = u_xlat0.y * -2.98023224e-08 + 0.220916301;
					    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat0.z = 1.0;
					    u_xlat0 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat0.x = u_xlat0.x * 3.53466082;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = roundEven(vs_COLOR0.x);
					    u_xlat12 = u_xlat12 * 2.0 + -1.0;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat2.x = u_xlat12 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat12 = u_xlat1.y * u_xlat2.x;
					    u_xlat12 = u_xlat12 * vs_COLOR0.z;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Gamma;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Brightness;
					    u_xlat0.xyz = vec3(u_xlat12) * _Color.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD4;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_2_1;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_3_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_3_2[4];
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec2 u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = roundEven(vs_COLOR0.x);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat4.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat4.xy = vs_COLOR0.xy * u_xlat4.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat4.xy * _Time.xx;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.y = 0.0;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.z = 0.0;
					    u_xlat4.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat4.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.y;
					    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Gamma;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Brightness;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
					    u_xlat2 = textureLod(unity_SpecCube0, u_xlat2.xyz, 6.0);
					    u_xlat12 = u_xlat2.w + -1.0;
					    u_xlat12 = unity_SpecCube0_HDR.w * u_xlat12 + 1.0;
					    u_xlat12 = u_xlat12 * unity_SpecCube0_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12);
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat1.x = u_xlat12 * u_xlat12;
					    u_xlat1.x = u_xlat12 * u_xlat1.x;
					    u_xlat12 = u_xlat12 * u_xlat1.x;
					    u_xlat12 = u_xlat12 * -2.98023224e-08 + 0.220916301;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD4;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_6;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_2_1;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_3_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_3_2[4];
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec2 u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = roundEven(vs_COLOR0.x);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat4.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat4.xy = vs_COLOR0.xy * u_xlat4.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat4.xy * _Time.xx;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.y = 0.0;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.z = 0.0;
					    u_xlat4.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat4.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.y;
					    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Gamma;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Brightness;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
					    u_xlat2 = textureLod(unity_SpecCube0, u_xlat2.xyz, 6.0);
					    u_xlat12 = u_xlat2.w + -1.0;
					    u_xlat12 = unity_SpecCube0_HDR.w * u_xlat12 + 1.0;
					    u_xlat12 = u_xlat12 * unity_SpecCube0_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat12);
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat1.x = u_xlat12 * u_xlat12;
					    u_xlat1.x = u_xlat12 * u_xlat1.x;
					    u_xlat12 = u_xlat12 * u_xlat1.x;
					    u_xlat12 = u_xlat12 * -2.98023224e-08 + 0.220916301;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD4;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					bvec3 u_xlatb7;
					vec3 u_xlat8;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat30;
					float u_xlat31;
					float u_xlat33;
					bool u_xlatb33;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat2.xy = vs_COLOR0.xy * u_xlat2.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat2.xy = u_xlat2.xy * _Time.xx;
					    u_xlat31 = roundEven(vs_COLOR0.x);
					    u_xlat31 = u_xlat31 * 2.0 + -1.0;
					    u_xlat3.x = u_xlat31 * u_xlat2.x;
					    u_xlat3.y = 0.0;
					    u_xlat2.xw = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = texture(_MainTex, u_xlat2.xw);
					    u_xlat2.z = 0.0;
					    u_xlat2.xy = u_xlat2.zy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat31 = u_xlat2.y * u_xlat3.x;
					    u_xlat31 = u_xlat31 * vs_COLOR0.z;
					    u_xlat31 = log2(u_xlat31);
					    u_xlat31 = u_xlat31 * _Gamma;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat31 * _Brightness;
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat12.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat3.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat2.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat12.x = u_xlat12.x + u_xlat12.x;
					    u_xlat12.xyz = vs_TEXCOORD1.xyz * (-u_xlat12.xxx) + (-u_xlat1.xyz);
					    u_xlat3.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlatb2 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb2){
					        u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
					        u_xlat2.x = inversesqrt(u_xlat2.x);
					        u_xlat4.xyz = u_xlat2.xxx * u_xlat12.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat4.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat4.xyz;
					        u_xlatb7.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat5;
					            hlslcc_movcTemp.x = (u_xlatb7.x) ? u_xlat5.x : u_xlat6.x;
					            hlslcc_movcTemp.y = (u_xlatb7.y) ? u_xlat5.y : u_xlat6.y;
					            hlslcc_movcTemp.z = (u_xlatb7.z) ? u_xlat5.z : u_xlat6.z;
					            u_xlat5 = hlslcc_movcTemp;
					        }
					        u_xlat2.x = min(u_xlat5.y, u_xlat5.x);
					        u_xlat2.x = min(u_xlat5.z, u_xlat2.x);
					        u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx + u_xlat5.xyz;
					    } else {
					        u_xlat4.xyz = u_xlat12.xyz;
					    }
					    u_xlat4 = textureLod(unity_SpecCube0, u_xlat4.xyz, 6.0);
					    u_xlat2.x = u_xlat4.w + -1.0;
					    u_xlat2.x = unity_SpecCube0_HDR.w * u_xlat2.x + 1.0;
					    u_xlat2.x = u_xlat2.x * unity_SpecCube0_HDR.x;
					    u_xlat5.xyz = u_xlat4.xyz * u_xlat2.xxx;
					    u_xlatb33 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb33){
					        u_xlatb33 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb33){
					            u_xlat33 = dot(u_xlat12.xyz, u_xlat12.xyz);
					            u_xlat33 = inversesqrt(u_xlat33);
					            u_xlat6.xyz = u_xlat12.xyz * vec3(u_xlat33);
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					            u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat7;
					                hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					                hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					                hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					                u_xlat7 = hlslcc_movcTemp;
					            }
					            u_xlat33 = min(u_xlat7.y, u_xlat7.x);
					            u_xlat33 = min(u_xlat7.z, u_xlat33);
					            u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat12.xyz = u_xlat6.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        }
					        u_xlat6 = textureLod(unity_SpecCube1, u_xlat12.xyz, 6.0);
					        u_xlat12.x = u_xlat6.w + -1.0;
					        u_xlat12.x = unity_SpecCube1_HDR.w * u_xlat12.x + 1.0;
					        u_xlat12.x = u_xlat12.x * unity_SpecCube1_HDR.x;
					        u_xlat12.xyz = u_xlat6.xyz * u_xlat12.xxx;
					        u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz + (-u_xlat12.xyz);
					        u_xlat5.xyz = unity_SpecCube0_BoxMin.www * u_xlat4.xyz + u_xlat12.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = abs(u_xlat30) + u_xlat1.x;
					    u_xlat10.x = u_xlat10.x + 9.99999975e-06;
					    u_xlat10.x = 0.5 / u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * 0.999999881;
					    u_xlat10.x = max(u_xlat10.x, 9.99999975e-05);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat1.x * u_xlat10.x;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat10.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = u_xlat10.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * u_xlat10.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat2.xyz = u_xlat5.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat10.x = -abs(u_xlat30) + 1.0;
					    u_xlat20 = u_xlat10.x * u_xlat10.x;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat10.x = u_xlat10.x * -2.98023224e-08 + 0.220916301;
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat31) * _Color.xyz + u_xlat0.xyz;
					    u_xlat30 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat30 = u_xlat30 * _ProjectionParams.z;
					    u_xlat30 = max(u_xlat30, 0.0);
					    u_xlat30 = u_xlat30 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat2.xy = vs_COLOR0.xy * u_xlat2.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat2.xy = u_xlat2.xy * _Time.xx;
					    u_xlat28 = roundEven(vs_COLOR0.x);
					    u_xlat28 = u_xlat28 * 2.0 + -1.0;
					    u_xlat3.x = u_xlat28 * u_xlat2.x;
					    u_xlat3.y = 0.0;
					    u_xlat2.xw = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = texture(_MainTex, u_xlat2.xw);
					    u_xlat2.z = 0.0;
					    u_xlat2.xy = u_xlat2.zy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat28 = u_xlat2.y * u_xlat3.x;
					    u_xlat28 = u_xlat28 * vs_COLOR0.z;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Gamma;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Brightness;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlatb29 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb29){
					        u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat29 = inversesqrt(u_xlat29);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat29 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat29 = min(u_xlat4.z, u_xlat29);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat29) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat2.x = u_xlat5.w + -1.0;
					        u_xlat2.x = unity_SpecCube1_HDR.w * u_xlat2.x + 1.0;
					        u_xlat2.x = u_xlat2.x * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat5.xyz * u_xlat2.xxx;
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = abs(u_xlat27) + u_xlat1.x;
					    u_xlat9.x = u_xlat9.x + 9.99999975e-06;
					    u_xlat9.x = 0.5 / u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * 0.999999881;
					    u_xlat9.x = max(u_xlat9.x, 9.99999975e-05);
					    u_xlat9.x = sqrt(u_xlat9.x);
					    u_xlat9.x = u_xlat1.x * u_xlat9.x;
					    u_xlat1.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat9.x = -abs(u_xlat27) + 1.0;
					    u_xlat18 = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat9.x = u_xlat9.x * -2.98023224e-08 + 0.220916301;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    u_xlat0.xyz = vec3(u_xlat28) * _Color.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat2.xy = vs_COLOR0.xy * u_xlat2.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat2.xy = u_xlat2.xy * _Time.xx;
					    u_xlat28 = roundEven(vs_COLOR0.x);
					    u_xlat28 = u_xlat28 * 2.0 + -1.0;
					    u_xlat3.x = u_xlat28 * u_xlat2.x;
					    u_xlat3.y = 0.0;
					    u_xlat2.xw = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = texture(_MainTex, u_xlat2.xw);
					    u_xlat2.z = 0.0;
					    u_xlat2.xy = u_xlat2.zy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat28 = u_xlat2.y * u_xlat3.x;
					    u_xlat28 = u_xlat28 * vs_COLOR0.z;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Gamma;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Brightness;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlatb29 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb29){
					        u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat29 = inversesqrt(u_xlat29);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat29 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat29 = min(u_xlat4.z, u_xlat29);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat29) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat2.x = u_xlat5.w + -1.0;
					        u_xlat2.x = unity_SpecCube1_HDR.w * u_xlat2.x + 1.0;
					        u_xlat2.x = u_xlat2.x * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat5.xyz * u_xlat2.xxx;
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = abs(u_xlat27) + u_xlat1.x;
					    u_xlat9.x = u_xlat9.x + 9.99999975e-06;
					    u_xlat9.x = 0.5 / u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * 0.999999881;
					    u_xlat9.x = max(u_xlat9.x, 9.99999975e-05);
					    u_xlat9.x = sqrt(u_xlat9.x);
					    u_xlat9.x = u_xlat1.x * u_xlat9.x;
					    u_xlat1.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat9.x = -abs(u_xlat27) + 1.0;
					    u_xlat18 = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat9.x = u_xlat9.x * -2.98023224e-08 + 0.220916301;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    u_xlat0.xyz = vec3(u_xlat28) * _Color.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_2;
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_8;
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
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					bool u_xlatb30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat2.xy = vs_COLOR0.xy * u_xlat2.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat2.xy = u_xlat2.xy * _Time.xx;
					    u_xlat28 = roundEven(vs_COLOR0.x);
					    u_xlat28 = u_xlat28 * 2.0 + -1.0;
					    u_xlat3.x = u_xlat28 * u_xlat2.x;
					    u_xlat3.y = 0.0;
					    u_xlat2.xw = u_xlat3.xy + vs_TEXCOORD0.xy;
					    u_xlat3 = texture(_MainTex, u_xlat2.xw);
					    u_xlat2.z = 0.0;
					    u_xlat2.xy = u_xlat2.zy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat28 = u_xlat2.y * u_xlat3.x;
					    u_xlat28 = u_xlat28 * vs_COLOR0.z;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Gamma;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat28 * _Brightness;
					    u_xlat2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-u_xlat2.xxx) + (-u_xlat1.xyz);
					    u_xlatb29 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb29){
					        u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat29 = inversesqrt(u_xlat29);
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat29 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat29 = min(u_xlat4.z, u_xlat29);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat29) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat29 = u_xlat3.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat29 + 1.0;
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat29);
					    u_xlatb30 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb30){
					        u_xlatb30 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb30){
					            u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat30 = inversesqrt(u_xlat30);
					            u_xlat5.xyz = u_xlat2.xyz * vec3(u_xlat30);
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat30 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat30 = min(u_xlat6.z, u_xlat30);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat30) + u_xlat6.xyz;
					        }
					        u_xlat5 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat2.x = u_xlat5.w + -1.0;
					        u_xlat2.x = unity_SpecCube1_HDR.w * u_xlat2.x + 1.0;
					        u_xlat2.x = u_xlat2.x * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat5.xyz * u_xlat2.xxx;
					        u_xlat3.xyz = vec3(u_xlat29) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = abs(u_xlat27) + u_xlat1.x;
					    u_xlat9.x = u_xlat9.x + 9.99999975e-06;
					    u_xlat9.x = 0.5 / u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * 0.999999881;
					    u_xlat9.x = max(u_xlat9.x, 9.99999975e-05);
					    u_xlat9.x = sqrt(u_xlat9.x);
					    u_xlat9.x = u_xlat1.x * u_xlat9.x;
					    u_xlat1.xyz = u_xlat9.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = u_xlat9.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * u_xlat9.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat9.x = -abs(u_xlat27) + 1.0;
					    u_xlat18 = u_xlat9.x * u_xlat9.x;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat9.x = u_xlat9.x * -2.98023224e-08 + 0.220916301;
					    u_xlat9.xyz = u_xlat9.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    u_xlat0.xyz = vec3(u_xlat28) * _Color.xyz + u_xlat0.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_6;
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat27 = roundEven(vs_COLOR0.x);
					    u_xlat27 = u_xlat27 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat27 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat27 = u_xlat1.y * u_xlat2.x;
					    u_xlat27 = u_xlat27 * vs_COLOR0.z;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Gamma;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Brightness;
					    u_xlat1.xyz = vec3(u_xlat27) * _Color.xyz;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * -2.98023224e-08 + 0.220916301;
					    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_6;
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat27 = roundEven(vs_COLOR0.x);
					    u_xlat27 = u_xlat27 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat27 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat27 = u_xlat1.y * u_xlat2.x;
					    u_xlat27 = u_xlat27 * vs_COLOR0.z;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Gamma;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Brightness;
					    u_xlat1.xyz = vec3(u_xlat27) * _Color.xyz;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * -2.98023224e-08 + 0.220916301;
					    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.220916271;
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
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						vec4 unused_0_6;
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
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					bvec3 u_xlatb6;
					vec3 u_xlat7;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					bool u_xlatb28;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat1.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat1.xy = vs_COLOR0.xy * u_xlat1.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat1.xy * _Time.xx;
					    u_xlat27 = roundEven(vs_COLOR0.x);
					    u_xlat27 = u_xlat27 * 2.0 + -1.0;
					    u_xlat2.x = u_xlat27 * u_xlat1.x;
					    u_xlat2.y = 0.0;
					    u_xlat1.xw = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat2 = texture(_MainTex, u_xlat1.xw);
					    u_xlat1.z = 0.0;
					    u_xlat1.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat27 = u_xlat1.y * u_xlat2.x;
					    u_xlat27 = u_xlat27 * vs_COLOR0.z;
					    u_xlat27 = log2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Gamma;
					    u_xlat27 = exp2(u_xlat27);
					    u_xlat27 = u_xlat27 * _Brightness;
					    u_xlat1.xyz = vec3(u_xlat27) * _Color.xyz;
					    u_xlat27 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat27 = u_xlat27 + u_xlat27;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat27)) + (-u_xlat0.xyz);
					    u_xlatb27 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb27){
					        u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat27 = inversesqrt(u_xlat27);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
					        u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat4.xyz = u_xlat4.xyz / u_xlat3.xyz;
					        u_xlat5.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat5.xyz = u_xlat5.xyz / u_xlat3.xyz;
					        u_xlatb6.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat3.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat4;
					            hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat4.x : u_xlat5.x;
					            hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat4.y : u_xlat5.y;
					            hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat4.z : u_xlat5.z;
					            u_xlat4 = hlslcc_movcTemp;
					        }
					        u_xlat27 = min(u_xlat4.y, u_xlat4.x);
					        u_xlat27 = min(u_xlat4.z, u_xlat27);
					        u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat4.xyz;
					    } else {
					        u_xlat3.xyz = u_xlat2.xyz;
					    }
					    u_xlat3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 6.0);
					    u_xlat27 = u_xlat3.w + -1.0;
					    u_xlat27 = unity_SpecCube0_HDR.w * u_xlat27 + 1.0;
					    u_xlat27 = u_xlat27 * unity_SpecCube0_HDR.x;
					    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27);
					    u_xlatb28 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb28){
					        u_xlatb28 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb28){
					            u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					            u_xlat28 = inversesqrt(u_xlat28);
					            u_xlat5.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					            u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					            u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					            u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat6;
					                hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					                hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					                hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					                u_xlat6 = hlslcc_movcTemp;
					            }
					            u_xlat28 = min(u_xlat6.y, u_xlat6.x);
					            u_xlat28 = min(u_xlat6.z, u_xlat28);
					            u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat28) + u_xlat6.xyz;
					        }
					        u_xlat2 = textureLod(unity_SpecCube1, u_xlat2.xyz, 6.0);
					        u_xlat28 = u_xlat2.w + -1.0;
					        u_xlat28 = unity_SpecCube1_HDR.w * u_xlat28 + 1.0;
					        u_xlat28 = u_xlat28 * unity_SpecCube1_HDR.x;
					        u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28);
					        u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + (-u_xlat2.xyz);
					        u_xlat4.xyz = unity_SpecCube0_BoxMin.www * u_xlat3.xyz + u_xlat2.xyz;
					    }
					    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9.xyz = u_xlat4.xyz * vec3(0.720000029, 0.720000029, 0.720000029);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * -2.98023224e-08 + 0.220916301;
					    u_xlat0.xyz = u_xlat9.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat27 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat27 = (-u_xlat27) + 1.0;
					    u_xlat27 = u_xlat27 * _ProjectionParams.z;
					    u_xlat27 = max(u_xlat27, 0.0);
					    u_xlat27 = u_xlat27 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 0.220916271;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 116855
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD2;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD2 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD2;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD2 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD2;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD2 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD2;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD2 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					out vec3 vs_TEXCOORD0;
					out float vs_TEXCOORD2;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD2 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, vec2(u_xlat13));
					    u_xlat12 = u_xlat12 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 3.53466082;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat0.xxx;
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
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb9)) ? u_xlat1.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat4 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat9, u_xlat4);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat9) * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = u_xlat9 + u_xlat9;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 3.53466082;
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat0.xxx;
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat2 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlatb13 = 0.0<u_xlat2.z;
					    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
					    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat13 = u_xlat13 * u_xlat3.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 3.53466082;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat0.xxx;
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat13));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat13 = u_xlat2.w * u_xlat3.x;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 3.53466082;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat0.xxx;
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9, u_xlat7);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat9 = u_xlat9 * u_xlat1.w;
					    u_xlat1.xyz = vec3(u_xlat9) * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = u_xlat9 + u_xlat9;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 3.53466082;
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat0.xxx;
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, vec2(u_xlat13));
					    u_xlat12 = u_xlat12 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 3.53466082;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat12 = vs_TEXCOORD2;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
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
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb9)) ? u_xlat1.xyz : vs_TEXCOORD1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat4 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat9, u_xlat4);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat9) * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = u_xlat9 + u_xlat9;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 3.53466082;
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat9 = vs_TEXCOORD2;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat2 = vs_TEXCOORD1.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD1.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD1.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlatb13 = 0.0<u_xlat2.z;
					    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
					    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat13 = u_xlat13 * u_xlat3.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 3.53466082;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat12 = vs_TEXCOORD2;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD1.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat13));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat13 = u_xlat2.w * u_xlat3.x;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat12 = u_xlat12 + u_xlat12;
					    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat12)) + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat1.x * 3.53466082;
					    u_xlat4.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx;
					    u_xlat12 = vs_TEXCOORD2;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat12);
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 unused_0_4[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec3 vs_TEXCOORD0;
					in  float vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xy = vs_TEXCOORD1.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD1.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD1.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD1.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : vs_TEXCOORD1.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9, u_xlat7);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat9 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat9 = u_xlat9 * u_xlat1.w;
					    u_xlat1.xyz = vec3(u_xlat9) * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = u_xlat9 + u_xlat9;
					    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat9)) + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 1.0;
					    u_xlat2 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat0.x = u_xlat2.x * 3.53466082;
					    u_xlat3.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xxx;
					    u_xlat9 = vs_TEXCOORD2;
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat9);
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "META"
			Tags { "LIGHTMODE" = "META" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 191910
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 unused_0_0[8];
						vec4 _MainTex_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unity_DynamicLightmapST;
					};
					layout(std140) uniform UnityMetaPass {
						bvec4 unity_MetaVertexControl;
						vec4 unused_4_1[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb6;
					void main()
					{
					    u_xlatb0 = 0.0<in_POSITION0.z;
					    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
					    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
					    u_xlatb6 = 0.0<u_xlat0.z;
					    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
					    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec3 _Color;
						vec2 _FlowU;
						vec2 _FlowV;
						float _Brightness;
						float _Gamma;
						float unity_MaxOutputValue;
						float unity_UseLinearSpace;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityMetaPass {
						vec4 unused_2_0;
						bvec4 unity_MetaFragmentControl;
						vec4 unused_2_2;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.x = roundEven(vs_COLOR0.x);
					    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
					    u_xlat2.xy = (-vec2(_FlowU.x, _FlowV.x)) + vec2(_FlowU.y, _FlowV.y);
					    u_xlat2.xy = vs_COLOR0.xy * u_xlat2.xy + vec2(_FlowU.x, _FlowV.x);
					    u_xlat1.xy = u_xlat2.xy * _Time.xx;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.y = 0.0;
					    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.z = 0.0;
					    u_xlat2.xy = u_xlat1.zy + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_MainTex, u_xlat2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.y;
					    u_xlat0.x = u_xlat0.x * vs_COLOR0.z;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Gamma;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Brightness;
					    u_xlat0.xyz = u_xlat0.xxx * _Color.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
					    u_xlat0.xyz = (bool(u_xlatb6)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat1.xyz = min(vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)), vec3(0.0, 0.0, 0.0));
					    u_xlat1.w = 1.0;
					    u_xlat1 = (unity_MetaFragmentControl.x) ? u_xlat1 : vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.w = 1.0;
					    SV_Target0 = (unity_MetaFragmentControl.y) ? u_xlat0 : u_xlat1;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Transparent/Diffuse"
}