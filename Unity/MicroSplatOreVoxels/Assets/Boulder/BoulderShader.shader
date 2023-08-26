Shader "OCB/BoulderShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _BumpMap("Normal Map", 2D) = "bump" {}
        _TRMO("Tint-Mask, Roughness, Metallic, AO", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        fixed4 _Color;
        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _TRMO;
        
        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float2 uv_TRMO;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 trmo = tex2D(_TRMO, IN.uv_TRMO);
            fixed4 albedo = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 normal = tex2D(_BumpMap, IN.uv_BumpMap);
            o.Albedo = lerp(albedo.rgb, _Color, trmo.r * 0.75);
            o.Normal = UnpackNormal(normal);
            o.Smoothness = 1 - trmo.g;
            o.Metallic = trmo.b;
            o.Occlusion = trmo.a;
            o.Alpha = albedo.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
