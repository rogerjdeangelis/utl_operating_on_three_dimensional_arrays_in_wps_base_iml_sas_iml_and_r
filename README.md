# utl_operating_on_three_dimensional_arrays_in_wps_base_iml_sas_iml_and_r
Operating on three dimensional arrays in wps base iml sas iml and R. Keywords: sas sql join merge big data analytics macros oracle teradata mysql sas communities stackoverflow statistics artificial inteligence AI Python R Java Javascript WPS Matlab SPSS Scala Perl C C# Excel MS Access JSON graphics maps NLP natural language processing machine learning igraph DOSUBL DOW loop stackoverflow SAS community.

    Operating on three dimensional arrays in wps base iml sas iml and R
    
    See a better solution by Rick
    for dealing with higer order matricies in SAS/IML on
    the end of this post.

    Rick Wicklin
    rick.wicklin@sas.com  

    Same results in SAS/IML, WPS/BASE/IML and R

    github
    https://tinyurl.com/yb5pcstl
    https://github.com/rogerjdeangelis/utl_operating_on_three_dimensional_arrays_in_wps_base_iml_sas_iml_and_r

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
    run;quit;
    ');
    
        *____  _      _
    |  _ \(_) ___| | __
    | |_) | |/ __| |/ /
    |  _ <| | (__|   <
    |_| \_\_|\___|_|\_\

    ;

    There are several old ways of dealing with multivariate arrays in SAS/IML,
    but the 14.2 release of SAS/IML introduced "lists," which you can think of as
    a dynamic array of other objects. The recent 14.3 release (SAS 9.4M4, Nov 2017)
    introduced syntax for the natural manipulation of lists. The following example in
    SAS/IML 14.3 packs three matrices into a list and then uses a DO loop
     to iterate through the arrays and perform the elementwise multiplication in your example:

    proc iml;
    val1={
      1 5 ,
      3 7  };
    val2={
      2 6,
      4 8 };
    val3={
      -1 2,
      1 -3};

    L = [val1, val2, val3];  /* create list (array) of matrices */
    result = j(2,2,1);  /* base case is {1 1, 1 1} */
    do i = 1 to ListLen(L);
       result = result # L$i;
    end;
    print result;

    /* compare with manual computation */
    check = val1 # val2 # val3;
    print check;

    I presented papers on lists at the last two SAS Global Forums.

    Some resources, for those who are interested in learning more:
    Getting Started example from Doc chapter on Lists and in-memory Tables:
    (Basically the same as Roger's example)
    http://go.documentation.sas.com/?docsetId=imlug&docsetVersion=14.3&docsetTarget=imlug_lists_gettingstarted02.htm&locale=en

    First blog post: https://blogs.sas.com/content/iml/2017/03/29/lists-sasiml.html
    Natural syntax: https://blogs.sas.com/content/iml/2018/01/22/iml-lists-syntax.html
    Named lists and passing lists to functions:
    https://blogs.sas.com/content/iml/2018/01/24/pass-lists-to-sas-iml-functions.html

    Anyone who is interested in statistical programming, statistical
    graphics, matrix computations, and SAS/IML is invited to read or subscribe to my blog:
    https://blogs.sas.com/content/iml/
    Some of my topics are similar to the "how to do [cool thing] in Python or R"
    topics that Roger posts, except I use SAS.




