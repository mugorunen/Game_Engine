-- premake5.lua

workspace "Game_Engine"
	architecture "x64"

	configurations{
		"Debug",
		"Release",
		"Dist"
	}


-- Build Configuration - System - Architecture
outputDir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Game_Engine"
	location "Game_Engine"
	kind "SharedLib" -- Since it should be a dynamic library
	language "C++"

	targetdir ("bin/" .. outputDir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputDir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"
		cppdialect "C++17" 
		staticruntime "On" -- Linking RunTime Libraries
		systemversion "latest"

		defines
		{
			"GE_PLATFORM_WINDOWS",
			"GE_BUILD_DLL"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputDir .. "/Sandbox")
		}

	filter "configurations:Debug"
		defines "GE_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "GE_RELEASE"
		optimize "On"
	
	filter "configurations:Dist"
		defines "GE_DIST"
		optimize "On"

	

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputDir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputDir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Game_Engine/vendor/spdlog/include",
		"Game_Engine/src"
	}

	links
	{
		"Game_Engine"
	}

	filter "system:windows"
		cppdialect "C++17" 
		staticruntime "On" -- Linking RunTime Libraries
		systemversion "latest"

		defines
		{
			"GE_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "GE_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "GE_RELEASE"
		optimize "On"
	
	filter "configurations:Dist"
		defines "GE_DIST"
		optimize "On"
