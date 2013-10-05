.PHONY : all clean release

all :
	make -C interface
	make -C collector

clean :
	rm -rf deps
	make clean -C collector
	make clean -C interface

release :
	make release -C collector
