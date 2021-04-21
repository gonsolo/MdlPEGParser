all:
	swift run
	#swift build
e: edit
edit:
	vi Sources/MdlPEGParser/main.swift
c: clean
clean:
	rm -f Package.resolved
