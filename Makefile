all:
	@#swift run MdlPEGParser Data/test.mdl
	swift run MdlPEGParser Data/gun_metal.mdl
	gimp fortyTwo.pbm
t: test
test:
	swift test
e: edit
edit:
	vi Sources/MdlPEGParser/main.swift
d:
	#vi Data/test.mdl
	vi Data/gun_metal.mdl
b:
	vi Data/gun_metal.mdl Data/test.mdl
c: clean
clean:
	rm -f Package.resolved
