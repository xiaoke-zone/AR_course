﻿Shader "Custom/DepthEffect" {//着色器名称
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}
	_DepthPower("DepthPower", range(1,5)) = 0.2
	}
		SubShader{
		Pass
	{
		CGPROGRAM
#pragma vertex vert_img
#pragma fragment frag
#pragma fragmentoption ARB_precision_hint_fastest
#include "UnityCG.cginc"	
	uniform sampler2D _MainTex;
	uniform sampler2D depthBack;
	uniform sampler2D tex;
	fixed _DepthPower;
	sampler2D_float _CameraDepthTexture;

	fixed4 frag(v2f_img i) : COLOR
	{
		float d = UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture,float2(i.uv.x,i.uv.y)));
	    float db = 1.0f;
	    d = pow(Linear01Depth(d), _DepthPower);
	    fixed4 modelf = tex2D(_MainTex,i.uv);

        float x = 1-i.uv.y;
        float y = i.uv.x-1;

	    fixed4 backf = tex2D(tex,float2(x, y));

	    fixed4 finalColor;

	    if(d == db)
	    {
	        finalColor = backf;
	    }
	    else
	    {
	        finalColor = modelf;
	    }

	    return finalColor;
	}
		ENDCG
	}
	}
		FallBack "Diffuse"
}
