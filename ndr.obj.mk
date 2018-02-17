SRCDIR := $(NBE_ROOT)/$S

.PHONY: build
build: $(HDRS) $(SRCS)

.PHONY: depset
depset: mkdir $(HDRS)

mkdir:
	#Output directories pre-init
	@[ -d $(NBE_INCPATH) ] || mkdir -p $(NBE_INCPATH)
	@[ -d $(NBE_MK_INCPATH) ] || mkdir -p $(NBE_MK_INCPATH)
	@[ -d $(NBE_MK_OBJPATH) ] || mkdir -p $(NBE_MK_OBJPATH)
	@[ -d $(NBE_MK_OBJPATH)/$(OBJ) ] || mkdir -p $(NBE_MK_OBJPATH)/$(OBJ)

$(HDRS):
	@cp -f $(SRCDIR)/$@ $(NBE_MK_INCPATH)

$(SRCS):
	@gcc -c $(SRCDIR)/$@ -I$(NBE_INCPATH) -I$(NBE_MK_INCPATH) $(CFLAGS) $(EXTRA_CFLAGS)
	@cp -f $(basename $@).o $(NBE_MK_OBJPATH)/$(OBJ)/