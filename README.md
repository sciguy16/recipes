# recipes
A collection of delicious recipes


## Structure of this repository
Each recipe is broadly classified into either `main` or `dessert`, and then in an appropriately named directory.
The recipe directory contains three files:

* `title.txt` the title for the recipe
* `description.txt` a text file containing a description of the recipe, e.g. number of people served. Acts as a bit of a README
* `ingredients.txt` list of ingredients
* `method.txt` one step per line, list of instructions

## How to use/build

Your system must have access to `pdflatex` and GNU Make.
There are two supported use cases: building all of the recipe PDFs in one go, or building them individually.

### Build all at once
* Run `make` in the the root directory of this repo to build all of the recipes
* Running `make clean` will delete everything that `make` made and resets everything back to how it was before the call to `make`.

### Build an individual recipe
* Run `make makefiles` in the root directory to populate the recipe directories with symlinks to the recipe makefile
* Navigate to the directory containing the recipe that you want to build and run `make`
* `make clean` will delete the temporary files but not the recipe.pdf, and `make allclean` will delete everything that `make` made
