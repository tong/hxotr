
## hxotr

LIB=otr
NDLL_FLAGS=
ARCH = $(shell sh -c 'uname -m 2>/dev/null || echo not')
ifeq ($(ARCH),x86_64)
	OS=Linux64
	NDLL_FLAGS+=-DHXCPP_M64
else
	OS=Linux
endif
NDLL = ndll/$(OS)/$(LIB).ndll

all: ndll

$(NDLL): res/sys/*.cpp res/sys/build.xml
	@echo "Building ndll for $(OS)"
	@(cd res/sys;haxelib run hxcpp build.xml $(NDLL_FLAGS);)
ndll: $(NDLL)

$(LIB).zip: clean
	zip -r $@ res/ src/ haxelib.json README.md -x "*_*" "*.o"

haxelib: otr.zip

install: haxelib
	haxelib local $(LIB).zip

uninstall:
	haxelib remove $(LIB)

clean:
	rm -f $(NDLL)
	rm -f $(LIB).zip
	rm -rf res/sys/obj

.PHONY: all ndll haxelib install uninstall clean
