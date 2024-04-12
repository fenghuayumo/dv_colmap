#include <colmap/dll/colmap_lib.h>

int main() 
{ 
	ColmapSparseReconstruct sparse_reconstruct;
	sparse_reconstruct.option.image_path = "G:/tandt_db/db/lego/images";
	sparse_reconstruct.option.workspace_path = "G:/tandt_db/db/lego";
    sparse_reconstruct.run();

	return 0;
}