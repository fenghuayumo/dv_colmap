project "colmap"
	kind "SharedLib"
	language "C++"
	-- editandcontinue "Off"

	files
	{
		"**.h",
		"**.c",
		"**.cc",
        "**.cpp",
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
        "glog",
        "boost_filesystem-vc140-mt",
        "boost_program_options-vc140-mt",
        "gtest",
        "colmap_controllers",
        "colmap_estimators",
        "colmap_util",
        "colmap_geometry",
        "colmap_sfm",
        "colmap_optim",
        "colmap_scene",
        "colmap_image",
        "colmap_math",
        "colmap_mvs",
        "ceres",
        "FreeImage",
        "colmap_sift_gpu",
        "colmap_vlfeat",
        "sqlite3",
        "glew32",
        "OpenGL32",
        "metis",
        "GKlib"
    }

	defines
	{
        "GLOG_USE_GLOG_EXPORT",
        "GLOG_VERSION_MAJOR 1",
        "COLMAP_BUILD_MAIN_LIB",
        "COLMAP_BUILD_SHARED_LIBS",
        "PREMAKE_CUDA_EXPORT_API"
    }
    buildcustomizations {cudaBuildCustomizations}

    if os.target() == "windows" then
      -- Just in case we want the VS CUDA extension to use a custom version of CUDA
      cudaPath "$(CUDA_PATH)"
      cudaFiles { "src/colmap/dll/**.cu" }
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
    
