include $(THEOS)/makefiles/common.mk

ADDITIONAL_OBJCFLAGS = -fobjc-arc
TWEAK_NAME = CopyMapsDestination
CopyMapsDestination_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk