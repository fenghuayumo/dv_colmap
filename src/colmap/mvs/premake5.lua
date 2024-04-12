project "colmap_mvs"
    kind "StaticLib"
	language "C++"
	-- editandcontinue "Off"

	files
	{
		"**.h",
		"**.c",
		"**.cc",
        "**.cpp"
        -- "src/**.cu"
	}

	includedirs
	{
		"../../",
	}

	externalincludedirs
	{
		"%{IncludeDir.Package}",
	}

    libdirs
    {
        "%{LibraryDir.Package}",
    }

    links
	{
        "colmap_util",
        "colmap_scene",
        "colmap_sensor",
        "colmap_image",
        "colmap_poisson_recon"
    }

	defines
	{
        "GLOG_USE_GLOG_EXPORT",
        "GLOG_VERSION_MAJOR 1",
    }

    buildcustomizations {cudaBuildCustomizations}

    if os.target() == "windows" then
      -- Just in case we want the VS CUDA extension to use a custom version of CUDA
      cudaPath "$(CUDA_PATH)"
      cudaFiles { "../src/colmap/mvs/**.cu" }
    else
      toolset "nvcc"
      cudaPath "/usr/local/cuda"
      rules {"cu"}
    end
   
    cudaRelocatableCode "On"
   
    -- Let's compile for all supported architectures (and also in parallel with -t0)
    cudaCompilerOptions {"-arch=sm_70", "-t0", "-std=c++17"} 
    cudaFastMath "On"
    cudaIntDir "bin/cudaobj/%{cfg.buildcfg}"
	
	filter "system:windows"
		cppdialect "C++20"
		systemversion "latest"
		disablewarnings { 4307 }
		characterset ("Unicode")
		conformancemode "on"
        externalincludedirs
        {
            "%{IncludeDir.Package}"
        }
        links
        {
            
        }

    filter "configurations:Debug"
        defines { "_DEBUG" }
        symbols "On"
        runtime "Debug"
        optimize "Off"
    
    filter "configurations:Release"
        defines {"NDEBUG" }
        optimize "Speed"
        symbols "On"
        runtime "Release"
    
    filter "configurations:Production"
        defines { "NDEBUG" }
        symbols "Off"
        optimize "Full"
        runtime "Release"
    
