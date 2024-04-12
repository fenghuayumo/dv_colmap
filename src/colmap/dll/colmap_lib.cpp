#include "colmap_lib.h"

#include <colmap/controllers/automatic_reconstruction.h>
#include <colmap/util/controller_thread.h>
#include <colmap/controllers/incremental_mapper.h>

std::unique_ptr<colmap::AutomaticReconstructionController>  controller_;

auto ColmapSparseReconstruct::run() ->void
{
   colmap::AutomaticReconstructionController::Options _option;
    _option.image_path = option.image_path;
    _option.workspace_path = option.workspace_path;
    _option.quality = colmap::AutomaticReconstructionController::Quality::HIGH;
    _option.use_gpu = true;
    _option.gpu_index = "0";
    _option.sparse = true;
    _option.dense =  false;
    _option.data_type =
        colmap::AutomaticReconstructionController::DataType::INDIVIDUAL;

    std::shared_ptr<colmap::ReconstructionManager> reconstruction_manager_ =
        std::make_shared<colmap::ReconstructionManager>();

    controller_.reset(new colmap::AutomaticReconstructionController(
        _option, reconstruction_manager_));

    controller_->Start();
    controller_->Wait();
}

  int ColmapSparseReconstruct::GetSparseReconstructPhase()
  {
    return controller_->GetSparseReconstructPhase();
  }
  float ColmapSparseReconstruct::GetProgressOnCurrentPhase()
  {
    return controller_->GetProgressOnCurrentPhase();
  }