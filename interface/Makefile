REBAR = ../rebar

.PHONY : all deps clean

all : deps
	erl -pa ../deps/*/ebin \
	-noshell \
	-eval "protobuffs_compile:scan_file(\"src/interface.proto\"), init:stop()."
	mkdir -p ebin include
	mv *.beam ebin/
	mv *.hrl include/

deps :
	$(REBAR) get-deps
	$(REBAR) compile

clean :
	rm -rf ebin
