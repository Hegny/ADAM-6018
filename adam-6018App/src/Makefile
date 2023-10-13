TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = adam-6018
# adam-6018.dbd will be created and installed
DBD += adam-6018.dbd

# adam-6018.dbd will be made up from these files:
adam-6018_DBD += base.dbd

# Include dbd files from all support applications:
#adam-6018_DBD += xxx.dbd
adam-6018_DBD += asyn.dbd
adam-6018_DBD += modbusSupport.dbd
adam-6018_DBD += drvAsynIPPort.dbd

# Add all the support libraries needed by this IOC
#adam-6018_LIBS += xxx
adam-6018_LIBS += asyn
adam-6018_LIBS += modbus

# adam-6018_registerRecordDeviceDriver.cpp derives from adam-6018.dbd
adam-6018_SRCS += adam-6018_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
adam-6018_SRCS_DEFAULT += adam-6018Main.cpp
adam-6018_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#adam-6018_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
adam-6018_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

