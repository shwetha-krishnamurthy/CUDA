
__global__ void
swap_reflect(float *A, int numElements)
{
    int i=blockIdx.x;
    int j=threadIdx.x;

    float temp;

    if ((i < numElements) && (j < numElements -1) && ((j)%2==0))
    {
        temp = A[i*numElements + j];
        A[i*numElements + j] = A[i*numElements + j + 1];
        A[i*numElements + j + 1] = temp;
        
    }
    __syncthreads();
    
    if((i < numElements) && (j < numElements) && (i>j) && (i!=j))
    {
        A[j*numElements + i] = A[i*numElements + j];
        //__syncthreads();
    }
}
