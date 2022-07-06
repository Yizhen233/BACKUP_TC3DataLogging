26062020
this project is to record the performance of xml server from Beckhoff
cycle time is 10ms
the example contains 100 records with 10 value every record
the output xml file contains Header and datapart

to change informations in Header: change initial value in DUT xmlHeader
to change values in datapart: change in POU write_to_Buffer

to change the number of values in datapart: 
1. change the range of POU XMLTesten/VAR Buffer
2. change the number of m in POU XMLTesten/line 15
3. change the range of POU write_to_XML/VAR LogInput
4. add the value of new variable in POU write_to_Buffer

to see how long it takes for the writing process
to buffer: POU XMLTesten/VAR WriteTimeDiff or in the output xml file/WriteTimeDiffHeader
to xml file: POU write_to_XML/VAR WriteTimeDiff

