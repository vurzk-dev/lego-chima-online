Shader "Custom/TextureScroller" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_TexOne ("Texture One (RGB)", 2D) = "white" {}
		_TexTwo ("Texture Two (RGB)", 2D) = "white" {}
		_AlphaTexOne ("Alpha One (A)", 2D) = "white" {}
		_AlphaTexTwo ("Alpha Two(A)", 2D) = "white" {}
		_AlphaTexThree ("Alpha Two(A)", 2D) = "white" {}
		_Brightness ("Brightness", Range(0, 5)) = 1
		_AlphaWeakness ("Alpha Weakness", Range(0, 10)) = 1
		_ScrollSpeed1X ("Scroll Speed Texture One X", Range(-50, 50)) = 0
		_ScrollSpeed1Y ("Scroll Speed Texture One Y", Range(-50, 50)) = 0
		_ScrollSpeed2X ("Scroll Speed Texture Two X", Range(-50, 50)) = 0
		_ScrollSpeed2Y ("Scroll Speed Texture Two Y", Range(-50, 50)) = 0
		_ScrollSpeedAlpha1X ("Scroll Speed Alpha One X", Range(-50, 50)) = 0
		_ScrollSpeedAlpha1Y ("Scroll Speed Alpha One Y", Range(-50, 50)) = 0
		_ScrollSpeedAlpha2X ("Scroll Speed Alpha Two X", Range(-50, 50)) = 0
		_ScrollSpeedAlpha2Y ("Scroll Speed Alpha Two Y", Range(-50, 50)) = 0
		_RotationSpeed1 ("Rotation Speed Texture 1", Float) = 0
		_RotationCenter1 ("Rotation Center Texture 1", Range(0, 1)) = 0.5
		_RotationSpeed2 ("Rotation Speed Texture 2", Float) = 0
		_RotationCenter2 ("Rotation Center Texture 2", Range(0, 1)) = 0.5
		_Speed ("Wave Speed", Range(-200, 200)) = 5
		_Freq ("Frequency", Range(0, 100)) = 2
		_Amp ("Amplitude", Range(-1, 1)) = 1
	}
	SubShader {
		LOD 200
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 62661
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat4 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat4) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
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
					    vs_TEXCOORD5.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unused_4_0;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD2;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD7.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD7.xy = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat6 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat6) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
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
					    vs_TEXCOORD5.xyz = u_xlat2.xyz + u_xlat0.xyz;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unused_4_0;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD2;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD7.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD7.xy = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD6 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat4 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat4) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD6 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
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
					    vs_TEXCOORD5.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD6 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD6 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD6 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD6 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unused_4_0;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD2;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD6 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD7.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD7.xy = vec2(0.0, 0.0);
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD6 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD6 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD6 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD6 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD6 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					out vec3 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD6 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD7.z = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD7.y = u_xlat2.x;
					    vs_TEXCOORD7.x = u_xlat1.z;
					    vs_TEXCOORD8.z = u_xlat0.y;
					    vs_TEXCOORD9.z = u_xlat0.z;
					    vs_TEXCOORD8.x = u_xlat1.x;
					    vs_TEXCOORD9.x = u_xlat1.y;
					    vs_TEXCOORD8.y = u_xlat2.y;
					    vs_TEXCOORD9.y = u_xlat2.z;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					float u_xlat18;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat6 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat6) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    u_xlat18 = u_xlat2.z / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    vs_TEXCOORD6 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
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
					    vs_TEXCOORD5.xyz = u_xlat2.xyz + u_xlat0.xyz;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					layout(std140) uniform UnityLightmaps {
						vec4 unused_4_0;
						vec4 unity_DynamicLightmapST;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD2;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD6 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD7.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    vs_TEXCOORD7.xy = vec2(0.0, 0.0);
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_18[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat15, u_xlat6);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_18[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat15, u_xlat6);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat1 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat18 = u_xlat1.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat1.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD3.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1 = vs_TEXCOORD3.yzzx * vs_TEXCOORD3.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat15 = vs_TEXCOORD3.y * vs_TEXCOORD3.y;
					    u_xlat15 = vs_TEXCOORD3.x * vs_TEXCOORD3.x + (-u_xlat15);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat15 = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(u_xlat15) + u_xlat0.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_17[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat1 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat18 = u_xlat1.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_17[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD3.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1 = vs_TEXCOORD3.yzzx * vs_TEXCOORD3.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat15 = vs_TEXCOORD3.y * vs_TEXCOORD3.y;
					    u_xlat15 = vs_TEXCOORD3.x * vs_TEXCOORD3.x + (-u_xlat15);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat15 = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
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
						vec4 unused_0_0;
						vec4 unity_DynamicLightmap_HDR;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_DynamicLightmap;
					uniform  sampler2D unity_DynamicDirectionality;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD7;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat15, u_xlat6);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat2 = texture(unity_DynamicLightmap, vs_TEXCOORD7.zw);
					    u_xlat15 = u_xlat2.w * unity_DynamicLightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat15);
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * unity_DynamicLightmap_HDR.yyy;
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat3 = texture(unity_DynamicDirectionality, vs_TEXCOORD7.zw);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + 0.5;
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    u_xlat15 = max(u_xlat3.w, 9.99999975e-05);
					    u_xlat2.xyz = u_xlat2.xyz / vec3(u_xlat15);
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat1 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat18 = u_xlat1.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
					    u_xlat2 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat2.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = max(u_xlat2.w, 9.99999975e-05);
					    u_xlat19 = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat19 = u_xlat19 + 0.5;
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat18);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat1.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD3.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1 = vs_TEXCOORD3.yzzx * vs_TEXCOORD3.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat15 = vs_TEXCOORD3.y * vs_TEXCOORD3.y;
					    u_xlat15 = vs_TEXCOORD3.x * vs_TEXCOORD3.x + (-u_xlat15);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat15 = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat15);
					    u_xlat3 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + 0.5;
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    u_xlat15 = max(u_xlat3.w, 9.99999975e-05);
					    u_xlat2.xyz = u_xlat2.xyz / vec3(u_xlat15);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(u_xlat15) + u_xlat0.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unity_DynamicLightmap_HDR;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_DynamicLightmap;
					uniform  sampler2D unity_DynamicDirectionality;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					vec3 u_xlat8;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = texture(unity_DynamicLightmap, vs_TEXCOORD5.zw);
					    u_xlat21 = u_xlat0.w * unity_DynamicLightmap_HDR.x;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * unity_DynamicLightmap_HDR.yyy;
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat1 = texture(unity_DynamicDirectionality, vs_TEXCOORD5.zw);
					    u_xlat1.xyz = u_xlat1.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat21 = max(u_xlat1.w, 9.99999975e-05);
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat21);
					    u_xlat1 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat21 = u_xlat1.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21);
					    u_xlat2 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat2.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat21 = max(u_xlat2.w, 9.99999975e-05);
					    u_xlat22 = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat22 = u_xlat22 + 0.5;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat21);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat2.x = sin(u_xlat1.y);
					    u_xlat3.x = cos(u_xlat1.y);
					    u_xlat3.y = u_xlat2.x;
					    u_xlat2 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat4.x = dot(u_xlat2.zw, u_xlat3.xy);
					    u_xlat5.xy = sin((-u_xlat1.xy));
					    u_xlat6 = cos(u_xlat1.x);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat3.z = u_xlat5.y;
					    u_xlat4.y = dot(u_xlat2.wz, u_xlat3.xz);
					    u_xlat8.xy = u_xlat4.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat8.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat8.xy;
					    u_xlat3 = texture(_TexTwo, u_xlat8.xy);
					    u_xlat8.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat3.xyz = u_xlat8.xyz * u_xlat3.xyz;
					    u_xlat5.w = u_xlat1.x;
					    u_xlat5.z = u_xlat6;
					    u_xlat4.x = dot(u_xlat2.xy, u_xlat5.zw);
					    u_xlat4.y = dot(u_xlat2.xy, u_xlat5.xz);
					    u_xlat2.xy = u_xlat4.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat2.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat2.xy;
					    u_xlat2 = texture(_TexOne, u_xlat2.xy);
					    u_xlat1.xyz = u_xlat8.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
					    u_xlat21 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_17[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat1 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat18 = u_xlat1.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
					    u_xlat2 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat2.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = max(u_xlat2.w, 9.99999975e-05);
					    u_xlat19 = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat19 = u_xlat19 + 0.5;
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat18);
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_17[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD3.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1 = vs_TEXCOORD3.yzzx * vs_TEXCOORD3.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat15 = vs_TEXCOORD3.y * vs_TEXCOORD3.y;
					    u_xlat15 = vs_TEXCOORD3.x * vs_TEXCOORD3.x + (-u_xlat15);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat15 = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat15);
					    u_xlat3 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + 0.5;
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    u_xlat15 = max(u_xlat3.w, 9.99999975e-05);
					    u_xlat2.xyz = u_xlat2.xyz / vec3(u_xlat15);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unity_DynamicLightmap_HDR;
						vec4 unused_0_2[2];
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_18[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_DynamicLightmap;
					uniform  sampler2D unity_DynamicDirectionality;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat1 = texture(unity_DynamicLightmap, vs_TEXCOORD5.zw);
					    u_xlat18 = u_xlat1.w * unity_DynamicLightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * unity_DynamicLightmap_HDR.yyy;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat2 = texture(unity_DynamicDirectionality, vs_TEXCOORD5.zw);
					    u_xlat2.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = max(u_xlat2.w, 9.99999975e-05);
					    u_xlat19 = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat19 = u_xlat19 + 0.5;
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat18);
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat18 = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat18);
					    u_xlat3 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = max(u_xlat3.w, 9.99999975e-05);
					    u_xlat19 = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat19 = u_xlat19 + 0.5;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz / vec3(u_xlat18);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_18[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat15, u_xlat6);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD6;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + (-unity_FogColor.xyz);
					    SV_Target0.xyz = u_xlat1.xxx * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_18[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat15, u_xlat6);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD6;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat1 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat18 = u_xlat1.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat18 = vs_TEXCOORD6;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD3.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1 = vs_TEXCOORD3.yzzx * vs_TEXCOORD3.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat15 = vs_TEXCOORD3.y * vs_TEXCOORD3.y;
					    u_xlat15 = vs_TEXCOORD3.x * vs_TEXCOORD3.x + (-u_xlat15);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat15 = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD6;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_17[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_2_1;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat1 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat18 = u_xlat1.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat18 = vs_TEXCOORD6;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_17[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD3.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1 = vs_TEXCOORD3.yzzx * vs_TEXCOORD3.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat15 = vs_TEXCOORD3.y * vs_TEXCOORD3.y;
					    u_xlat15 = vs_TEXCOORD3.x * vs_TEXCOORD3.x + (-u_xlat15);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat15 = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat15 = vs_TEXCOORD6;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 unused_0_0;
						vec4 unity_DynamicLightmap_HDR;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_DynamicLightmap;
					uniform  sampler2D unity_DynamicDirectionality;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD7;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat15, u_xlat6);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat2 = texture(unity_DynamicLightmap, vs_TEXCOORD7.zw);
					    u_xlat15 = u_xlat2.w * unity_DynamicLightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat15);
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * unity_DynamicLightmap_HDR.yyy;
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat3 = texture(unity_DynamicDirectionality, vs_TEXCOORD7.zw);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + 0.5;
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    u_xlat15 = max(u_xlat3.w, 9.99999975e-05);
					    u_xlat2.xyz = u_xlat2.xyz / vec3(u_xlat15);
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD6 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat1 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat18 = u_xlat1.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
					    u_xlat2 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat2.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = max(u_xlat2.w, 9.99999975e-05);
					    u_xlat19 = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat19 = u_xlat19 + 0.5;
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat18);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat18 = vs_TEXCOORD6 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD3.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1 = vs_TEXCOORD3.yzzx * vs_TEXCOORD3.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat15 = vs_TEXCOORD3.y * vs_TEXCOORD3.y;
					    u_xlat15 = vs_TEXCOORD3.x * vs_TEXCOORD3.x + (-u_xlat15);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat15 = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat15);
					    u_xlat3 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + 0.5;
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    u_xlat15 = max(u_xlat3.w, 9.99999975e-05);
					    u_xlat2.xyz = u_xlat2.xyz / vec3(u_xlat15);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat2.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD6 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unity_DynamicLightmap_HDR;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_DynamicLightmap;
					uniform  sampler2D unity_DynamicDirectionality;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					vec3 u_xlat8;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0 = texture(unity_DynamicLightmap, vs_TEXCOORD5.zw);
					    u_xlat21 = u_xlat0.w * unity_DynamicLightmap_HDR.x;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * unity_DynamicLightmap_HDR.yyy;
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat1 = texture(unity_DynamicDirectionality, vs_TEXCOORD5.zw);
					    u_xlat1.xyz = u_xlat1.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat21 = max(u_xlat1.w, 9.99999975e-05);
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat21);
					    u_xlat1 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat21 = u_xlat1.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21);
					    u_xlat2 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat2.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat21 = max(u_xlat2.w, 9.99999975e-05);
					    u_xlat22 = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat22 = u_xlat22 + 0.5;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat21);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat2.x = sin(u_xlat1.y);
					    u_xlat3.x = cos(u_xlat1.y);
					    u_xlat3.y = u_xlat2.x;
					    u_xlat2 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat4.x = dot(u_xlat2.zw, u_xlat3.xy);
					    u_xlat5.xy = sin((-u_xlat1.xy));
					    u_xlat6 = cos(u_xlat1.x);
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat3.z = u_xlat5.y;
					    u_xlat4.y = dot(u_xlat2.wz, u_xlat3.xz);
					    u_xlat8.xy = u_xlat4.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat8.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat8.xy;
					    u_xlat3 = texture(_TexTwo, u_xlat8.xy);
					    u_xlat8.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat3.xyz = u_xlat8.xyz * u_xlat3.xyz;
					    u_xlat5.w = u_xlat1.x;
					    u_xlat5.z = u_xlat6;
					    u_xlat4.x = dot(u_xlat2.xy, u_xlat5.zw);
					    u_xlat4.y = dot(u_xlat2.xy, u_xlat5.xz);
					    u_xlat2.xy = u_xlat4.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat2.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat2.xy;
					    u_xlat2 = texture(_TexOne, u_xlat2.xy);
					    u_xlat1.xyz = u_xlat8.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
					    u_xlat21 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat21 = vs_TEXCOORD6 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_17[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat1 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat18 = u_xlat1.w * unity_Lightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
					    u_xlat2 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat2.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = max(u_xlat2.w, 9.99999975e-05);
					    u_xlat19 = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat19 = u_xlat19 + 0.5;
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat18);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat18 = vs_TEXCOORD6 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_17[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD3.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD3.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1 = vs_TEXCOORD3.yzzx * vs_TEXCOORD3.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat15 = vs_TEXCOORD3.y * vs_TEXCOORD3.y;
					    u_xlat15 = vs_TEXCOORD3.x * vs_TEXCOORD3.x + (-u_xlat15);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat15 = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat15);
					    u_xlat3 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat15 = u_xlat15 + 0.5;
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
					    u_xlat15 = max(u_xlat3.w, 9.99999975e-05);
					    u_xlat2.xyz = u_xlat2.xyz / vec3(u_xlat15);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat15 = vs_TEXCOORD6 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unity_DynamicLightmap_HDR;
						vec4 unused_0_2[2];
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_18[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_DynamicLightmap;
					uniform  sampler2D unity_DynamicDirectionality;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat1 = texture(unity_DynamicLightmap, vs_TEXCOORD5.zw);
					    u_xlat18 = u_xlat1.w * unity_DynamicLightmap_HDR.x;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat18);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * unity_DynamicLightmap_HDR.yyy;
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat2 = texture(unity_DynamicDirectionality, vs_TEXCOORD5.zw);
					    u_xlat2.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = max(u_xlat2.w, 9.99999975e-05);
					    u_xlat19 = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat19 = u_xlat19 + 0.5;
					    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat18);
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD5.xy);
					    u_xlat18 = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat18);
					    u_xlat3 = texture(unity_LightmapInd, vs_TEXCOORD5.xy);
					    u_xlat3.xyz = u_xlat3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = max(u_xlat3.w, 9.99999975e-05);
					    u_xlat19 = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat19 = u_xlat19 + 0.5;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz / vec3(u_xlat18);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
					    u_xlat18 = vs_TEXCOORD6 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
					    u_xlat0 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat1 = texture(_AlphaTexOne, u_xlat0.xy);
					    u_xlat0 = texture(_AlphaTexTwo, u_xlat0.zw);
					    u_xlat0.x = u_xlat0.w * u_xlat1.w;
					    u_xlat1 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.x = u_xlat0.x * u_xlat1.w;
					    u_xlat0.x = u_xlat0.x * 4.0;
					    SV_Target0.w = u_xlat0.x * _AlphaWeakness;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 77265
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
						vec4 unused_0_0[12];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 unused_0_0[12];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 unused_0_0[12];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 unused_0_0[12];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
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
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 unused_0_0[12];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD5 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 unused_0_0[8];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD5 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 unused_0_0[12];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD5 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 unused_0_0[12];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD5 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 unused_0_0[12];
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
						vec4 _AlphaTexOne_ST;
						vec4 _AlphaTexTwo_ST;
						vec4 _AlphaTexThree_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
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
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0.x = in_POSITION0.x * _Freq;
					    u_xlat0.x = _Time.x * _Speed + u_xlat0.x;
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat3 = u_xlat0.x * _Amp + in_POSITION0.y;
					    u_xlat1.x = u_xlat0.x * _Amp + in_NORMAL0.x;
					    u_xlat0 = vec4(u_xlat3) * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD5 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexOne_ST.xy + _AlphaTexOne_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _AlphaTexTwo_ST.xy + _AlphaTexTwo_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _AlphaTexThree_ST.xy + _AlphaTexThree_ST.zw;
					    u_xlat1.yz = in_NORMAL0.yz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat2.x = sin(u_xlat1.x);
					    u_xlat3.x = cos(u_xlat1.x);
					    u_xlat4.xz = sin((-u_xlat1.xy));
					    u_xlat5 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat4.y = u_xlat3.x;
					    u_xlat4.w = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat2.y = dot(u_xlat5.xy, u_xlat4.xy);
					    u_xlat1.xz = u_xlat2.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat2.x = sin(u_xlat1.y);
					    u_xlat4.x = cos(u_xlat1.y);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.zw, u_xlat4.xy);
					    u_xlat2.y = dot(u_xlat5.wz, u_xlat4.xz);
					    u_xlat7.xz = u_xlat2.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat1.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xz;
					    u_xlat7.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat7.xz;
					    u_xlat2 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat3 = texture(_TexOne, u_xlat1.xz);
					    u_xlat4.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat1 = texture(_TexTwo, u_xlat7.xz);
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xyz;
					    u_xlat4 = texture(_AlphaTexOne, u_xlat2.xy);
					    u_xlat2 = texture(_AlphaTexTwo, u_xlat2.zw);
					    u_xlat5 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
					    u_xlat18 = u_xlat2.w * u_xlat4.w;
					    u_xlat18 = u_xlat5.w * u_xlat18;
					    u_xlat18 = u_xlat18 * 4.0;
					    SV_Target0.w = u_xlat18 * _AlphaWeakness;
					    u_xlat2.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, vec2(u_xlat19));
					    u_xlat18 = u_xlat18 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz;
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
						vec4 unused_0_2;
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_18[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat15, u_xlat6);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat2.x = sin(u_xlat1.x);
					    u_xlat3.x = cos(u_xlat1.x);
					    u_xlat4.xz = sin((-u_xlat1.xy));
					    u_xlat5 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat4.y = u_xlat3.x;
					    u_xlat4.w = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat2.y = dot(u_xlat5.xy, u_xlat4.xy);
					    u_xlat1.xz = u_xlat2.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat2.x = sin(u_xlat1.y);
					    u_xlat4.x = cos(u_xlat1.y);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.zw, u_xlat4.xy);
					    u_xlat2.y = dot(u_xlat5.wz, u_xlat4.xz);
					    u_xlat7.xz = u_xlat2.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat1.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xz;
					    u_xlat7.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat7.xz;
					    u_xlat2 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat3 = texture(_TexOne, u_xlat1.xz);
					    u_xlat4.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat1 = texture(_TexTwo, u_xlat7.xz);
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xyz;
					    u_xlat4 = texture(_AlphaTexOne, u_xlat2.xy);
					    u_xlat2 = texture(_AlphaTexTwo, u_xlat2.zw);
					    u_xlat5 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
					    u_xlat18 = u_xlat2.w * u_xlat4.w;
					    u_xlat18 = u_xlat5.w * u_xlat18;
					    u_xlat18 = u_xlat18 * 4.0;
					    SV_Target0.w = u_xlat18 * _AlphaWeakness;
					    u_xlat2 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlatb19 = 0.0<u_xlat2.z;
					    u_xlat19 = u_xlatb19 ? 1.0 : float(0.0);
					    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat19 = u_xlat19 * u_xlat3.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat19 = u_xlat19 * u_xlat2.x;
					    u_xlat18 = u_xlat18 * u_xlat19;
					    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz;
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat2.x = sin(u_xlat1.x);
					    u_xlat3.x = cos(u_xlat1.x);
					    u_xlat4.xz = sin((-u_xlat1.xy));
					    u_xlat5 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat4.y = u_xlat3.x;
					    u_xlat4.w = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat2.y = dot(u_xlat5.xy, u_xlat4.xy);
					    u_xlat1.xz = u_xlat2.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat2.x = sin(u_xlat1.y);
					    u_xlat4.x = cos(u_xlat1.y);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.zw, u_xlat4.xy);
					    u_xlat2.y = dot(u_xlat5.wz, u_xlat4.xz);
					    u_xlat7.xz = u_xlat2.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat1.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xz;
					    u_xlat7.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat7.xz;
					    u_xlat2 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat3 = texture(_TexOne, u_xlat1.xz);
					    u_xlat4.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat1 = texture(_TexTwo, u_xlat7.xz);
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xyz;
					    u_xlat4 = texture(_AlphaTexOne, u_xlat2.xy);
					    u_xlat2 = texture(_AlphaTexTwo, u_xlat2.zw);
					    u_xlat5 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
					    u_xlat18 = u_xlat2.w * u_xlat4.w;
					    u_xlat18 = u_xlat5.w * u_xlat18;
					    u_xlat18 = u_xlat18 * 4.0;
					    SV_Target0.w = u_xlat18 * _AlphaWeakness;
					    u_xlat2.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat19));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat19 = u_xlat2.w * u_xlat3.x;
					    u_xlat18 = u_xlat18 * u_xlat19;
					    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz;
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat11;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlat1.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vs_TEXCOORD4.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat15, u_xlat11);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat15 = u_xlat15 * u_xlat1.w;
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat2.x = sin(u_xlat1.x);
					    u_xlat3.x = cos(u_xlat1.x);
					    u_xlat4.xz = sin((-u_xlat1.xy));
					    u_xlat5 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat4.y = u_xlat3.x;
					    u_xlat4.w = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat2.y = dot(u_xlat5.xy, u_xlat4.xy);
					    u_xlat1.xz = u_xlat2.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat2.x = sin(u_xlat1.y);
					    u_xlat4.x = cos(u_xlat1.y);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.zw, u_xlat4.xy);
					    u_xlat2.y = dot(u_xlat5.wz, u_xlat4.xz);
					    u_xlat7.xz = u_xlat2.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat1.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xz;
					    u_xlat7.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat7.xz;
					    u_xlat2 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat3 = texture(_TexOne, u_xlat1.xz);
					    u_xlat4.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat1 = texture(_TexTwo, u_xlat7.xz);
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xyz;
					    u_xlat4 = texture(_AlphaTexOne, u_xlat2.xy);
					    u_xlat2 = texture(_AlphaTexTwo, u_xlat2.zw);
					    u_xlat5 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
					    u_xlat18 = u_xlat2.w * u_xlat4.w;
					    u_xlat18 = u_xlat5.w * u_xlat18;
					    u_xlat18 = u_xlat18 * 4.0;
					    SV_Target0.w = u_xlat18 * _AlphaWeakness;
					    u_xlat2.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTexture0, vec2(u_xlat19));
					    u_xlat18 = u_xlat18 * u_xlat2.x;
					    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    u_xlat18 = vs_TEXCOORD5;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_18[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD4.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat15, u_xlat6);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD5;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat2.x = sin(u_xlat1.x);
					    u_xlat3.x = cos(u_xlat1.x);
					    u_xlat4.xz = sin((-u_xlat1.xy));
					    u_xlat5 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat4.y = u_xlat3.x;
					    u_xlat4.w = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat2.y = dot(u_xlat5.xy, u_xlat4.xy);
					    u_xlat1.xz = u_xlat2.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat2.x = sin(u_xlat1.y);
					    u_xlat4.x = cos(u_xlat1.y);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.zw, u_xlat4.xy);
					    u_xlat2.y = dot(u_xlat5.wz, u_xlat4.xz);
					    u_xlat7.xz = u_xlat2.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat1.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xz;
					    u_xlat7.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat7.xz;
					    u_xlat2 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat3 = texture(_TexOne, u_xlat1.xz);
					    u_xlat4.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat1 = texture(_TexTwo, u_xlat7.xz);
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xyz;
					    u_xlat4 = texture(_AlphaTexOne, u_xlat2.xy);
					    u_xlat2 = texture(_AlphaTexTwo, u_xlat2.zw);
					    u_xlat5 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
					    u_xlat18 = u_xlat2.w * u_xlat4.w;
					    u_xlat18 = u_xlat5.w * u_xlat18;
					    u_xlat18 = u_xlat18 * 4.0;
					    SV_Target0.w = u_xlat18 * _AlphaWeakness;
					    u_xlat2 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlatb19 = 0.0<u_xlat2.z;
					    u_xlat19 = u_xlatb19 ? 1.0 : float(0.0);
					    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
					    u_xlat3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat19 = u_xlat19 * u_xlat3.w;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat2.xx);
					    u_xlat19 = u_xlat19 * u_xlat2.x;
					    u_xlat18 = u_xlat18 * u_xlat19;
					    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    u_xlat18 = vs_TEXCOORD5;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat2.x = sin(u_xlat1.x);
					    u_xlat3.x = cos(u_xlat1.x);
					    u_xlat4.xz = sin((-u_xlat1.xy));
					    u_xlat5 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat4.y = u_xlat3.x;
					    u_xlat4.w = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat2.y = dot(u_xlat5.xy, u_xlat4.xy);
					    u_xlat1.xz = u_xlat2.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat2.x = sin(u_xlat1.y);
					    u_xlat4.x = cos(u_xlat1.y);
					    u_xlat4.y = u_xlat2.x;
					    u_xlat2.x = dot(u_xlat5.zw, u_xlat4.xy);
					    u_xlat2.y = dot(u_xlat5.wz, u_xlat4.xz);
					    u_xlat7.xz = u_xlat2.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat1.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xz;
					    u_xlat7.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat7.xz;
					    u_xlat2 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat3 = texture(_TexOne, u_xlat1.xz);
					    u_xlat4.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat1 = texture(_TexTwo, u_xlat7.xz);
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xyz;
					    u_xlat4 = texture(_AlphaTexOne, u_xlat2.xy);
					    u_xlat2 = texture(_AlphaTexTwo, u_xlat2.zw);
					    u_xlat5 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat1.xyz;
					    u_xlat18 = u_xlat2.w * u_xlat4.w;
					    u_xlat18 = u_xlat5.w * u_xlat18;
					    u_xlat18 = u_xlat18 * 4.0;
					    SV_Target0.w = u_xlat18 * _AlphaWeakness;
					    u_xlat2.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD4.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat19));
					    u_xlat2 = texture(_LightTexture0, u_xlat2.xyz);
					    u_xlat19 = u_xlat2.w * u_xlat3.x;
					    u_xlat18 = u_xlat18 * u_xlat19;
					    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    u_xlat18 = vs_TEXCOORD5;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						float _ScrollSpeedAlpha1X;
						float _ScrollSpeedAlpha1Y;
						float _ScrollSpeedAlpha2X;
						float _ScrollSpeedAlpha2Y;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						float _AlphaWeakness;
						vec4 unused_0_19[6];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					uniform  sampler2D _AlphaTexOne;
					uniform  sampler2D _AlphaTexTwo;
					uniform  sampler2D _AlphaTexThree;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat11;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.x);
					    u_xlat2.x = cos(u_xlat0.x);
					    u_xlat3.xz = sin((-u_xlat0.xy));
					    u_xlat4 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.y = u_xlat2.x;
					    u_xlat3.w = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.xy, u_xlat3.yw);
					    u_xlat1.y = dot(u_xlat4.xy, u_xlat3.xy);
					    u_xlat0.xz = u_xlat1.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat3.x = cos(u_xlat0.y);
					    u_xlat3.y = u_xlat1.x;
					    u_xlat1.x = dot(u_xlat4.zw, u_xlat3.xy);
					    u_xlat1.y = dot(u_xlat4.wz, u_xlat3.xz);
					    u_xlat5.xz = u_xlat1.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat0.xz = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat0.xz;
					    u_xlat5.xz = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat5.xz;
					    u_xlat1 = (-vec4(_ScrollSpeedAlpha1X, _ScrollSpeedAlpha1Y, _ScrollSpeedAlpha2X, _ScrollSpeedAlpha2Y)) * _Time.xxxx + vs_TEXCOORD1;
					    u_xlat2 = texture(_TexOne, u_xlat0.xz);
					    u_xlat3.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat0 = texture(_TexTwo, u_xlat5.xz);
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat0.xyz;
					    u_xlat3 = texture(_AlphaTexOne, u_xlat1.xy);
					    u_xlat1 = texture(_AlphaTexTwo, u_xlat1.zw);
					    u_xlat4 = texture(_AlphaTexThree, vs_TEXCOORD2.xy);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.w * u_xlat3.w;
					    u_xlat15 = u_xlat4.w * u_xlat15;
					    u_xlat15 = u_xlat15 * 4.0;
					    SV_Target0.w = u_xlat15 * _AlphaWeakness;
					    u_xlat1.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vs_TEXCOORD4.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat11 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat15, u_xlat11);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlat15 = u_xlat15 * u_xlat1.w;
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat15 = vs_TEXCOORD5;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    return;
					}"
				}
			}
		}
		Pass {
			Name "META"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "META" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 142974
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
						float _Speed;
						float _Freq;
						float _Amp;
						vec4 unused_0_4;
						vec4 _TexOne_ST;
						vec4 _TexTwo_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unity_DynamicLightmapST;
					};
					layout(std140) uniform UnityMetaPass {
						bvec4 unity_MetaVertexControl;
						vec4 unused_5_1[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlatb0 = 0.0<in_POSITION0.z;
					    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
					    u_xlat6 = in_POSITION0.x * _Freq;
					    u_xlat6 = _Time.x * _Speed + u_xlat6;
					    u_xlat6 = sin(u_xlat6);
					    u_xlat1.y = u_xlat6 * _Amp + in_POSITION0.y;
					    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    u_xlat1.xz = in_POSITION0.xz;
					    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
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
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TexOne_ST.xy + _TexOne_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _TexTwo_ST.xy + _TexTwo_ST.zw;
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
						vec4 _Color;
						float _ScrollSpeed1X;
						float _ScrollSpeed1Y;
						float _ScrollSpeed2X;
						float _ScrollSpeed2Y;
						vec4 unused_0_6;
						float _RotationSpeed1;
						float _RotationCenter1;
						float _RotationSpeed2;
						float _RotationCenter2;
						float _Brightness;
						vec4 unused_0_12;
						float unity_OneOverOutputBoost;
						float unity_MaxOutputValue;
						vec4 unused_0_15[2];
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
					uniform  sampler2D _TexOne;
					uniform  sampler2D _TexTwo;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					vec4 u_xlat4;
					float u_xlat5;
					vec3 u_xlat6;
					float u_xlat18;
					void main()
					{
					    u_xlat0.xy = vec2(_RotationSpeed1, _RotationSpeed2) * _Time.xx;
					    u_xlat1.x = sin(u_xlat0.y);
					    u_xlat2.x = cos(u_xlat0.y);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat1 = vs_TEXCOORD0 + (-vec4(_RotationCenter1, _RotationCenter1, _RotationCenter2, _RotationCenter2));
					    u_xlat3.x = dot(u_xlat1.zw, u_xlat2.xy);
					    u_xlat4.xy = sin((-u_xlat0.xy));
					    u_xlat5 = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.z = u_xlat4.y;
					    u_xlat3.y = dot(u_xlat1.wz, u_xlat2.xz);
					    u_xlat6.xy = u_xlat3.xy + vec2(vec2(_RotationCenter2, _RotationCenter2));
					    u_xlat6.xy = (-vec2(_ScrollSpeed2X, _ScrollSpeed2Y)) * _Time.xx + u_xlat6.xy;
					    u_xlat2 = texture(_TexTwo, u_xlat6.xy);
					    u_xlat6.xyz = _Color.xyz * vec3(_Brightness);
					    u_xlat2.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    u_xlat4.w = u_xlat0.x;
					    u_xlat4.z = u_xlat5;
					    u_xlat3.x = dot(u_xlat1.xy, u_xlat4.zw);
					    u_xlat3.y = dot(u_xlat1.xy, u_xlat4.xz);
					    u_xlat1.xy = u_xlat3.xy + vec2(vec2(_RotationCenter1, _RotationCenter1));
					    u_xlat1.xy = (-vec2(_ScrollSpeed1X, _ScrollSpeed1Y)) * _Time.xx + u_xlat1.xy;
					    u_xlat1 = texture(_TexOne, u_xlat1.xy);
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat18 = unused_0_12.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(unity_MaxOutputValue));
					    u_xlat0.w = 1.0;
					    u_xlat0 = (unity_MetaFragmentControl.x) ? u_xlat0 : vec4(0.0, 0.0, 0.0, 0.0);
					    SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat0;
					    return;
					}"
				}
			}
		}
	}
}