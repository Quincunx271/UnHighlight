UnHighlight
===========

Firefox extension to strip ?highlight=... from URLs.
This makes it nicer to search the Python docs and CMake docs, among other things.

This extension is currently v0.1 and unstable.
The logic for removing the highlight command is very lax and could end up removing other useful information.
It could also make sense to allow restricting to specified hosts rather than everything (e.g.
only docs.python.org and cmake.org).
