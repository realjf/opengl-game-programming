workspace "opengl-game"
	outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

	targetdir ("bin/%{outputdir}/")
    objdir ("bin-int/%{outputdir}/obj/")

    architecture "x64"

    configurations
    {
        "Debug",
        "Release",
    }

	platforms
    {
        "x64",
    }


IncluderDir = {}
IncluderDir["SOIL2"] = "deps/SOIL2/src"	
IncluderDir["glaux"] = "deps/glaux/"
IncluderDir["GL"] = "deps/GL/"	

project "soil2"
	location "soil2"
	kind "StaticLib"
	targetdir("deps/SOIL2/lib/" .. os.target() .. "/")
	files { "deps/SOIL2/src/SOIL2/*.c" }

	filter "action:vs*"
		buildoptions { "/TP" }
		defines { "_CRT_SECURE_NO_WARNINGS" }

	filter "action:not vs*"
		language "C"
		buildoptions { "-Wall" }

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"
		targetname "soil2"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"
		targetname "soil2"

	
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
		"%{IncluderDir.SOIL2}",
		"%{IncluderDir.glaux}",
		"%{IncluderDir.GL}/include",
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
			"soil2",
			"glaux",
		}
		
		buildoptions {
			"/Zc:strictStrings-"
		}
	
		libdirs {
			"deps/SOIL2/lib/" .. os.target() .. "/",
			"deps/glaux/",
			"%{IncluderDir.GL}/lib",
		}
	
	filter "configurations:Debug"
		symbols "On"
        runtime "Debug"
        optimize "Off"
	
	filter "configurations:Release"
		symbols "Off"
        runtime "Release"
        optimize "Full"
	
	
	