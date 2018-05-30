NVCC = nvcc

helloCUDA: headers_tut1.h kernel_tut1.cu host_tut1.cu  
	$(NVCC) -I ./ kernel_tut1.cu host_tut1.cu -o helloCUDA

      
run:
	./helloCUDA

clean:
	rm -rf helloCUDA
