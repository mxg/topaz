#-------------------------------------------------------------------------------
#                  .
#                .o8
#              .o888oo  .ooooo.  oo.ooooo.   .oooo.     oooooooo
#                888   d88' `88b  888' `88b `P  )88b   d'""7d8P
#                888   888   888  888   888  .oP"888     .d8P'
#                888 . 888   888  888   888 d8(  888   .d8P'  .P
#                "888" `Y8bod8P'  888bod8P' `Y888""8o d8888888P
#                                 888
#                                o888o
#
#                  T O P A Z   P A T T E R N   L I B R A R Y
#
#     TOPAZ is a library of SystemVerilog and UVM patterns and idioms.  The
#     code is suitable for study and for copying/pasting into your own work.
#
#    Copyright 2023 Mark Glasser
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#-------------------------------------------------------------------------------

include make/tools.mk

# Set V to "@" to minimize output from make. Set it to empty to see
# the gory details of each command.
V	= @

all: clean build run doc

DOALL	= ./bin/do_all.sh
DOC	= topaz

# Build all the examples
build:
	${V}${DOALL} build

# Execute all the examples
run:
	${V}${DOALL} run

# Print a list of all the examples
list:
	${V}./bin/list.sh -x

# Generate text and pdf documentation.  The doc source is the
# readme.md files in each example.
doc: text pdf

text:
	${V}echo "[GEN] Text document"
	${V}cat doc/title.txt > ${DOC}.txt
	${V}cat doc/intro.tex >> ${DOC}.txt
	${V}${DOALL} readme >> ${DOC}.txt

# Assemble the latex document
latex:
	${V}echo "[GEN] LaTeX document"
	${V}cat doc/preamble.tex > ${DOC}.tex
	${V}${DOALL} latex >> ${DOC}.tex
	${V}cat doc/postamble.tex >> ${DOC}.tex

# Convert .tex file to .pdf
_pdf: latex
	${V}latex ${DOC}.tex >  doc.log 2>&1
	${V}latex ${DOC}.tex >> doc.log 2>&1
	${V}dvips ${DOC}.dvi >> doc.log 2>&1
	${V}ps2pdf ${DOC}.ps >> doc.log 2>&1

pdf: _pdf clean_latex
	${V}echo "[GEN] PDF document"

# Clean up all the examples and docs
clean: clean_doc
	${V}${DOALL} clean

clean_latex:
	${V}rm -f ${DOC}.tex
	${V}rm -f xx* *~
	${V}rm -f *.aux *.log *.ps *.dvi

clean_pdf: clean_latex
	${V}rm -f *.pdf

clean_doc: clean_pdf clean_latex
	${V}rm -f ${DOC}.txt
