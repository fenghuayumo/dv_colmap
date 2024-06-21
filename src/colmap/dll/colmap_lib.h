
#ifdef _WIN32
#pragma warning(disable : 4251)
#ifdef COlMAP_DYNAMIC
#ifdef COLMAP_ENGINE
#define COLMAP_EXPORT __declspec(dllexport)
#else
#define COLMAP_EXPORT __declspec(dllimport)
#endif
#else
#define COLMAP_EXPORT
#endif
#define COLMAP_HIDDEN
#else
#define COLMAP_EXPORT __attribute__((visibility("default")))
#define COLMAP_HIDDEN __attribute__((visibility("hidden")))
#endif
#include <string>
#include <memory>

namespace colmap {
    class AutomaticReconstructionController;
}

struct COLMAP_EXPORT ColmapSparseReconstruct {
    ~ColmapSparseReconstruct();
    enum class Quality {
        Low,Medium,High
    };
    struct Option {
        std::string image_path;
        std::string workspace_path;
        int gpu_index = -1;
        bool video = true;
        bool use_hierachy = true;
        Quality quality = Quality::Low;
        std::string camera_model= "SIMPLE_PINHOLE";
    }option;
    int GetSparseReconstructPhase();
    float GetProgressOnCurrentPhase();
    auto run()->bool;

    std::shared_ptr<colmap::AutomaticReconstructionController>  controller_;
};
