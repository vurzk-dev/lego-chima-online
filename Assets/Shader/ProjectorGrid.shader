Shader "Projector/Grid" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,0)
		_ShadowTex ("Cookie", 2D) = "black" {}
		_Size ("Grid Size", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Offset -1, -1
			Fog {
				Mode Off
			}
			GpuProgramID 50570
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
						vec4 _ShadowTex_ST;
						vec4 unused_0_2;
						mat4x4 unity_Projector;
						vec4 unused_0_4;
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
					out vec2 vs_TEXCOORD0;
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
					    u_xlat0.xy = in_POSITION0.yy * unity_Projector[1].xy;
					    u_xlat0.xy = unity_Projector[0].xy * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_Projector[2].xy * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = unity_Projector[3].xy * in_POSITION0.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = u_xlat0.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
						vec4 unused_0_0[3];
						vec4 _Color;
						vec4 unused_0_2[4];
						float _Size;
					};
					uniform  sampler2D _ShadowTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec2 u_xlatb1;
					float u_xlat4;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat4 = float(1.0) / _Size;
					    u_xlat0.xy = u_xlat0.xy / vec2(u_xlat4);
					    u_xlatb1.xy = greaterThanEqual(u_xlat0.xyxx, (-u_xlat0.xyxx)).xy;
					    u_xlat0.xy = fract(abs(u_xlat0.xy));
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
					        hlslcc_movcTemp.y = (u_xlatb1.y) ? u_xlat0.y : (-u_xlat0.y);
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy * vec2(_Size);
					    u_xlat0 = texture(_ShadowTex, u_xlat0.xy);
					    SV_Target0 = u_xlat0 * _Color;
					    return;
					}"
				}
			}
		}
	}
}