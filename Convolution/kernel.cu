
__global__ void
convolution1d(float *A, float *B, float *M, int numElements)
{
    //int i=blockIdx.x;
    int i=threadIdx.x;
    int j, k;

    if (i < numElements)
    {
        for ( j = 0, k = -2; j < 4, k <=2; ++j, ++k)
        {
            if((i+k)>=0 && (i+k)<numElements)
            {
                B[i] += M[j]*A[i+k]; 
            }
        }
    }
   // __syncthreads();
}


__global__ void
convolution2d(float *A, float *B, float *M, int numElements)
{
    int i=blockIdx.x;
    int j=threadIdx.x;
    int k,l,m,n;

    if ((i < numElements) && (j < numElements))
    {
        for(k = 0, l = -1; k < 3, l <=1; k++, l++)
        {
            for(m = 0, n = -1; m < 3, n <=1; m++, n++)
            {
                if((i+l)>=0 && (i+l)<numElements && (j+n)>=0 && (j+n)<numElements)
                {
                    B[i*numElements + j] += M[k*3 + m]*A[(i+l)*numElements + (j+n)];
                }
            }
        } 
        __syncthreads();
    }
}