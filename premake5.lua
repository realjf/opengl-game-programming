workspace "opengl-game"
	outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

	targetdir ("bin/%{outputdir}/")
    objdir ("bin-int/%{outputdir}/obj/")

    architecture = "x64"

    configurations
    {
        "Debug",
        "Release",
    }

	platforms
    {
        "x64"
    }

project "game"
	location "game"
	kind "WindowedApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

	files {
		"game/src/**.h",
		"game/src/**.cpp"
	}
	
	includedirs
	{
	
	}
	
	
	filter "system:windows"
		systemversion "latest"
        staticruntime "On"
		systemversion "latest"
		characterset "MBCS"
		
		links
		{
			"opengl32",
			"glu32",
		}
		
		buildoptions {
			"/Zc:strictStrings-"
		}
	
	
	filter "configurations:Debug"
		symbols "On"
        runtime "Debug"
        optimize "Off"
	
	filter "configurations:Release"
		symbols "Off"
        runtime "Release"
        optimize "Full"
	
	
	