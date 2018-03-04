SUBDIRS := $(wildcard mains/*/.)

.PHONY : all clean allclean $(SUBDIRS)
all : $(SUBDIRS)

$(SUBDIRS) :
	$(MAKE) -C $@

clean : allclean

allclean :
	for dir in $(SUBDIRS) ; do \
		$(MAKE) -C $$dir $@ ;\
	done
