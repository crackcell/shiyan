.PHONY : all deps clean

REBAR = ./rebar

all : deps
	make -C collector

deps :
	$(REBAR) get-deps

clean :
	make clean -C collector
