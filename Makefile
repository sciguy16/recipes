# List the directories corresponding to the categories of food and wildcard
# over the food within each category
SUBDIRS := $(wildcard mains/*/)
# Each food directory should have its own symlink to the recipeMakefile
MAKEFILES := $(SUBDIRS:=Makefile)

.PHONY : all clean allclean $(SUBDIRS) $(MAKEFILES)
all : $(SUBDIRS)

# The subdirs target depends on having Makefiles everywhere
$(SUBDIRS) : $(MAKEFILES)
	# Recursively call make on each food
	$(MAKE) -C $@

$(MAKEFILES) :
	# if the symlink does not already exist then make it so. Note that the
	# default shell is `sh`->`dash` rather than `bash`, so the [[ command is not
	# permitted, hence the use of the single [
	# This call to ln works because $@ is substituted for the current target
	# (i.e. "category/food/Makefile")
	[ -f $@ ] || ln -s ../../lib/recipeMakefile $@

# We don't bother setting up a separate call to clean, although we could as it
# is implemented in recipeMakefile
clean : allclean

allclean :
	# Manually call `make allclean` in each directory and then delete the
	# Makefile symlinks
	for dir in $(SUBDIRS) ; do \
		$(MAKE) -C $$dir $@ ;\
		rm -vi $${dir}Makefile ;\
	done
