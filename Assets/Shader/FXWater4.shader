Shader "FX/Water4" {
	Properties {
		_ReflectionTex ("Internal reflection", 2D) = "white" {}
		_MainTex ("Fallback texture", 2D) = "black" {}
		_ShoreTex ("Shore & Foam texture ", 2D) = "black" {}
		_BumpMap ("Normals ", 2D) = "bump" {}
		_DistortParams ("Distortions (Bump waves, Reflection, Fresnel power, Fresnel bias)", Vector) = (1,1,2,1.15)
		_InvFadeParemeter ("Auto blend parameter (Edge, Shore, Distance scale)", Vector) = (0.15,0.15,0.5,1)
		_AnimationTiling ("Animation Tiling (Displacement)", Vector) = (2.2,2.2,-1.1,-1.1)
		_AnimationDirection ("Animation Direction (displacement)", Vector) = (1,1,1,1)
		_BumpTiling ("Bump Tiling", Vector) = (1,1,-2,3)
		_BumpDirection ("Bump Direction & Speed", Vector) = (1,1,-1,1)
		_FresnelScale ("FresnelScale", Range(0.15, 4)) = 0.75
		_BaseColor ("Base color", Vector) = (0.54,0.95,0.99,0.5)
		_ReflectionColor ("Reflection color", Vector) = (0.54,0.95,0.99,0.5)
		_SpecularColor ("Specular color", Vector) = (0.72,0.72,0.72,1)
		_WorldLightDir ("Specular light direction", Vector) = (0,0.1,-0.5,0)
		_Shininess ("Shininess", Range(2, 500)) = 200
		_Foam ("Foam (intensity, cutoff)", Vector) = (0.1,0.375,0,0)
		_GerstnerIntensity ("Per vertex displacement", Float) = 1
		_GAmplitude ("Wave Amplitude", Vector) = (0.3,0.35,0.25,0.25)
		_GFrequency ("Wave Frequency", Vector) = (1.3,1.35,1.25,1.25)
		_GSteepness ("Wave Steepness", Vector) = (1,1,1,1)
		_GSpeed ("Wave Speed", Vector) = (1.2,1.375,1.1,1.5)
		_GDirectionAB ("Wave Direction", Vector) = (0.3,0.85,0.85,0.25)
		_GDirectionCD ("Wave Direction", Vector) = (0.1,0.9,0.5,0.5)
	}
	SubShader {
		LOD 500
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		GrabPass {
			"_RefractionTex"
		}
		Pass {
			LOD 500
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 30263
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat4.z = dot(u_xlat3, u_xlat5);
					    u_xlat4.x = dot(u_xlat3, u_xlat6);
					    u_xlat4.y = dot(u_xlat1, _GAmplitude);
					    u_xlat1.xyz = u_xlat4.xyz + in_POSITION0.xyz;
					    u_xlat3.xy = u_xlat0.xz + u_xlat4.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    vs_TEXCOORD1.w = u_xlat4.y;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat3.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat3.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat3.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat3.xy);
					    u_xlat2 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat2 = cos(u_xlat2);
					    u_xlat3 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat3.xyxy * _GDirectionAB.ywxz;
					    u_xlat3 = u_xlat3.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat3.xz;
					    u_xlat4.zw = u_xlat3.yw;
					    u_xlat22 = dot(u_xlat2, u_xlat4);
					    u_xlat2.x = dot(u_xlat2, u_xlat5);
					    u_xlat2.x = (-u_xlat2.x);
					    u_xlat2.z = (-u_xlat22);
					    u_xlat2.xz = u_xlat2.xz * vec2(_GerstnerIntensity);
					    u_xlat2.y = 2.0;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat2 = unity_ObjectToWorld[0].xzxz * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out float vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat4.z = dot(u_xlat3, u_xlat5);
					    u_xlat4.x = dot(u_xlat3, u_xlat6);
					    u_xlat4.y = dot(u_xlat1, _GAmplitude);
					    u_xlat1.xyz = u_xlat4.xyz + in_POSITION0.xyz;
					    u_xlat3.xy = u_xlat0.xz + u_xlat4.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    vs_TEXCOORD1.w = u_xlat4.y;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat3.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat3.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat3.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat3.xy);
					    u_xlat2 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat2 = cos(u_xlat2);
					    u_xlat3 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat3.xyxy * _GDirectionAB.ywxz;
					    u_xlat3 = u_xlat3.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat3.xz;
					    u_xlat4.zw = u_xlat3.yw;
					    u_xlat22 = dot(u_xlat2, u_xlat4);
					    u_xlat2.x = dot(u_xlat2, u_xlat5);
					    u_xlat2.x = (-u_xlat2.x);
					    u_xlat2.z = (-u_xlat22);
					    u_xlat2.xz = u_xlat2.xz * vec2(_GerstnerIntensity);
					    u_xlat2.y = 2.0;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat2 = unity_ObjectToWorld[0].xzxz * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat4.z = dot(u_xlat3, u_xlat5);
					    u_xlat4.x = dot(u_xlat3, u_xlat6);
					    u_xlat4.y = dot(u_xlat1, _GAmplitude);
					    u_xlat1.xyz = u_xlat4.xyz + in_POSITION0.xyz;
					    u_xlat3.xy = u_xlat0.xz + u_xlat4.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    vs_TEXCOORD1.w = u_xlat4.y;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat3.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat3.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat3.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat3.xy);
					    u_xlat2 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat2 = cos(u_xlat2);
					    u_xlat3 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat3.xyxy * _GDirectionAB.ywxz;
					    u_xlat3 = u_xlat3.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat3.xz;
					    u_xlat4.zw = u_xlat3.yw;
					    u_xlat22 = dot(u_xlat2, u_xlat4);
					    u_xlat2.x = dot(u_xlat2, u_xlat5);
					    u_xlat2.x = (-u_xlat2.x);
					    u_xlat2.z = (-u_xlat22);
					    u_xlat2.xz = u_xlat2.xz * vec2(_GerstnerIntensity);
					    u_xlat2.y = 2.0;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat2 = unity_ObjectToWorld[0].xzxz * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out float vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat4.z = dot(u_xlat3, u_xlat5);
					    u_xlat4.x = dot(u_xlat3, u_xlat6);
					    u_xlat4.y = dot(u_xlat1, _GAmplitude);
					    u_xlat1.xyz = u_xlat4.xyz + in_POSITION0.xyz;
					    u_xlat3.xy = u_xlat0.xz + u_xlat4.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    vs_TEXCOORD1.w = u_xlat4.y;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat3.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat3.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat3.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat3.xy);
					    u_xlat2 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat2 = cos(u_xlat2);
					    u_xlat3 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat3.xyxy * _GDirectionAB.ywxz;
					    u_xlat3 = u_xlat3.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat3.xz;
					    u_xlat4.zw = u_xlat3.yw;
					    u_xlat22 = dot(u_xlat2, u_xlat4);
					    u_xlat2.x = dot(u_xlat2, u_xlat5);
					    u_xlat2.x = (-u_xlat2.x);
					    u_xlat2.z = (-u_xlat22);
					    u_xlat2.xz = u_xlat2.xz * vec2(_GerstnerIntensity);
					    u_xlat2.y = 2.0;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat2 = unity_ObjectToWorld[0].xzxz * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat4.z = dot(u_xlat3, u_xlat5);
					    u_xlat4.x = dot(u_xlat3, u_xlat6);
					    u_xlat4.y = dot(u_xlat1, _GAmplitude);
					    u_xlat1.xyz = u_xlat4.xyz + in_POSITION0.xyz;
					    u_xlat3.xy = u_xlat0.xz + u_xlat4.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    vs_TEXCOORD1.w = u_xlat4.y;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat3.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat3.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat3.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat3.xy);
					    u_xlat2 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat2 = cos(u_xlat2);
					    u_xlat3 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat3.xyxy * _GDirectionAB.ywxz;
					    u_xlat3 = u_xlat3.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat3.xz;
					    u_xlat4.zw = u_xlat3.yw;
					    u_xlat22 = dot(u_xlat2, u_xlat4);
					    u_xlat2.x = dot(u_xlat2, u_xlat5);
					    u_xlat2.x = (-u_xlat2.x);
					    u_xlat2.z = (-u_xlat22);
					    u_xlat2.xz = u_xlat2.xz * vec2(_GerstnerIntensity);
					    u_xlat2.y = 2.0;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat2 = unity_ObjectToWorld[0].xzxz * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out float vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat4.z = dot(u_xlat3, u_xlat5);
					    u_xlat4.x = dot(u_xlat3, u_xlat6);
					    u_xlat4.y = dot(u_xlat1, _GAmplitude);
					    u_xlat1.xyz = u_xlat4.xyz + in_POSITION0.xyz;
					    u_xlat3.xy = u_xlat0.xz + u_xlat4.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    vs_TEXCOORD1.w = u_xlat4.y;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat3.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat3.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat3.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat3.xy);
					    u_xlat2 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat2 = cos(u_xlat2);
					    u_xlat3 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat3.xyxy * _GDirectionAB.ywxz;
					    u_xlat3 = u_xlat3.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat3.xz;
					    u_xlat4.zw = u_xlat3.yw;
					    u_xlat22 = dot(u_xlat2, u_xlat4);
					    u_xlat2.x = dot(u_xlat2, u_xlat5);
					    u_xlat2.x = (-u_xlat2.x);
					    u_xlat2.z = (-u_xlat22);
					    u_xlat2.xz = u_xlat2.xz * vec2(_GerstnerIntensity);
					    u_xlat2.y = 2.0;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat2 = unity_ObjectToWorld[0].xzxz * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat4.z = dot(u_xlat3, u_xlat5);
					    u_xlat4.x = dot(u_xlat3, u_xlat6);
					    u_xlat4.y = dot(u_xlat1, _GAmplitude);
					    u_xlat1.xyz = u_xlat4.xyz + in_POSITION0.xyz;
					    u_xlat3.xy = u_xlat0.xz + u_xlat4.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    vs_TEXCOORD1.w = u_xlat4.y;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat3.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat3.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat3.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat3.xy);
					    u_xlat2 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat2 = cos(u_xlat2);
					    u_xlat3 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat3.xyxy * _GDirectionAB.ywxz;
					    u_xlat3 = u_xlat3.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat3.xz;
					    u_xlat4.zw = u_xlat3.yw;
					    u_xlat22 = dot(u_xlat2, u_xlat4);
					    u_xlat2.x = dot(u_xlat2, u_xlat5);
					    u_xlat2.x = (-u_xlat2.x);
					    u_xlat2.z = (-u_xlat22);
					    u_xlat2.xz = u_xlat2.xz * vec2(_GerstnerIntensity);
					    u_xlat2.y = 2.0;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat2 = unity_ObjectToWorld[0].xzxz * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out float vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat4.z = dot(u_xlat3, u_xlat5);
					    u_xlat4.x = dot(u_xlat3, u_xlat6);
					    u_xlat4.y = dot(u_xlat1, _GAmplitude);
					    u_xlat1.xyz = u_xlat4.xyz + in_POSITION0.xyz;
					    u_xlat3.xy = u_xlat0.xz + u_xlat4.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    vs_TEXCOORD1.w = u_xlat4.y;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    u_xlat0 = u_xlat1.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat3.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat3.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat3.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat3.xy);
					    u_xlat2 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat2 = cos(u_xlat2);
					    u_xlat3 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat3.xyxy * _GDirectionAB.ywxz;
					    u_xlat3 = u_xlat3.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat3.xz;
					    u_xlat4.zw = u_xlat3.yw;
					    u_xlat22 = dot(u_xlat2, u_xlat4);
					    u_xlat2.x = dot(u_xlat2, u_xlat5);
					    u_xlat2.x = (-u_xlat2.x);
					    u_xlat2.z = (-u_xlat22);
					    u_xlat2.xz = u_xlat2.xz * vec2(_GerstnerIntensity);
					    u_xlat2.y = 2.0;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat2 = u_xlat1.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat2 = unity_ObjectToWorld[0].xzxz * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out float vs_TEXCOORD5;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out float vs_TEXCOORD5;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out float vs_TEXCOORD5;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out float vs_TEXCOORD5;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0) + u_xlat0.ww;
					    vs_TEXCOORD5 = u_xlat0.z;
					    vs_TEXCOORD4.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat2.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_ReflectionTex, u_xlat1.xy);
					    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
					    u_xlat3 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat2 = texture(_RefractionTex, u_xlat2.xy);
					    u_xlat18 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlatb18 = u_xlat18<vs_TEXCOORD3.z;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat3 = texture(_RefractionTex, u_xlat3.xy);
					    u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : u_xlat2.xyz;
					    u_xlat18 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat3 = (-vec4(u_xlat18)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat3.www * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = _ReflectionColor.www * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat2.xyz) + u_xlat1.xyz;
					    u_xlat3.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat3.y = u_xlat0.y;
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat18) + _WorldLightDir.xyz;
					    u_xlat18 = dot((-u_xlat4.xyz), u_xlat3.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = log2(u_xlat18);
					    u_xlat18 = u_xlat18 * _DistortParams.z;
					    u_xlat18 = exp2(u_xlat18);
					    u_xlat19 = (-_DistortParams.w) + 1.0;
					    u_xlat18 = u_xlat19 * u_xlat18 + _DistortParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat5.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat18 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlat18 = u_xlat18 + (-vs_TEXCOORD3.w);
					    u_xlat2.xy = vec2(u_xlat18) * _InvFadeParemeter.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat18 = (-u_xlat2.y) + 1.0;
					    SV_Target0.w = u_xlat2.x;
					    u_xlat19 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat18 = u_xlat18 + u_xlat19;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2;
						vec4 _ZBufferParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  float vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat2.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_ReflectionTex, u_xlat1.xy);
					    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
					    u_xlat3 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat2 = texture(_RefractionTex, u_xlat2.xy);
					    u_xlat18 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlatb18 = u_xlat18<vs_TEXCOORD3.z;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat3 = texture(_RefractionTex, u_xlat3.xy);
					    u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : u_xlat2.xyz;
					    u_xlat18 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat3 = (-vec4(u_xlat18)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat3.www * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = _ReflectionColor.www * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat2.xyz) + u_xlat1.xyz;
					    u_xlat3.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat3.y = u_xlat0.y;
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat18) + _WorldLightDir.xyz;
					    u_xlat18 = dot((-u_xlat4.xyz), u_xlat3.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = log2(u_xlat18);
					    u_xlat18 = u_xlat18 * _DistortParams.z;
					    u_xlat18 = exp2(u_xlat18);
					    u_xlat19 = (-_DistortParams.w) + 1.0;
					    u_xlat18 = u_xlat19 * u_xlat18 + _DistortParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat5.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat18 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlat18 = u_xlat18 + (-vs_TEXCOORD3.w);
					    u_xlat2.xy = vec2(u_xlat18) * _InvFadeParemeter.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat18 = (-u_xlat2.y) + 1.0;
					    SV_Target0.w = u_xlat2.x;
					    u_xlat19 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat18 = u_xlat18 + u_xlat19;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat1.xy);
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlatb13 = u_xlat13<vs_TEXCOORD3.z;
					    u_xlat2.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat2 = texture(_RefractionTex, u_xlat2.xy);
					    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : u_xlat1.xyz;
					    u_xlat13 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat2 = (-vec4(u_xlat13)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat12 = u_xlat12 + (-vs_TEXCOORD3.w);
					    u_xlat2.xy = vec2(u_xlat12) * _InvFadeParemeter.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat12 = (-u_xlat2.y) + 1.0;
					    SV_Target0.w = u_xlat2.x;
					    u_xlat13 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat12 = u_xlat12 + u_xlat13;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2;
						vec4 _ZBufferParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  float vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat1.xy);
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlatb13 = u_xlat13<vs_TEXCOORD3.z;
					    u_xlat2.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat2 = texture(_RefractionTex, u_xlat2.xy);
					    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : u_xlat1.xyz;
					    u_xlat13 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat2 = (-vec4(u_xlat13)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat12 = u_xlat12 + (-vs_TEXCOORD3.w);
					    u_xlat2.xy = vec2(u_xlat12) * _InvFadeParemeter.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat12 = (-u_xlat2.y) + 1.0;
					    SV_Target0.w = u_xlat2.x;
					    u_xlat13 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat12 = u_xlat12 + u_xlat13;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
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
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat15) + _WorldLightDir.xyz;
					    u_xlat15 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = log2(u_xlat15);
					    u_xlat15 = u_xlat15 * _DistortParams.z;
					    u_xlat15 = exp2(u_xlat15);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat15 = u_xlat1.x * u_xlat15 + _DistortParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat2.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
					    u_xlat2 = texture(_ReflectionTex, u_xlat2.xy);
					    u_xlat4.xyz = (-u_xlat2.xyz) + _ReflectionColor.xyz;
					    u_xlat2.xyz = _ReflectionColor.www * u_xlat4.xyz + u_xlat2.xyz;
					    u_xlat16 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat4 = (-vec4(u_xlat16)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat4.www * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat15 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  float vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat15) + _WorldLightDir.xyz;
					    u_xlat15 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = log2(u_xlat15);
					    u_xlat15 = u_xlat15 * _DistortParams.z;
					    u_xlat15 = exp2(u_xlat15);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat15 = u_xlat1.x * u_xlat15 + _DistortParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat2.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
					    u_xlat2 = texture(_ReflectionTex, u_xlat2.xy);
					    u_xlat4.xyz = (-u_xlat2.xyz) + _ReflectionColor.xyz;
					    u_xlat2.xyz = _ReflectionColor.www * u_xlat4.xyz + u_xlat2.xyz;
					    u_xlat16 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat4 = (-vec4(u_xlat16)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat4.www * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat15 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat13 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat2 = (-vec4(u_xlat13)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat12 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					in  float vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat13 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat2 = (-vec4(u_xlat13)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat12 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat2.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_ReflectionTex, u_xlat1.xy);
					    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
					    u_xlat3 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat2 = texture(_RefractionTex, u_xlat2.xy);
					    u_xlat18 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlatb18 = u_xlat18<vs_TEXCOORD3.z;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat3 = texture(_RefractionTex, u_xlat3.xy);
					    u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : u_xlat2.xyz;
					    u_xlat18 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat3 = (-vec4(u_xlat18)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat3.www * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = _ReflectionColor.www * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat2.xyz) + u_xlat1.xyz;
					    u_xlat3.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat3.y = u_xlat0.y;
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat18) + _WorldLightDir.xyz;
					    u_xlat18 = dot((-u_xlat4.xyz), u_xlat3.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = log2(u_xlat18);
					    u_xlat18 = u_xlat18 * _DistortParams.z;
					    u_xlat18 = exp2(u_xlat18);
					    u_xlat19 = (-_DistortParams.w) + 1.0;
					    u_xlat18 = u_xlat19 * u_xlat18 + _DistortParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat5.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat18 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlat18 = u_xlat18 + (-vs_TEXCOORD3.w);
					    u_xlat2.xy = vec2(u_xlat18) * _InvFadeParemeter.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat18 = (-u_xlat2.y) + 1.0;
					    SV_Target0.w = u_xlat2.x;
					    u_xlat19 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat18 = u_xlat18 + u_xlat19;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2;
						vec4 _ZBufferParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  float vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat2.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_ReflectionTex, u_xlat1.xy);
					    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
					    u_xlat3 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat2 = texture(_RefractionTex, u_xlat2.xy);
					    u_xlat18 = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlatb18 = u_xlat18<vs_TEXCOORD3.z;
					    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat3 = texture(_RefractionTex, u_xlat3.xy);
					    u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : u_xlat2.xyz;
					    u_xlat18 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat3 = (-vec4(u_xlat18)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat3.www * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = _ReflectionColor.www * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat2.xyz) + u_xlat1.xyz;
					    u_xlat3.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat3.y = u_xlat0.y;
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat5.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat18) + _WorldLightDir.xyz;
					    u_xlat18 = dot((-u_xlat4.xyz), u_xlat3.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = log2(u_xlat18);
					    u_xlat18 = u_xlat18 * _DistortParams.z;
					    u_xlat18 = exp2(u_xlat18);
					    u_xlat19 = (-_DistortParams.w) + 1.0;
					    u_xlat18 = u_xlat19 * u_xlat18 + _DistortParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat5.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat18 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat18 = float(1.0) / u_xlat18;
					    u_xlat18 = u_xlat18 + (-vs_TEXCOORD3.w);
					    u_xlat2.xy = vec2(u_xlat18) * _InvFadeParemeter.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat18 = (-u_xlat2.y) + 1.0;
					    SV_Target0.w = u_xlat2.x;
					    u_xlat19 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat18 = u_xlat18 + u_xlat19;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat18 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat1.xy);
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlatb13 = u_xlat13<vs_TEXCOORD3.z;
					    u_xlat2.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat2 = texture(_RefractionTex, u_xlat2.xy);
					    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : u_xlat1.xyz;
					    u_xlat13 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat2 = (-vec4(u_xlat13)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat12 = u_xlat12 + (-vs_TEXCOORD3.w);
					    u_xlat2.xy = vec2(u_xlat12) * _InvFadeParemeter.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat12 = (-u_xlat2.y) + 1.0;
					    SV_Target0.w = u_xlat2.x;
					    u_xlat13 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat12 = u_xlat12 + u_xlat13;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2;
						vec4 _ZBufferParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  float vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat1.xy);
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat13 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat13 = float(1.0) / u_xlat13;
					    u_xlatb13 = u_xlat13<vs_TEXCOORD3.z;
					    u_xlat2.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					    u_xlat2 = texture(_RefractionTex, u_xlat2.xy);
					    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : u_xlat1.xyz;
					    u_xlat13 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat2 = (-vec4(u_xlat13)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat2.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat2 = texture(_CameraDepthTexture, u_xlat2.xy);
					    u_xlat12 = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat12 = u_xlat12 + (-vs_TEXCOORD3.w);
					    u_xlat2.xy = vec2(u_xlat12) * _InvFadeParemeter.xy;
					    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
					    u_xlat12 = (-u_xlat2.y) + 1.0;
					    SV_Target0.w = u_xlat2.x;
					    u_xlat13 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat12 = u_xlat12 + u_xlat13;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
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
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat15) + _WorldLightDir.xyz;
					    u_xlat15 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = log2(u_xlat15);
					    u_xlat15 = u_xlat15 * _DistortParams.z;
					    u_xlat15 = exp2(u_xlat15);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat15 = u_xlat1.x * u_xlat15 + _DistortParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat2.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
					    u_xlat2 = texture(_ReflectionTex, u_xlat2.xy);
					    u_xlat4.xyz = (-u_xlat2.xyz) + _ReflectionColor.xyz;
					    u_xlat2.xyz = _ReflectionColor.www * u_xlat4.xyz + u_xlat2.xyz;
					    u_xlat16 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat4 = (-vec4(u_xlat16)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat4.www * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat15 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  float vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat15) + _WorldLightDir.xyz;
					    u_xlat15 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = log2(u_xlat15);
					    u_xlat15 = u_xlat15 * _DistortParams.z;
					    u_xlat15 = exp2(u_xlat15);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat15 = u_xlat1.x * u_xlat15 + _DistortParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat2.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
					    u_xlat2 = texture(_ReflectionTex, u_xlat2.xy);
					    u_xlat4.xyz = (-u_xlat2.xyz) + _ReflectionColor.xyz;
					    u_xlat2.xyz = _ReflectionColor.www * u_xlat4.xyz + u_xlat2.xyz;
					    u_xlat16 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat4 = (-vec4(u_xlat16)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat4.www * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat2.xyz = vec3(u_xlat15) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat15 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat13 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat2 = (-vec4(u_xlat13)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat12 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[8];
						vec4 _Foam;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _RefractionTex;
					uniform  sampler2D _ShoreTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					in  float vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vs_TEXCOORD0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_RefractionTex, u_xlat1.xy);
					    u_xlat13 = vs_TEXCOORD1.w * _InvFadeParemeter.w;
					    u_xlat2 = (-vec4(u_xlat13)) * vec4(0.150000006, 0.0299999993, 0.00999999978, 0.0) + _BaseColor;
					    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat1 = vs_TEXCOORD2 + vs_TEXCOORD2;
					    u_xlat2 = texture(_ShoreTex, u_xlat1.xy);
					    u_xlat1 = texture(_ShoreTex, u_xlat1.zw);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz + vec3(-0.125, -0.125, -0.125);
					    u_xlat1.xyz = u_xlat1.xyz * _Foam.xxx;
					    u_xlat12 = vs_TEXCOORD1.w + (-_Foam.y);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD5 / _ProjectionParams.y;
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * _ProjectionParams.z;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = u_xlat12 * unity_FogParams.z + unity_FogParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
	SubShader {
		LOD 300
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 300
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 108671
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1.y = dot(u_xlat1, _GAmplitude);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat1.z = dot(u_xlat3, u_xlat5);
					    u_xlat1.x = dot(u_xlat3, u_xlat6);
					    u_xlat3.xyz = u_xlat1.xyz + in_POSITION0.xyz;
					    u_xlat1.xy = u_xlat0.xz + u_xlat1.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = u_xlat3.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat1.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat1.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat1.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat1.xy);
					    u_xlat1 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat2 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat2.xyxy * _GDirectionAB.ywxz;
					    u_xlat2 = u_xlat2.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat2.xz;
					    u_xlat4.zw = u_xlat2.yw;
					    u_xlat2.x = dot(u_xlat1, u_xlat4);
					    u_xlat1.x = dot(u_xlat1, u_xlat5);
					    u_xlat1.x = (-u_xlat1.x);
					    u_xlat1.z = (-u_xlat2.x);
					    u_xlat1.xz = u_xlat1.xz * vec2(_GerstnerIntensity);
					    u_xlat1.y = 2.0;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat1 = u_xlat3.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat1 = unity_ObjectToWorld[0].xzxz * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat3.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD4;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1.y = dot(u_xlat1, _GAmplitude);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat1.z = dot(u_xlat3, u_xlat5);
					    u_xlat1.x = dot(u_xlat3, u_xlat6);
					    u_xlat3.xyz = u_xlat1.xyz + in_POSITION0.xyz;
					    u_xlat1.xy = u_xlat0.xz + u_xlat1.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = u_xlat3.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat1.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat1.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat1.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat1.xy);
					    u_xlat1 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat2 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat2.xyxy * _GDirectionAB.ywxz;
					    u_xlat2 = u_xlat2.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat2.xz;
					    u_xlat4.zw = u_xlat2.yw;
					    u_xlat2.x = dot(u_xlat1, u_xlat4);
					    u_xlat1.x = dot(u_xlat1, u_xlat5);
					    u_xlat1.x = (-u_xlat1.x);
					    u_xlat1.z = (-u_xlat2.x);
					    u_xlat1.xz = u_xlat1.xz * vec2(_GerstnerIntensity);
					    u_xlat1.y = 2.0;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    u_xlat1 = u_xlat3.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat1 = unity_ObjectToWorld[0].xzxz * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat3.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1.y = dot(u_xlat1, _GAmplitude);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat1.z = dot(u_xlat3, u_xlat5);
					    u_xlat1.x = dot(u_xlat3, u_xlat6);
					    u_xlat3.xyz = u_xlat1.xyz + in_POSITION0.xyz;
					    u_xlat1.xy = u_xlat0.xz + u_xlat1.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = u_xlat3.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat1.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat1.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat1.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat1.xy);
					    u_xlat1 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat2 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat2.xyxy * _GDirectionAB.ywxz;
					    u_xlat2 = u_xlat2.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat2.xz;
					    u_xlat4.zw = u_xlat2.yw;
					    u_xlat2.x = dot(u_xlat1, u_xlat4);
					    u_xlat1.x = dot(u_xlat1, u_xlat5);
					    u_xlat1.x = (-u_xlat1.x);
					    u_xlat1.z = (-u_xlat2.x);
					    u_xlat1.xz = u_xlat1.xz * vec2(_GerstnerIntensity);
					    u_xlat1.y = 2.0;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat1 = u_xlat3.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat1 = unity_ObjectToWorld[0].xzxz * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat3.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD4;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1.y = dot(u_xlat1, _GAmplitude);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat1.z = dot(u_xlat3, u_xlat5);
					    u_xlat1.x = dot(u_xlat3, u_xlat6);
					    u_xlat3.xyz = u_xlat1.xyz + in_POSITION0.xyz;
					    u_xlat1.xy = u_xlat0.xz + u_xlat1.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = u_xlat3.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat1.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat1.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat1.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat1.xy);
					    u_xlat1 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat2 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat2.xyxy * _GDirectionAB.ywxz;
					    u_xlat2 = u_xlat2.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat2.xz;
					    u_xlat4.zw = u_xlat2.yw;
					    u_xlat2.x = dot(u_xlat1, u_xlat4);
					    u_xlat1.x = dot(u_xlat1, u_xlat5);
					    u_xlat1.x = (-u_xlat1.x);
					    u_xlat1.z = (-u_xlat2.x);
					    u_xlat1.xz = u_xlat1.xz * vec2(_GerstnerIntensity);
					    u_xlat1.y = 2.0;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    u_xlat1 = u_xlat3.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat1 = unity_ObjectToWorld[0].xzxz * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat3.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1.y = dot(u_xlat1, _GAmplitude);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat1.z = dot(u_xlat3, u_xlat5);
					    u_xlat1.x = dot(u_xlat3, u_xlat6);
					    u_xlat3.xyz = u_xlat1.xyz + in_POSITION0.xyz;
					    u_xlat1.xy = u_xlat0.xz + u_xlat1.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = u_xlat3.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat1.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat1.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat1.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat1.xy);
					    u_xlat1 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat2 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat2.xyxy * _GDirectionAB.ywxz;
					    u_xlat2 = u_xlat2.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat2.xz;
					    u_xlat4.zw = u_xlat2.yw;
					    u_xlat2.x = dot(u_xlat1, u_xlat4);
					    u_xlat1.x = dot(u_xlat1, u_xlat5);
					    u_xlat1.x = (-u_xlat1.x);
					    u_xlat1.z = (-u_xlat2.x);
					    u_xlat1.xz = u_xlat1.xz * vec2(_GerstnerIntensity);
					    u_xlat1.y = 2.0;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat1 = u_xlat3.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat1 = unity_ObjectToWorld[0].xzxz * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat3.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD4;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1.y = dot(u_xlat1, _GAmplitude);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat1.z = dot(u_xlat3, u_xlat5);
					    u_xlat1.x = dot(u_xlat3, u_xlat6);
					    u_xlat3.xyz = u_xlat1.xyz + in_POSITION0.xyz;
					    u_xlat1.xy = u_xlat0.xz + u_xlat1.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = u_xlat3.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat1.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat1.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat1.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat1.xy);
					    u_xlat1 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat2 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat2.xyxy * _GDirectionAB.ywxz;
					    u_xlat2 = u_xlat2.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat2.xz;
					    u_xlat4.zw = u_xlat2.yw;
					    u_xlat2.x = dot(u_xlat1, u_xlat4);
					    u_xlat1.x = dot(u_xlat1, u_xlat5);
					    u_xlat1.x = (-u_xlat1.x);
					    u_xlat1.z = (-u_xlat2.x);
					    u_xlat1.xz = u_xlat1.xz * vec2(_GerstnerIntensity);
					    u_xlat1.y = 2.0;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    u_xlat1 = u_xlat3.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat1 = unity_ObjectToWorld[0].xzxz * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat3.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1.y = dot(u_xlat1, _GAmplitude);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat1.z = dot(u_xlat3, u_xlat5);
					    u_xlat1.x = dot(u_xlat3, u_xlat6);
					    u_xlat3.xyz = u_xlat1.xyz + in_POSITION0.xyz;
					    u_xlat1.xy = u_xlat0.xz + u_xlat1.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = u_xlat3.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat1.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat1.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat1.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat1.xy);
					    u_xlat1 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat2 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat2.xyxy * _GDirectionAB.ywxz;
					    u_xlat2 = u_xlat2.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat2.xz;
					    u_xlat4.zw = u_xlat2.yw;
					    u_xlat2.x = dot(u_xlat1, u_xlat4);
					    u_xlat1.x = dot(u_xlat1, u_xlat5);
					    u_xlat1.x = (-u_xlat1.x);
					    u_xlat1.z = (-u_xlat2.x);
					    u_xlat1.xz = u_xlat1.xz * vec2(_GerstnerIntensity);
					    u_xlat1.y = 2.0;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    u_xlat1 = u_xlat3.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat1 = unity_ObjectToWorld[0].xzxz * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat3.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						float _GerstnerIntensity;
						vec4 unused_0_2[9];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 _GAmplitude;
						vec4 _GFrequency;
						vec4 _GSteepness;
						vec4 _GSpeed;
						vec4 _GDirectionAB;
						vec4 _GDirectionCD;
						vec4 unused_0_11;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD4;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.x = dot(_GDirectionAB.xy, u_xlat0.xz);
					    u_xlat1.y = dot(_GDirectionAB.zw, u_xlat0.xz);
					    u_xlat1.z = dot(_GDirectionCD.xy, u_xlat0.xz);
					    u_xlat1.w = dot(_GDirectionCD.zw, u_xlat0.xz);
					    u_xlat2 = _GSpeed * _Time.yyyy;
					    u_xlat1 = _GFrequency * u_xlat1 + u_xlat2;
					    u_xlat3 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1.y = dot(u_xlat1, _GAmplitude);
					    u_xlat4 = _GAmplitude * _GSteepness;
					    u_xlat5 = u_xlat4.xyxy * _GDirectionAB.ywxz;
					    u_xlat4 = u_xlat4.zzww * _GDirectionCD;
					    u_xlat6.xy = u_xlat5.zw;
					    u_xlat6.zw = u_xlat4.xz;
					    u_xlat5.zw = u_xlat4.yw;
					    u_xlat1.z = dot(u_xlat3, u_xlat5);
					    u_xlat1.x = dot(u_xlat3, u_xlat6);
					    u_xlat3.xyz = u_xlat1.xyz + in_POSITION0.xyz;
					    u_xlat1.xy = u_xlat0.xz + u_xlat1.xz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = u_xlat3.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat4 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat4 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat4;
					    u_xlat4 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat4;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat4;
					    gl_Position = u_xlat0;
					    u_xlat4.x = dot(_GDirectionAB.xy, u_xlat1.xy);
					    u_xlat4.y = dot(_GDirectionAB.zw, u_xlat1.xy);
					    u_xlat4.z = dot(_GDirectionCD.xy, u_xlat1.xy);
					    u_xlat4.w = dot(_GDirectionCD.zw, u_xlat1.xy);
					    u_xlat1 = _GFrequency * u_xlat4 + u_xlat2;
					    u_xlat1 = cos(u_xlat1);
					    u_xlat2 = _GAmplitude * _GFrequency;
					    u_xlat4 = u_xlat2.xyxy * _GDirectionAB.ywxz;
					    u_xlat2 = u_xlat2.zzww * _GDirectionCD;
					    u_xlat5.xy = u_xlat4.zw;
					    u_xlat5.zw = u_xlat2.xz;
					    u_xlat4.zw = u_xlat2.yw;
					    u_xlat2.x = dot(u_xlat1, u_xlat4);
					    u_xlat1.x = dot(u_xlat1, u_xlat5);
					    u_xlat1.x = (-u_xlat1.x);
					    u_xlat1.z = (-u_xlat2.x);
					    u_xlat1.xz = u_xlat1.xz * vec2(_GerstnerIntensity);
					    u_xlat1.y = 2.0;
					    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat1.xyz;
					    vs_TEXCOORD0.w = 1.0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    u_xlat1 = u_xlat3.yyyy * unity_ObjectToWorld[1].xzxz;
					    u_xlat1 = unity_ObjectToWorld[0].xzxz * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2].xzxz * u_xlat3.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat1;
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD4;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    vs_TEXCOORD4 = u_xlat0.z;
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD4;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    vs_TEXCOORD4 = u_xlat0.z;
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD4;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    vs_TEXCOORD4 = u_xlat0.z;
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD4;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
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
					    vs_TEXCOORD0 = vec4(0.0, 1.0, 0.0, 1.0);
					    vs_TEXCOORD4 = u_xlat0.z;
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1 = _Time.xxxx * _BumpDirection + u_xlat1.xzxz;
					    vs_TEXCOORD2 = u_xlat1 * _BumpTiling;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD3.zw = u_xlat0.zw;
					    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    u_xlat12 = min(u_xlat12, 1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat5.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat2.xy = u_xlat5.xy * vec2(10.0, 10.0);
					    u_xlat2.z = 0.0;
					    u_xlat5.xyz = u_xlat2.xyz + vs_TEXCOORD3.xyw;
					    u_xlat5.xy = u_xlat5.xy / u_xlat5.zz;
					    u_xlat2 = texture(_ReflectionTex, u_xlat5.xy);
					    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectionColor.xyz;
					    u_xlat5.xyz = _ReflectionColor.www * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + (-_BaseColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + _BaseColor.xyz;
					    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
					    u_xlat0.x = u_xlat0.x * _InvFadeParemeter.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat12 * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2;
						vec4 _ZBufferParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    u_xlat12 = min(u_xlat12, 1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat5.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat2.xy = u_xlat5.xy * vec2(10.0, 10.0);
					    u_xlat2.z = 0.0;
					    u_xlat5.xyz = u_xlat2.xyz + vs_TEXCOORD3.xyw;
					    u_xlat5.xy = u_xlat5.xy / u_xlat5.zz;
					    u_xlat2 = texture(_ReflectionTex, u_xlat5.xy);
					    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectionColor.xyz;
					    u_xlat5.xyz = _ReflectionColor.www * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + (-_BaseColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + _BaseColor.xyz;
					    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat1.x = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = u_xlat1.x * unity_FogParams.z + unity_FogParams.w;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xxx * u_xlat0.xyz + unity_FogColor.xyz;
					    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
					    u_xlat0.x = u_xlat0.x * _InvFadeParemeter.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat12 * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    u_xlat12 = min(u_xlat12, 1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat5.xyz = (-_BaseColor.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + _BaseColor.xyz;
					    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
					    u_xlat0.x = u_xlat0.x * _InvFadeParemeter.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat12 * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2;
						vec4 _ZBufferParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    u_xlat12 = min(u_xlat12, 1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat5.xyz = (-_BaseColor.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + _BaseColor.xyz;
					    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat1.x = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = u_xlat1.x * unity_FogParams.z + unity_FogParams.w;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xxx * u_xlat0.xyz + unity_FogColor.xyz;
					    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
					    u_xlat0.x = u_xlat0.x * _InvFadeParemeter.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat12 * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 unused_0_4;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _ReflectionTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    SV_Target0.w = min(u_xlat12, 1.0);
					    u_xlat12 = min(u_xlat1.x, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_ReflectionTex, u_xlat1.xy);
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = _ReflectionColor.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_BaseColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _BaseColor.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 unused_0_4;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _ReflectionTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    SV_Target0.w = min(u_xlat12, 1.0);
					    u_xlat12 = min(u_xlat1.x, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_ReflectionTex, u_xlat1.xy);
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = _ReflectionColor.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_BaseColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _BaseColor.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD4 / _ProjectionParams.y;
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
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 unused_0_4;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					uniform  sampler2D _BumpMap;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    SV_Target0.w = min(u_xlat12, 1.0);
					    u_xlat12 = min(u_xlat1.x, 1.0);
					    u_xlat1.xyz = (-_BaseColor.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _BaseColor.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 unused_0_4;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    SV_Target0.w = min(u_xlat12, 1.0);
					    u_xlat12 = min(u_xlat1.x, 1.0);
					    u_xlat1.xyz = (-_BaseColor.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _BaseColor.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD4 / _ProjectionParams.y;
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
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    u_xlat12 = min(u_xlat12, 1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat5.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat2.xy = u_xlat5.xy * vec2(10.0, 10.0);
					    u_xlat2.z = 0.0;
					    u_xlat5.xyz = u_xlat2.xyz + vs_TEXCOORD3.xyw;
					    u_xlat5.xy = u_xlat5.xy / u_xlat5.zz;
					    u_xlat2 = texture(_ReflectionTex, u_xlat5.xy);
					    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectionColor.xyz;
					    u_xlat5.xyz = _ReflectionColor.www * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + (-_BaseColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + _BaseColor.xyz;
					    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
					    u_xlat0.x = u_xlat0.x * _InvFadeParemeter.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat12 * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2;
						vec4 _ZBufferParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _ReflectionTex;
					uniform  sampler2D _CameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    u_xlat12 = min(u_xlat12, 1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat5.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat2.xy = u_xlat5.xy * vec2(10.0, 10.0);
					    u_xlat2.z = 0.0;
					    u_xlat5.xyz = u_xlat2.xyz + vs_TEXCOORD3.xyw;
					    u_xlat5.xy = u_xlat5.xy / u_xlat5.zz;
					    u_xlat2 = texture(_ReflectionTex, u_xlat5.xy);
					    u_xlat5.xyz = (-u_xlat2.xyz) + _ReflectionColor.xyz;
					    u_xlat5.xyz = _ReflectionColor.www * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + (-_BaseColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + _BaseColor.xyz;
					    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat1.x = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = u_xlat1.x * unity_FogParams.z + unity_FogParams.w;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xxx * u_xlat0.xyz + unity_FogColor.xyz;
					    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
					    u_xlat0.x = u_xlat0.x * _InvFadeParemeter.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat12 * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    u_xlat12 = min(u_xlat12, 1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat5.xyz = (-_BaseColor.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + _BaseColor.xyz;
					    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
					    u_xlat0.x = u_xlat0.x * _InvFadeParemeter.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat12 * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 _InvFadeParemeter;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2;
						vec4 _ZBufferParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat5;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    u_xlat12 = min(u_xlat12, 1.0);
					    u_xlat1.x = min(u_xlat1.x, 1.0);
					    u_xlat5.xyz = (-_BaseColor.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + _BaseColor.xyz;
					    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat1.x = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = u_xlat1.x * unity_FogParams.z + unity_FogParams.w;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat1.xxx * u_xlat0.xyz + unity_FogColor.xyz;
					    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
					    u_xlat1 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.z);
					    u_xlat0.x = u_xlat0.x * _InvFadeParemeter.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    SV_Target0.w = u_xlat12 * u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 unused_0_4;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _ReflectionTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    SV_Target0.w = min(u_xlat12, 1.0);
					    u_xlat12 = min(u_xlat1.x, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_ReflectionTex, u_xlat1.xy);
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = _ReflectionColor.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_BaseColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _BaseColor.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 unused_0_4;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _ReflectionTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    SV_Target0.w = min(u_xlat12, 1.0);
					    u_xlat12 = min(u_xlat1.x, 1.0);
					    u_xlat1.xy = u_xlat0.xz * _DistortParams.yy;
					    u_xlat1.xy = u_xlat1.xy * vec2(10.0, 10.0);
					    u_xlat1.z = 0.0;
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
					    u_xlat1 = texture(_ReflectionTex, u_xlat1.xy);
					    u_xlat2.xyz = (-u_xlat1.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = _ReflectionColor.www * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-_BaseColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _BaseColor.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD4 / _ProjectionParams.y;
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
					Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 unused_0_4;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					uniform  sampler2D _BumpMap;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    SV_Target0.w = min(u_xlat12, 1.0);
					    u_xlat12 = min(u_xlat1.x, 1.0);
					    u_xlat1.xyz = (-_BaseColor.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _BaseColor.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 unused_0_4;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _BumpMap;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD2.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD2.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0);
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 + 0.5;
					    SV_Target0.w = min(u_xlat12, 1.0);
					    u_xlat12 = min(u_xlat1.x, 1.0);
					    u_xlat1.xyz = (-_BaseColor.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _BaseColor.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD4 / _ProjectionParams.y;
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
	}
	SubShader {
		LOD 200
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 200
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 187071
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
						vec4 unused_0_0[12];
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
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
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
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
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = _Time.xxxx * _BumpDirection + u_xlat0.xzxz;
					    vs_TEXCOORD1 = u_xlat0 * _BumpTiling;
					    vs_TEXCOORD0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
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
						vec4 _BumpTiling;
						vec4 _BumpDirection;
						vec4 unused_0_3[7];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
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
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out float vs_TEXCOORD2;
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
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    vs_TEXCOORD2 = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = _Time.xxxx * _BumpDirection + u_xlat0.xzxz;
					    vs_TEXCOORD1 = u_xlat0 * _BumpTiling;
					    vs_TEXCOORD0.w = 1.0;
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 unused_0_4;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					uniform  sampler2D _BumpMap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD1.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD1.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vec3(0.0, 1.0, 0.0);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 * 2.0 + 0.5;
					    SV_Target0.w = min(u_xlat12, 1.0);
					    u_xlat12 = min(u_xlat1.x, 1.0);
					    u_xlat1.xyz = (-_BaseColor.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _BaseColor.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    SV_Target0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "FOG_LINEAR" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
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
						vec4 _SpecularColor;
						vec4 _BaseColor;
						vec4 _ReflectionColor;
						vec4 unused_0_4;
						float _Shininess;
						vec4 _WorldLightDir;
						vec4 _DistortParams;
						float _FresnelScale;
						vec4 unused_0_9[9];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_1_1;
					};
					uniform  sampler2D _BumpMap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_BumpMap, vs_TEXCOORD1.xy).xzyw;
					    u_xlat0.xy = u_xlat0.ww * u_xlat0.xx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat1 = texture(_BumpMap, vs_TEXCOORD1.zw).xzyw;
					    u_xlat1.xy = u_xlat1.ww * u_xlat1.xx;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xyz = u_xlat0.xyz * _DistortParams.xxx;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vec3(0.0, 1.0, 0.0);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.xz = u_xlat0.xz * vec2(_FresnelScale);
					    u_xlat1.y = u_xlat0.y;
					    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
					    u_xlat3.xyz = vs_TEXCOORD0.xyz * vec3(u_xlat12) + _WorldLightDir.xyz;
					    u_xlat12 = dot((-u_xlat2.xyz), u_xlat1.xyz);
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat12 = max(u_xlat12, 0.0);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _DistortParams.z;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat1.x = (-_DistortParams.w) + 1.0;
					    u_xlat12 = u_xlat1.x * u_xlat12 + _DistortParams.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = u_xlat12 + u_xlat12;
					    u_xlat12 = u_xlat12 * 2.0 + 0.5;
					    SV_Target0.w = min(u_xlat12, 1.0);
					    u_xlat12 = min(u_xlat1.x, 1.0);
					    u_xlat1.xyz = (-_BaseColor.xyz) + _ReflectionColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz + _BaseColor.xyz;
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, (-u_xlat2.xyz));
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Shininess;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * _SpecularColor.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat12 = vs_TEXCOORD2;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    SV_Target0.xyz = vec3(u_xlat12) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Transparent/Diffuse"
}