Code for 1D and 2D convolution. http://cse.iitkgp.ac.in/~soumya/hp3/assignment2b.html

# Problem Statement

Convolution is an array operation where each output data element is the weighted sum of a collection of neighboring input elements. The weights used in the weighted sum are typically stored in an array called the convolution mask. This mask is applied across each element of the input to yield a convolved output.
Your task would be to implement two kernels each computing convolution mask operations over different forms of data.

1. A 1D convolution mask which for each element of a 1D array computes the sum of its 4 immediate neighbors.
2. A 2D convolution mask which for each element of a 2D array computes the average value of its 8 adjacent neighbors

NOTE: Your program should be generic enough to handle inputs of any dimension.
