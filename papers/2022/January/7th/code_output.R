#SUMMARY OF THE DATASET
>summary(iot_dataset)
     ...1            Label             ts                te                td          
 Min.   :     0   Min.   :0.0000   Length:359967     Length:359967     Length:359967    
 1st Qu.: 89992   1st Qu.:1.0000   Class1:hms        Class1:hms        Class1:hms       
 Median :179983   Median :1.0000   Class2:difftime   Class2:difftime   Class2:difftime  
 Mean   :179983   Mean   :0.9962   Mode  :numeric    Mode  :numeric    Mode  :numeric   
 3rd Qu.:269975   3rd Qu.:1.0000                                                        
 Max.   :359966   Max.   :1.0000                                                        
      sa                 da                  sp              dp             pr           
 Length:359967      Length:359967      Min.   :    0   Min.   :    0   Length:359967     
 Class :character   Class :character  
   1st Qu.:13564   1st Qu.:   23   Class :character  
 Mode  :character   Mode  :character   Median :31445   Median :   23   Mode  :character  
                                       Mean   :31032   Mean   : 2082                     
                                       3rd Qu.:48101   3rd Qu.:   81                     
                                       Max.   :65535   Max.   :65535                     
     flg                 fwd         stos        ipkt               ibyt               opkt  
 Length:359967      Min.   :0   Min.   :0   Min.   :    1.00   Min.   :      20   Min.   :0  
 Class :character   1st Qu.:0   1st Qu.:0   1st Qu.:    1.00   1st Qu.:      40   1st Qu.:0  
 Mode  :character   Median :0   Median :0   Median :    1.00   Median :      40   Median :0  
                    Mean   :0   Mean   :0   Mean   :    3.63   Mean   :    1710   Mean   :0  
                    3rd Qu.:0   3rd Qu.:0   3rd Qu.:    1.00   3rd Qu.:      40   3rd Qu.:0  
                    Max.   :0   Max.   :0   Max.   :96808.00   Max.   :79230123   Max.   :0  
      obyt         in         out         sas         das         dir          cl   
 Min.   :0   Min.   :0   Min.   :0   Min.   :0   Min.   :0   Min.   :0   Min.   :0  
 1st Qu.:0   1st Qu.:0   1st Qu.:0   1st Qu.:0   1st Qu.:0   1st Qu.:0   1st Qu.:0  
 Median :0   Median :0   Median :0   Median :0   Median :0   Median :0   Median :0  
 Mean   :0   Mean   :0   Mean   :0   Mean   :0   Mean   :0   Mean   :0   Mean   :0  
 3rd Qu.:0   3rd Qu.:0   3rd Qu.:0   3rd Qu.:0   3rd Qu.:0   3rd Qu.:0   3rd Qu.:0  
 Max.   :0   Max.   :0   Max.   :0   Max.   :0   Max.   :0   Max.   :0   Max.   :0  
       sl          al         ra           
 Min.   :0   Min.   :0   Length:359967     
 1st Qu.:0   1st Qu.:0   Class :character  
 Median :0   Median :0   Mode  :character  
 Mean   :0   Mean   :0                     
 3rd Qu.:0   3rd Qu.:0                     
 Max.   :0   Max.   :0  