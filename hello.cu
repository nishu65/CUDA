#include <cuda_runtime.h>
#include <iostream>

// GPU Kernel to print "Hello from CUDA"
__global__ void printHelloCUDA() {
    for (int i = 0; i < 10; i++) {
        printf(" count i = %d thread %d, block %d\n", i, threadIdx.x,blockIdx.x);
        if (i == 100000) {
            break;
        }
    }
    printf("Hello from CUDA Kernel! block %d ,Thread %d\n",blockIdx.x ,threadIdx.x);
}

int main() {
    // Launch the kernel with 1 block and 10 threads per block
    printHelloCUDA<<<2, 33>>>();
    std::cout << "Hello from CPU!" << std::endl;
    // Wait for the kernel to finish
    cudaDeviceSynchronize();

    // Confirm program has run
    

    return 0;
}
