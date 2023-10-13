# ADAM-6018
EPICS drivers for ADAM-6018+ MODBUS thermocouple DAQ module

2023 Yegor "Hegny" Tamashevich

The project contains:
I. EPICS IOC
II. CSS (Phoebus) displays

# Requirements
- EPICS (developed at version 3.15.9)
- ASYN module for EPICS (developed at version R4-44-2)
- MODBUS module for EPICS (developed at version R3-2)
- ADAM-6018+ module with known IP adress.

# I. to start the IOC
1. change the paths to dependent modules in ./configure/RELEASE
	SUPPORT = /home/hegny/EPICS/support 	#put here the path to support folder of EPICS
	MODBUS=$(SUPPORT)/modbus-R3-2		#put here the path to MODBUS module	
	ASYN = $(SUPPORT)/asyn-R4-44-2		#put here the path to ASYN module
2. run make in the main IOC folder

3. edit ./iocBoot/iocadam-6018/st.cmd
	epicsEnvSet("P", "PINK:")		#change to desired record prefix
	epicsEnvSet("R", "ADAM:")		#change to desired device name
	epicsEnvSet("DEVIP", "10.42.0.94")	#change to actual ADAM-6018+ IP address
	epicsEnvSet("DEVPORT", "502")		#this is default MODBUS port
comment out these lines if you use this IOC with Docker and provide these values as parameters
At the end of the same file you will find 8 entries for 8 channels. You can change the SCAN time if needed and comment out not required channels.
There are also commented out examples for a simple readout of the raw values without using of adam-6018.db
	
# II. to use the CS-Studio displays
1. Load the main display from ./opi/bob/adam-6018.bob
2. Every channel is an Embedded Display (template is located in ./opi/bob/adam-6018template.bob)
3. In the main display go to the properties of every Embedded Display and in the string Macros change macros for P and R to the same values as you put in ./iocBoot/iocadam-6018/st.cmd

# III. Notes
Adam-6018+ does not provide temperature values outside the range predefined for each thermocouple type.
 Type Code  LO T  HI T
 J    1024  0     760
 K    1056  0     1370
 T    1088  -100  400
 E    1120  0     1000
 R    1152  500   1750
 S    1184  500   1750
 B    1216  500   1800
It means, there is no way to measure directly, for example, temperatures below 0C with K-type thermocouple.

To change the thermocouple type you can use CSS Display or directly put desired Type Code in (P)(R)TypeSet_(N) variable. 
The thermocouple type is stored inside ADAM-6018+, so you need to set it up only once.
The IOC reads out raw temperature values and thermocouple type and calculates the temperature value based on the type and temperature ranges.
