all :
	erl -pa ../deps/*/ebin \
	-noshell \
	-eval "protobuffs_compile:scan_file(\"src/interface.proto\"), init:stop()."
	mkdir ebin include
	mv *.beam ebin/
	mv *.hrl include/

clean :
	rm -rf ebin include
