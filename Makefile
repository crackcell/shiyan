.PHONY : all clean

all :
	make -C interface
	make -C collector

clean :
	rm -rf deps
	make clean -C collector
	make clean -C interface
