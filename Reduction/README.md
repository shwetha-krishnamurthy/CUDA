Code for implementation various reduction techniques for the problem of matrix addition. http://cse.iitkgp.ac.in/~soumya/hp3/reduction-matrix.html

# Problem Statement

Since matrix addition is an associative operation, the techniques for parallel reduction can be applied here. Your objective would be to implement a CUDA program which takes as input a set of n 2x2 matrices, perform matrix addition using reduction and return the final 2x2 matrix. The problem is very different from that of simple addition since you now have to accommodate a set of matrices in shared memory and perform element wise addition. The execution time of the program that you will be developing will therefore depend on how the set of matrices are stored in memory. You shall pass a 1D array of elements where each consecutive sets of 4 elements represents a 2x2 matrix. Note you can use a row major representation or a column major representation in the beginning for storing the matrix. Design a naive reduction kernel i.e. the first one taught in class for this problem for both layouts. Design an optimized reduction kernel for both layouts and write a detailed report stating as to why your algorithm will perform better than the naive algorithm. You can use the optimizations discussed in class, and also come up with your own set of optimizations. Note this is an investigatory assignment and thus shall require understanding the underlying architecture of the GPU you are using. The report should contain the following points:

1. Device Property Attributes that you feel are required while designing the optimized kernel. This includes properties such as total supported shared memory size, number of banks, thread block size, maximum number of SMs etc
2. Source codes for both the naive and the optimized reduction kernel.
3. Detailed explanation of the optimization techniques that you have implemented stating as to why it will perform better than the naive kernel for both the layouts.
4. Speedup and execution time plots for different values of n i.e. the number of 2x2 matrices for both algorithms and for both layouts of matrices in memory

## Resources

http://developer.download.nvidia.com/compute/cuda/1.1-Beta/x86_website/projects/reduction/doc/reduction.pdf
