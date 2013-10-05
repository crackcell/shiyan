.PHONY : all deps clean test

REBAR = ../rebar

all : deps
	$(REBAR) compile

deps :
	make deps -C ../

clean :
	$(REBAR) delete-deps
	rm -rf deps
	$(REBAR) clean

test :
	$(REBAR) compile eunit

