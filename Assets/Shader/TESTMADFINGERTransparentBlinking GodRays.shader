Shader "TEST/MADFINGER/Transparent/Blinking GodRays" {
	Properties {
		_MainTex ("Base texture", 2D) = "white" {}
		_FadeOutDistNear ("Near fadeout dist", Float) = 10
		_FadeOutDistFar ("Far fadeout dist", Float) = 10000
		_Multiplier ("Color multiplier", Float) = 1
		_Bias ("Bias", Float) = 0
		_TimeOnDuration ("ON duration", Float) = 0.5
		_TimeOffDuration ("OFF duration", Float) = 0.5
		_BlinkingTimeOffsScale ("Blinking time offset scale (seconds)", Float) = 5
		_SizeGrowStartDist ("Size grow start dist", Float) = 5
		_SizeGrowEndDist ("Size grow end dist", Float) = 50
		_MaxGrowSize ("Max grow size", Float) = 2.5
		_NoiseAmount ("Noise amount (when zero, pulse wave is used)", Range(0, 0.5)) = 0
		_Color ("Color", Vector) = (1,1,1,1)
	}
	SubShader {
		LOD 100
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			LOD 100
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 57847
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
						vec4 unused_0_0[2];
						float _FadeOutDistNear;
						float _FadeOutDistFar;
						float _Multiplier;
						float _Bias;
						float _TimeOnDuration;
						float _TimeOffDuration;
						float _BlinkingTimeOffsScale;
						float _SizeGrowStartDist;
						float _SizeGrowEndDist;
						float _MaxGrowSize;
						float _NoiseAmount;
						vec4 _Color;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat10;
					bool u_xlatb10;
					void main()
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat0.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[3].www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat3.x = u_xlat0.x + (-_SizeGrowStartDist);
					    u_xlat3.x = max(u_xlat3.x, 0.0);
					    u_xlat3.x = u_xlat3.x / _SizeGrowEndDist;
					    u_xlat3.x = min(u_xlat3.x, 1.0);
					    u_xlat3.x = u_xlat3.x * u_xlat3.x;
					    u_xlat3.x = u_xlat3.x * _MaxGrowSize;
					    u_xlat3.x = u_xlat3.x * in_COLOR0.w;
					    u_xlat3.xyz = u_xlat3.xxx * in_NORMAL0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat3.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat3.x = u_xlat0.x + (-_FadeOutDistFar);
					    u_xlat0.x = u_xlat0.x / _FadeOutDistNear;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat3.x = max(u_xlat3.x, 0.0);
					    u_xlat3.x = u_xlat3.x * 0.200000003;
					    u_xlat3.x = min(u_xlat3.x, 1.0);
					    u_xlat0.y = (-u_xlat3.x) + 1.0;
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat0 = u_xlat0.xxxx * _Color;
					    u_xlat0 = u_xlat0 * vec4(vec4(_Multiplier, _Multiplier, _Multiplier, _Multiplier));
					    u_xlat1.x = _BlinkingTimeOffsScale * in_COLOR0.z + _Time.y;
					    u_xlat4.x = _TimeOffDuration + _TimeOnDuration;
					    u_xlat7 = u_xlat1.x / u_xlat4.x;
					    u_xlatb10 = u_xlat7>=(-u_xlat7);
					    u_xlat7 = fract(abs(u_xlat7));
					    u_xlat7 = (u_xlatb10) ? u_xlat7 : (-u_xlat7);
					    u_xlat2.xy = vec2(_TimeOnDuration) * vec2(0.25, 0.75);
					    u_xlat4.z = u_xlat7 * u_xlat4.x + (-u_xlat2.y);
					    u_xlat4.x = u_xlat4.x * u_xlat7;
					    u_xlat7 = float(1.0) / u_xlat2.x;
					    u_xlat4.xz = vec2(u_xlat7) * u_xlat4.xz;
					    u_xlat4.xz = clamp(u_xlat4.xz, 0.0, 1.0);
					    u_xlat7 = u_xlat4.z * -2.0 + 3.0;
					    u_xlat10 = u_xlat4.z * u_xlat4.z;
					    u_xlat7 = (-u_xlat7) * u_xlat10 + 1.0;
					    u_xlat10 = u_xlat4.x * -2.0 + 3.0;
					    u_xlat4.x = u_xlat4.x * u_xlat4.x;
					    u_xlat4.x = u_xlat4.x * u_xlat10;
					    u_xlat4.x = u_xlat7 * u_xlat4.x;
					    u_xlat7 = 6.28318548 / _TimeOnDuration;
					    u_xlat1.x = u_xlat7 * u_xlat1.x;
					    u_xlat7 = u_xlat1.x * 0.636600018 + 56.7271996;
					    u_xlat1.x = sin(u_xlat1.x);
					    u_xlat7 = cos(u_xlat7);
					    u_xlat7 = u_xlat7 * 0.5 + 0.5;
					    u_xlat1.x = u_xlat7 * u_xlat1.x;
					    u_xlat1.x = _NoiseAmount * u_xlat1.x + (-_NoiseAmount);
					    u_xlat1.x = u_xlat1.x + 1.0;
					    u_xlatb7 = _NoiseAmount<0.00999999978;
					    u_xlat1.x = (u_xlatb7) ? u_xlat4.x : u_xlat1.x;
					    u_xlat1.x = u_xlat1.x + _Bias;
					    vs_TEXCOORD1 = u_xlat0 * u_xlat1.xxxx;
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
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0 = u_xlat0 * vs_TEXCOORD1;
					    return;
					}"
				}
			}
		}
	}
}