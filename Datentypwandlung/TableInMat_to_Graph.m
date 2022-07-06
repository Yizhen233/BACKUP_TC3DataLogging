load('2020-08-12-07-46-09-831ATEST.mat');
testData = table2timetable(Table);
testData=sortrows(testData);                       %Tabelle nach Zeit sortieren

%% Block: Daten nach bestimmten Zeitraum und Raumnummer ausnehmen
tr=timerange(datetime('12/08/2020 00:00','format','dd/MM/yyyy HH:mm'),datetime('12/08/2020 01:00','format','dd/MM/yyyy HH:mm'));
timelimitedData=testData;
%timelimitedData=testData(tr,:);                              %Daten nach bestimmten Zeitraum ausnehmen
%room1Data=timelimitedData(timelimitedData.room == '1',:);    %Daten nach bestimmten Raumnummer ausnehmen
room1Data=timelimitedData;
%% Block: Fehlende und doppelte Daten identifizieren und löschen
room1Data=rmmissing(room1Data);                              %fehlende Daten lösen
[C,ia]=unique(room1Data.timestamp);                               %doppelte Daten inklusiv unterschiede Werte löschen
room1Data=room1Data(ia,:);
%room1Data=unique(room1Data);                                %doppelte
%Daten löschen
%% Block: anderes Zyklus und Werte
num=vartype('numeric');                                      %Zyklus als Tag für nummer daily/minutely/secondly/hourly/weekly/monthly/yearly/quarterly
weeklyroom1Data=retime(room1Data(:,num),'weekly','mean');    %sum/mean/prod/min/max/count/first-/lastvalue/prrevious/next/nearest
cate=vartype('categorical');                                 %Zyklus als Tag für categorical 
weeklyroom1Data=[retime(room1Data(:,cate),'weekly','lastvalue'),weeklyroom1Data]; %zusammenführen
%% Block: Diagramm anzeigen-von 1 csv datei-verschiedene Einheiten 
figure;
yyaxis left;                                                 %links y-Achse
plot(room1Data.timestamp,room1Data.roomtemp1);         %Linie zeigen
ylim([16 18]);                                               %Bereich y-Achse
ylabel('indoor temperature (\circ C)');
yyaxis right;
plot(room1Data.timestamp,room1Data.watertemp);
ylim([19 21]);
ylabel('watertank temperature (\circ C)');
title('value after controlling of room1 in 12.08.2020');
xlim([min(room1Data.timestamp) max(room1Data.timestamp)]);
xtickformat('hh:mm:ss.SSS');                                              %Form der x-koordinate dd-MM-yyyy HH:mm:ss
%xticks(min(room1Data.time):7:max(room1Data.time));     %x-Achse Wertintervall
%% Block: Diagramm anzeigen-von 1 csv datei-gleiche Einheiten
% figure
% plot(room1Data.time,room1Data.indoor_T,'DisplayName','room1');
% hold on                                                            %hold: ohne Schließen des geöffneten Figure-Fensters Linie zu Diagramm einfügen
% plot(room2Data.time,room2Data.indoor_T,'DisplayName','room2');     %Legende einfügen mit 'DisplayName' config
% hold off
% ylabel('indoor temperature (\circ C)');
% title('indoor temperature of room1 and room2 in 03.2020-04.2020');
% xlim([min(room1Data.time) max(room1Data.time)]);
% ylim([20 30]);
% xtickformat('dd-MM');
% xticks(min(room1Data.time):6:max(room1Data.time));
% legend('boxoff')                                                   %ohne Legende Box
% %% Block:timetable2 einfügen
% test2=readtable('test02.csv');                  %csv Datei zu Tabelle
% testData2=table2timetable(test2);                                  %timetable for room2 einfügen
% testData2=sortrows(testData2);                     
% %testData2.room=categorical(testData2.room,(1:2));   
% timelimitedData2=testData2(tr,:); 
% room1Data2=timelimitedData2;
% %room1Data2=timelimitedData2(timelimitedData2.room == '1',:);    
% %% Block: 2 timetables zusammenfügen
% synroom1Data=synchronize(room1Data,room1Data2,'Union');            %Union/Intersection/Uniform
% %disp(synroom1Data);
% %% Block: Diagramm anzeigen-von 2 csv datei 
% figure;
% yyaxis left;
% Proom1outdoor=plot(synroom1Data.time,synroom1Data.T_room,'-o');    %Marker als o, index zu linie geben 
% ylim([0 30]);
% ylabel('indoor temperature (\circ C)');
% yyaxis right;
% plot(synroom1Data.time,synroom1Data.T_outside);          
% ylim([0 30]);
% ylabel('outdoor temperature (\circ C)');
% title('indoor and outdoor temperature of room1 in 04.2020');
% xlim([min(synroom1Data.time) max(synroom1Data.time)]);
% xtickformat('hh:mm:ss');
% %xticks(min(synroom1Data.time):6:max(synroom1Data.time));

