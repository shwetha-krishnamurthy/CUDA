#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>
__global__ void convolution1d(float*, float* , float* ,int);
__global__ void convolution2d(float*, float* , float* ,int);
