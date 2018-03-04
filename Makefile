# List the directories corresponding to the categories of food and wildcard
# over the food within each category
SUBDIRS := $(wildcard mains/*/ desserts/*/)
# Each food directory should have its own symlink to the recipeMakefile
MAKEFILES := $(SUBDIRS:=Makefile)

.PHONY : all clean allclean makefiles $(SUBDIRS) $(MAKEFILES)
all : $(SUBDIRS)

# The subdirs target depends on having Makefiles everywhere
$(SUBDIRS) : $(MAKEFILES)
	# Recursively call make on each food
	$(MAKE) -C $@

# This is here so that we can generate the Makefile symlinks without invoking
# the full build process (in the case that we only want to build a specific
# recipe
makefiles : $(MAKEFILES)

$(MAKEFILES) :
	# if the symlink does not already exist then make it so. Note that the
	# default shell is `sh`->`dash` rather than `bash`, so the [[ command is not
	# permitted, hence the use of the single [
	# This call to ln works because $@ is substituted for the current target
	# (i.e. "category/food/Makefile")
	[ -f $@ ] || ln -s ../../lib/recipeMakefile $@

clean :
	# Manually call `make clean` in each directory
	for dir in $(SUBDIRS) ; do \
		$(MAKE) -C $$dir $@ ;\
	done

allclean : clean
	# Depend on the clean target, then wipe all of the Makefile symlinks and
	# generated recipe.pdf outputs
	for dir in $(SUBDIRS) ; do \
		rm -vf $${dir}recipe.pdf $${dir}Makefile ;\
	done
