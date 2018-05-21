Operating on three dimensional arrays in wps base iml sas iml and R

github
https://tinyurl.com/yb5pcstl
https://github.com/rogerjdeangelis/utl_operating_on_three_dimensional_arrays_in_wps_base_iml_sas_iml_and_r

Same results in SAS/IML, WPS/BASE/IML and R

Although I am using just a 2 x 2 x 2 array the technique extends
to larger three dimensional arrays.

The datatep and R can process arrays of greater dimensions, but IML cannot.
WPS/BASE/IML and SAS/IML are restricted to 2 dimensional matrices?


INPUT
=====

  val1={
      1 5 ,
      3 7  };

  val2={
      2 6,
      4 8 };

EXAMPLE OUTPUT

RES

     [,1] [,2]      Elementwise mutiplication

[1,]    2   30      2 = val1[1,1] * val2[1,1]
[2,]   12   56



PROCESS
=======

 1.  SAS/IML and WPS/BASE/IML

     %macro iml(dummy); * dummy needed to create local symbol table;
     proc iml;

       val1={
           1 5 ,
           3 7  };
       val2={
           2 6,
           4 8 };
       res={ . .,
             . . };
       res=val1

       %do i=2 %to 2;
         # val&i
       %end;
       ;

       print res;

     ;quit;
     %mend iml;

     %iml;

  2. WPS/PROC R (working code)

     mat[1,,] * mat[2,,];

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;
    all date is internal
*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __  ___
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|
\__ \ (_) | | |_| | |_| | (_) | | | \__ \
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/

;

WPS and SAS

%utl_submit_wps64('
     %macro iml(dummy); * dummy needed to create local symbol table;
     proc iml;

       val1={
           1 5 ,
           3 7  };
       val2={
           2 6,
           4 8 };
       res={ . .,
             . . };
       res=val1

       %do i=2 %to 2;
         # val&i
       %end;
       ;

       print res;

     ;quit;
     %mend iml;

     %iml;

run;quit;
');

%utl_submit_wps64('
libname sd1 "d:/sd1";
options set=R_HOME "C:/Program Files/R/R-3.3.2";
proc r;
submit;
source("C:/Program Files/R/R-3.3.1/etc/Rprofile.site", echo=T);
mat  <- array(1:8, dim=c(2,2,2));
mat[1,,] * mat[2,,];
endsubmit;
*import r=         data=;
run;quit;
');

