SRCDIR := $(NBE_ROOT)/$S
LDFLAGS += --as-needed

.PHONY: build
build: $(DEPLIBS) $(EXTOBJS) $(SRCS) lkapp mvapp

.PHONY: depset
depset: mkdir $(HDRS)

mkdir::
	#Output directories pre-init
	@[ -d $(NBE_DBGPATH) ] || mkdir -p $(NBE_DBGPATH)
	@[ -d $(NBE_INCPATH) ] || mkdir -p $(NBE_INCPATH)
	@[ -d $(NBE_MK_INCPATH) ] || mkdir -p $(NBE_MK_INCPATH)
	@[ -d $(NBE_MK_OBJPATH) ] || mkdir -p $(NBE_MK_OBJPATH)
	@[ -d $(NBE_LIBPATH) ] || mkdir -p $(NBE_LIBPATH)
	@[ -d $(NBE_APPPATH) ] || mkdir -p $(NBE_APPPATH)

$(HDRS):: ;

$(DEPLIBS):
	$(eval LIBLIST += $(addprefix -l,$@))

$(EXTOBJS):
	$(eval EXTLIST += $(wildcard  $(NBE_MK_OBJPATH)/$@/*.o))

$(SRCS)::
	@gcc -c $(SRCDIR)/$@ -I$(NBE_INCPATH) -I$(NBE_MK_INCPATH) $(CFLAGS) $(EXTRA_CFLAGS)
	@cp -f $(basename $@).o  $(NBE_MK_OBJPATH)
	$(eval SRCLIST += $(basename $@).o)

lkapp:
	@gcc -o $(APP) $(EXTLIST) $(SRCLIST) -L$(NBE_LIBPATH) $(LIBLIST) $(NBE_LIBS)

mvapp:
	@mv -f $(APP) $(NBE_APPPATH)
