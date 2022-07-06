01072020
this project is to log data using xml server from Beckhoff
cycle time is 10ms
the output xml file contains Header and datapart

to change informations in Header: change initial value in DUT xmlHeader
to change values in datapart: change in POU write_to_Buffer
to check the created xml files: go into 'C:\temp_Yizhen\timestamp.TEST.xml'

it is made up of 2 functions: continuously logging and event-based logging
to change function: change variable Mode in MAIN

continuously logging:
the output file contains 100 records with 10 value every record, output file is created every 1s, with the name of the last record's timestamp

Event-based logging:
the output file is created when a up-trigger of variable event in POU DataLoggingEvent is detected
It records the 20 Value before the event and 20 value after the event
files name is made up of the last record's timestamp
to aktivate the event: change variable event in POU DataLoggingEvent

p.s. Datasource of this project is a TcCOM Object made from Simulink Model. 
Move the Model-folder room_heating_2206 to C:\TwinCAT\3.1\CustomConfig\Modules to intergrate it (only for programming process).
It is a control system for room heating. after about 17 min it becomes stable.
Change initial values in GVL.