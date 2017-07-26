CC :=gcc
LD :=g++
SRCDIR := src
BUILDDIR := build
TARGETDIR:= bin
TARGET :=bin/runner

SRCEXT:=c
SOURCES:=$(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS:=$(patsubst $(SRCDIR)/%, $(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
DEP:=$(OBJECTS:%.o=%.dep)
CFLAGS:= 
LDFLAGS:= 
INC:= -I include

$(TARGET):$(OBJECTS)
	@echo "Linking..."
	mkdir -p bin
	@echo "$(LD) $^ -o $(TARGET) $(LIB)"
	$(LD) -o $(TARGET)  $^ $(LDFLAGS) 
-include $(DEP)
$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	mkdir -p $(sort $(dir $(OBJECTS))) 
	$(CC) $(CFLAGS) $(INC) -MM -MT $@ -MF $(patsubst %.o, %.dep, $@) $<
	$(CC) $(CFLAGS) $(INC) -c -o $@ $<
#$(CC) $(CFLAGS)  -MMD -MP -march=native -c -o $@ $<
clean:
	@echo "cleaning...";
	$(RM) -r $(BUILDDIR) $(TARGETDIR)
.PHONY:clean
