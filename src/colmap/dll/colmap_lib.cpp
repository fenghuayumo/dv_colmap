#include "colmap_lib.h"

#include <colmap/controllers/automatic_reconstruction.h>
#include <colmap/util/controller_thread.h>
#include <colmap/controllers/incremental_mapper.h>

//std::unique_ptr<colmap::AutomaticReconstructionController>  controller_;

auto ColmapSparseReconstruct::run() ->bool
{
   colmap::AutomaticReconstructionController::Options _option;
    _option.image_path = option.image_path;
    _option.workspace_path = option.workspace_path;
    _option.quality = colmap::AutomaticReconstructionController::Quality::MEDIUM;
    _option.use_gpu = true;
    _option.gpu_index = std::to_string(option.gpu_index);
    _option.sparse = true;
    _option.dense =  false;
    _option.camera_model = option.camera_model;
    _option.data_type =
        colmap::AutomaticReconstructionController::DataType::INDIVIDUAL;
    _option.mesher =
        colmap::AutomaticReconstructionController::Mesher::POISSON;
    std::shared_ptr<colmap::ReconstructionManager> reconstruction_manager_ =
        std::make_shared<colmap::ReconstructionManager>();

    controller_ = std::make_shared<colmap::AutomaticReconstructionController>(
        _option, reconstruction_manager_);

    controller_->Start();
    controller_->Wait();
    if(controller_->GetSparseReconstructPhase() != 4) return false;
    return true;
}

ColmapSparseReconstruct::~ColmapSparseReconstruct()
{
}

int ColmapSparseReconstruct::GetSparseReconstructPhase()
  {
    if( controller_ == nullptr) return 0;
    return controller_->GetSparseReconstructPhase();
  }
  float ColmapSparseReconstruct::GetProgressOnCurrentPhase()
  {
    if (controller_ == nullptr) return 0;
    return controller_->GetProgressOnCurrentPhase();
  }