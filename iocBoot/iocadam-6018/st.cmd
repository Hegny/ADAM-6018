#!../../bin/linux-x86_64/adam-6018

## You may have to change adam-6018 to something else
## everywhere it appears in this file

< envPaths

#Set names for debugging. Comment it out if you put it as parameters (e.g. in Docker)
epicsEnvSet("P", "PINK:")
epicsEnvSet("R", "ADAM:")
epicsEnvSet("DEVIP", "10.42.0.94")
epicsEnvSet("DEVPORT", "502")

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/adam-6018.dbd"
adam_6018_registerRecordDeviceDriver pdbbase

# Use the following commands for TCP/IP
#drvAsynIPPortConfigure(const char *portName,
#                       const char *hostInfo,
#                       unsigned int priority,
#                       int noAutoConnect,
#                       int noProcessEos);
# This line is for Modbus TCP
drvAsynIPPortConfigure("adam","$(DEVIP):$(DEVPORT)",0,0,1)

#modbusInterposeConfig(const char *portName,
#                      modbusLinkType linkType,
#                      int timeoutMsec, 
#                      int writeDelayMsec)
# This line is for Modbus TCP
modbusInterposeConfig("adam",0,2000,0)

# Read the 8 channels of an ADAM4018+ module at slave address 0 
# There are 8 holding registers that correspond to the 8 channels (0-8), starting at modbus address=40001.
# EPICS uses offset addresses, so 40001 = 0, 04002 = 1, etc.
 
#drvModbusAsynConfigure(char *portName, char *octetPortName, int slaveAddress, int modbusFunction,
#                       int modbusStartAddress, int modbusLength, modbusDataType dataType,
#                       int pollMsec, char *plcType)

# drvModbusAsynConfigure(     "portName", "tcpPortName", slaveAddress, modbusFunction, modbusStartAddress, modbusLength, dataType, pollMsec, "plcType")
drvModbusAsynConfigure(	   "In_Channels",        "adam",            0,              4,                  0,            8,        0,     1000,    "ADAM")
drvModbusAsynConfigure(       "In_Types",        "adam",            0,              4,                200,            8,        0,     1000,    "ADAM")
drvModbusAsynConfigure(      "Out_Types",        "adam",            0,              6,                200,            8,        0,     1000,    "ADAM")

# Registers 40201 - 40208 are used to define thermocouples types
#Thermocouples types and temperature range:
# Type Value LO    HI
# J    1024  0     760
# K    1056  0     1370
# T    1088  -100  400
# E    1120  0     1000
# R    1152  500   1750
# S    1184  500   1750
# B    1216  500   1800


## Load record instances

cd "${TOP}/iocBoot/${IOC}"

#Example to read raw 16-bit data for channel 1
#dbLoadRecords("$(MODBUS)/db/longinInt32.template", "P=${P}, R=${R}CH_01, PORT=In_Channels, OFFSET=0, DATA_TYPE=UINT16, SCAN=1 second") #1

#Example to read Thermocouple Type for channel 1
#dbLoadRecords("$(MODBUS)/db/longinInt32.template", "P=${P}, R=${R}Type_01, PORT=In_Types, OFFSET=0, DATA_TYPE=UINT16, SCAN=1 second") #1

#Example to set Thermocouple Type for channel 1
#dbLoadRecords("$(MODBUS)/db/longoutInt32.template", "P=${P}, R=${R}TypeSet_01, PORT=Out_Types, OFFSET=0, DATA_TYPE=UINT16") #1

#Load template for every readout channel with all necessary records
dbLoadRecords("./adam-6018.db", "P=$(P), R=$(R), N=01, PORT1=In_Channels, PORT2=In_Types, PORT3=Out_Types, OFFSET=0, DATA_TYPE=UINT16, SCAN=1 second") #1
dbLoadRecords("./adam-6018.db", "P=$(P), R=$(R), N=02, PORT1=In_Channels, PORT2=In_Types, PORT3=Out_Types, OFFSET=1, DATA_TYPE=UINT16, SCAN=1 second") #2
dbLoadRecords("./adam-6018.db", "P=$(P), R=$(R), N=03, PORT1=In_Channels, PORT2=In_Types, PORT3=Out_Types, OFFSET=2, DATA_TYPE=UINT16, SCAN=1 second") #3
dbLoadRecords("./adam-6018.db", "P=$(P), R=$(R), N=04, PORT1=In_Channels, PORT2=In_Types, PORT3=Out_Types, OFFSET=3, DATA_TYPE=UINT16, SCAN=1 second") #4
dbLoadRecords("./adam-6018.db", "P=$(P), R=$(R), N=05, PORT1=In_Channels, PORT2=In_Types, PORT3=Out_Types, OFFSET=4, DATA_TYPE=UINT16, SCAN=1 second") #5
dbLoadRecords("./adam-6018.db", "P=$(P), R=$(R), N=06, PORT1=In_Channels, PORT2=In_Types, PORT3=Out_Types, OFFSET=5, DATA_TYPE=UINT16, SCAN=1 second") #6
dbLoadRecords("./adam-6018.db", "P=$(P), R=$(R), N=07, PORT1=In_Channels, PORT2=In_Types, PORT3=Out_Types, OFFSET=6, DATA_TYPE=UINT16, SCAN=1 second") #7
dbLoadRecords("./adam-6018.db", "P=$(P), R=$(R), N=08, PORT1=In_Channels, PORT2=In_Types, PORT3=Out_Types, OFFSET=7, DATA_TYPE=UINT16, SCAN=1 second") #8

iocInit

## Start any sequence programs
