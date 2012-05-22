abbreviator
===========

abbreviator creates a TextExpander out of a list of words.


Prerequisities:
===============

The file you want to convert needs to be named `abbreviations.csv`.

abbreviations.csv
=================

The comma separated values list contains a list of words in the form:

	"abbreviation";"expansion";"adapt setting"

Fields should be delimited by `;`, enclosed in double quotes `"`. The third column can be one of the following three things:

1. sensitive: Case sensitive expansion
2. insensitive: Case insensitive expansion
3. addapt: Adapt to case

Uage:
=====

Simply run from the command line:

	ruby abbreviator.rb

After the script has completed you should have a abbreviations.textexpander file in the folder, which you can just double click to import into TextExpander.

