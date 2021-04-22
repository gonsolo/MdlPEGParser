all:
	swift run MdlPEGParser Data/test.mdl
t: test
test:
	swift test
e: edit
edit:
	vi Sources/MdlPEGParser/main.swift
d:
	vi Data/test.mdl
c: clean
clean:
	rm -f Package.resolved
