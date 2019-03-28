all: she_test

# Placeholder for platform specific implementation
she_platform_lib.o: src/she_linux.c
	$(CC) $^  -c -o $@ -I include

she_lib.o: src/she_generic.c
	$(CC) $^  -c -o $@ -I include

she_storage.o: src/she_storage.c
	$(CC) $^  -c -o $@ -I include

she_test: test/she_test.c she_lib.o she_storage.o she_platform_lib.o include/she_api.h
	$(CC) $^  -o $@ -I include -lpthread -lz

clean:
	rm -rf she_test she_lib.o she_platform_lib.o she_storage.o

she_doc: include/she_api.h
	rm -rf doc/latex/
	doxygen doc/she/Doxyfile
	make -C ./doc/latex pdf
	cp doc/latex/refman.pdf doc/she_api_manual.pdf
	rm -rf doc/latex/

hsm_doc: include/hsm/hsm_api.h
	rm -rf doc/latex/
	doxygen doc/hsm/Doxyfile
	make -C ./doc/latex pdf
	cp doc/latex/refman.pdf doc/hsm_api_document.pdf
	rm -rf doc/latex/
