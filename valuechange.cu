#include <cuda_runtime.h>
#include <iostream>

// Kernel Function
__global__ void incrementVariable(int* globalVar) {
    int oldValue = atomicAdd(globalVar, 1); // Get the pre-increment value
   // int oldValue = *globalVar; // Get the current value of the variable
    //*globalVar = oldValue + 1; // Increment the variable
    printf("Thread %d in block %d incrementing variable from %d to %d\n",
           threadIdx.x, blockIdx.x, oldValue, oldValue + 1);
}



int main() {
    // Declare and initialize variable in host memory
    int hostVar = 0;

    // Allocate memory on the device
    int* deviceVar;
    cudaMalloc((void**)&deviceVar, sizeof(int));

    // Copy the variable to device memory
    cudaMemcpy(deviceVar, &hostVar, sizeof(int), cudaMemcpyHostToDevice);

    // Launch kernel with 2 blocks and 10 threads per block
    incrementVariable<<<2, 10>>>(deviceVar);

    // Synchronize to ensure all threads complete
    cudaDeviceSynchronize();

    // Copy the result back to host memory
    cudaMemcpy(&hostVar, deviceVar, sizeof(int), cudaMemcpyDeviceToHost);

    // Print the result
    std::cout << "Final value of the variable: " << hostVar << std::endl;

    // Free device memory
    cudaFree(deviceVar);

    return 0;
}
