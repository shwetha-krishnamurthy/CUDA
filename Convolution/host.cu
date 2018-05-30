#include "headers.h"
/**
 * Host main routine
 */
int main(void)
{
    // Error code to check return values for CUDA calls
    cudaError_t err = cudaSuccess;

    // Print the vector length to be used, and compute its size
    int numElements = 5;
    int numElements2d = 5;
    int i, j;
    //printf("Enter matrix size: ");
    //scanf("%d", &numElements);
    size_t size = numElements * sizeof(float);
    size_t size2d = numElements2d * numElements2d * sizeof(float);
    //printf("[Vector addition of %d elements]\n", numElements);

    // Allocate the host input vector A
    float *h_A, *h_B, *h_M;
    float *h_A2d, *h_B2d, *h_M2d;

    //for (i= 0; i<numElements; i++)
    h_A = (float *)malloc(size);
    h_B = (float *)malloc(size);
    h_M = (float *)malloc(5*sizeof(float));

    h_A2d = (float *)malloc(size2d);
    h_B2d = (float *)malloc(size2d);
    h_M2d = (float *)malloc(9*sizeof(float));


    // Verify that allocations succeeded
    if (h_A == NULL) 
    {
        fprintf(stderr, "Failed to allocate host vectors!\n");
        exit(EXIT_FAILURE);
    }

    if (h_B == NULL) 
    {
        fprintf(stderr, "Failed to allocate host vectors!\n");
        exit(EXIT_FAILURE);
    }

    if (h_M == NULL) 
    {
        fprintf(stderr, "Failed to allocate host vectors!\n");
        exit(EXIT_FAILURE);
    }

    if (h_A2d == NULL) 
    {
        fprintf(stderr, "Failed to allocate host vectors!\n");
        exit(EXIT_FAILURE);
    }

    if (h_B2d == NULL) 
    {
        fprintf(stderr, "Failed to allocate host vectors!\n");
        exit(EXIT_FAILURE);
    }

    if (h_M2d == NULL) 
    {
        fprintf(stderr, "Failed to allocate host vectors!\n");
        exit(EXIT_FAILURE);
    }

    //Initialize vectors
 
    for (i = 0; i < numElements; ++i)
    {
        h_A[i] = ((float)rand()/(float)RAND_MAX);
        h_B[i] = 0;
        printf("%f, ", h_A[i]);
    }
    printf("\n");
    for (i = 0; i < 5; ++i)
    {
        h_M[i] = ((float)rand()/(float)RAND_MAX);
        printf("%f, ", h_M[i]);
    }
    printf("\n\n");


    //Initialize the host input vectors
    for (i = 0; i <  numElements; i++)
    {
      for (j = 0; j < numElements; j++)
      {
         h_A2d[i*numElements + j] = ((float)rand() / RAND_MAX);
         h_B2d[i*numElements + j] = 0;
         printf("%f ", h_A2d[i*numElements + j]); // Or *(*(arr+i)+j) = ++count
      }
      printf("\n");
    }

    printf("\n\n");
    
    //Initialize the host input vectors
    for (i = 0; i <  3; i++)
    {
      for (j = 0; j < 3; j++)
      {
         h_M2d[i*3 + j] = ((float)rand() / RAND_MAX);
         printf("%f ", h_M2d[i*3 + j]); // Or *(*(arr+i)+j) = ++count
      }
      printf("\n");
    }

    printf("\n\n");

    // Allocate the device input vector A
    float *d_A = NULL, *d_B = NULL, *d_M = NULL;
    err = cudaMalloc((void **)&d_A, size);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device vector A (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaMalloc((void **)&d_B, size);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device vector B (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaMalloc((void **)&d_M, 5*sizeof(float));

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device vector M (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }


    // Allocate the device input vector A
    float *d_A2d = NULL, *d_B2d = NULL, *d_M2d = NULL;
    err = cudaMalloc((void **)&d_A2d, size2d);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device vector A (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaMalloc((void **)&d_B2d, size2d);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device vector B (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaMalloc((void **)&d_M2d, 9*sizeof(float));

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to allocate device vector M (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    // Copy the host input vectors A and B in host memory to the device input vectors in
    // device memory
    printf("Copy input data from the host memory to the CUDA device\n");
    err = cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector A from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    printf("Copy input data from the host memory to the CUDA device\n");
    err = cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector B from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    printf("Copy input data from the host memory to the CUDA device\n");
    err = cudaMemcpy(d_M, h_M, 5*sizeof(float), cudaMemcpyHostToDevice);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector M from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }


    // Copy the host input vectors A and B in host memory to the device input vectors in
    // device memory
    printf("Copy input data from the host memory to the CUDA device\n");
    err = cudaMemcpy(d_A2d, h_A2d, size2d, cudaMemcpyHostToDevice);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector A from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    printf("Copy input data from the host memory to the CUDA device\n");
    err = cudaMemcpy(d_B2d, h_B2d, size2d, cudaMemcpyHostToDevice);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector B from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    printf("Copy input data from the host memory to the CUDA device\n");
    err = cudaMemcpy(d_M2d, h_M2d, 9*sizeof(float), cudaMemcpyHostToDevice);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector M from host to device (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }


    // Launch the Vector Add CUDA Kernel
    int threadsPerBlock = numElements;
    int blocksPerGrid = numElements;
    printf("CUDA kernel launch with %d blocks of %d threads\n", blocksPerGrid, threadsPerBlock);
    convolution1d<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_M, numElements);
    err = cudaGetLastError();

    int threadsPerBlock2d = numElements2d;
    int blocksPerGrid2d = numElements2d;
    printf("CUDA kernel launch with %d blocks of %d threads\n", blocksPerGrid2d, threadsPerBlock2d);
    convolution2d<<<blocksPerGrid2d, threadsPerBlock2d>>>(d_A2d, d_B2d, d_M2d, numElements2d);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to launch swap kernel (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    // Copy the device result vector in device memory to the host result vector
    // in host memory.
    printf("Copy output data from the CUDA device to the host memory\n");
    err = cudaMemcpy(h_B, d_B, size, cudaMemcpyDeviceToHost);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector C from device to host (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    printf("Copy output data from the CUDA device to the host memory\n");
    err = cudaMemcpy(h_B2d, d_B2d, size2d, cudaMemcpyDeviceToHost);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to copy vector C from device to host (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    // Verify that the result vector is correct
    // for (int i = 0; i < numElements; ++i)
    // {
    //     if (fabs(h_A[i] + h_B[i] - h_C[i]) > 1e-5)
    //     {
    //         fprintf(stderr, "Result verification failed at element %d!\n", i);
    //         exit(EXIT_FAILURE);
    //     }
    // }

    // for(i = 0; i<numElements; i++)
    // {
    // 	for (j = 0; j<numElements; j++)
    // 	{
    // 		printf("%f ", h_A[i*numElements + j]);
    // 	}
    // 	printf("\n");
    // }

    for (i = 0; i < numElements; ++i)
    {
        printf("%f, ", h_B[i]);
    }

    printf("\n");


    for(i = 0; i<numElements; i++)
    {
        for (j = 0; j<numElements; j++)
        {
            printf("%f ", h_B2d[i*numElements + j]);
        }
        printf("\n");
    }

    printf("Test PASSED\n");

    // Free device global memory
    err = cudaFree(d_A);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device vector A (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaFree(d_B);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device vector B (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaFree(d_A2d);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device vector A (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaFree(d_B2d);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device vector B (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaFree(d_M);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device vector A (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    err = cudaFree(d_M2d);

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to free device vector B (error code %s)!\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    // err = cudaFree(d_C);

    // if (err != cudaSuccess)
    // {
    //     fprintf(stderr, "Failed to free device vector C (error code %s)!\n", cudaGetErrorString(err));
    //     exit(EXIT_FAILURE);
    // }

    // Free host memory
    free(h_A);
    free(h_B);
    free(h_A2d);
    free(h_B2d);
    free(h_M2d);
    free(h_M2d);
    // free(h_C);

    // Reset the device and exit
    // cudaDeviceReset causes the driver to clean up all state. While
    // not mandatory in normal operation, it is good practice.  It is also
    // needed to ensure correct operation when the application is being
    // profiled. Calling cudaDeviceReset causes all profile data to be
    // flushed before the application exits
    err = cudaDeviceReset();

    if (err != cudaSuccess)
    {
        fprintf(stderr, "Failed to deinitialize the device! error=%s\n", cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }

    printf("Done\n");
    return 0;
}

