options nocenter ps=64 ls=96;

data meso15;
    infile "C:Knapp_lab_experiment_data.csv" dlm='2C0D'x dsd missover lrecl=10000 firstobs=2;
    input frogid $ tank frognum day week ZE weight svl sex $
        frogsource $ bdsource $ frogpersistent bdpersistent logZE1;
    x = week-8;             /* center weeks  */
    x2 = x**2;              /* centered weeks squared */
    cSVL = svl - 51.3204;   /* center SVL (frog length) */
run;

/*************************************************************************************/
/*    Determine the best random effects model using method = REML,                   */
/*    while including all of the possible fixed effects variables.                   */
/*************************************************************************************/


/*************************************************************************************/
/*    The best random effects model includes correlated errors, including a          */
/*    first-order autoregressive model AR(1):                                        */
/*************************************************************************************/


proc mixed data=meso15 method=reml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource tank frogid sex;
    model logZE1 = frogpersistent bdsource frogpersistent*bdsource cSVL x x2 sex / ddfm=satterth s;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
    LSMEANS frogpersistent;
    LSMEANS bdsource;
    LSMEANS frogpersistent*bdsource;
    LSMEANS sex;
run;


/*************************************************************************************/
/*    Re-fit this best random effects model with method=ml to fit Fixed Effects      */
/*************************************************************************************/

proc mixed data=meso15 method=ml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource tank frogid sex;
    model logZE1 = frogpersistent bdsource frogpersistent*bdsource cSVL x x2 sex / ddfm=satterth s;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
    LSMEANS frogpersistent;
    LSMEANS bdsource;
    LSMEANS frogpersistent*bdsource;
    LSMEANS sex;
run;


/*************************************************************************************/
/*    The best-fit Fixed Effects model using method=ML                               */
/*    includes frogpersistent, bdsource, week, and week^2, and sex                   */
/*************************************************************************************/


proc mixed data=meso15 method=ml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource frogid;
    model logZE1 = frogpersistent bdsource x x2 / ddfm=satterth s;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
    LSMEANS frogpersistent;
    LSMEANS bdsource;
run;


/*************************************************************************************/
/*    Try removing bdsource from best-fit Fixed Effects model                        */
/*************************************************************************************/

proc mixed data=meso15 method=ml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource frogid;
    model logZE1 = frogpersistent x x2 / ddfm=satterth s;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
    LSMEANS frogpersistent;
    LSMEANS bdsource;
run;


/*  Likelihood ratio test to show that bdsource has a significant effect */
data LRT;
    dev1 = 774.4;     /* deviance for full model */
    dev2 = 794.8;     /* deviance without bdsource */

    /* The difference between the deviances will follow a chi-squared distribution  */
    /* with degrees of freedom equal to the difference in the number of parameters  */
    /* between the full and reduced models.                                         */
    chi = dev2 - dev1;
    thisdf = 3;
    p = 1-probchi(chi,thisdf);  /* calculate the p-value from a chi-squared distribution */
run;

proc print data=LRT;
    TITLE 'Likelihood ratio test comparing full model with and without bdsource';
run;


/*************************************************************************************/
/*    Try removing frogpersistent from best-fit Fixed Effects model                  */
/*************************************************************************************/

proc mixed data=meso15 method=ml alpha=.05 covtest IC;
    class frogpersistent bdpersistent frogsource frogid;
    model logZE1 = bdsource x x2 / ddfm=satterth s;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
    LSMEANS frogpersistent;
    LSMEANS bdsource;
run;


/*  Likelihood ratio test to show that frogpersistent has a significant effect */
data LRT;
    dev1 = 774.4;     /* deviance for full model */
    dev2 = 800.5;     /* deviance without frogpersistent */

    /* The difference between the deviances will follow a chi-squared distribution  */
    /* with degrees of freedom equal to the difference in the number of parameters  */
    /* between the full and reduced models.                                         */
        chi = dev2 - dev1;
    thisdf = 3;
    p = 1-probchi(chi,thisdf);  /* calculate the p-value from a chi-squared distribution */
run;

proc print data=LRT;
    TITLE 'Likelihood ratio test comparing full model with and without frogpersistent';
run;


/*************************************************************************************/
/*    Try removing x (week) and x^2 from best-fit Fixed Effects model                */
/*************************************************************************************/

proc mixed data=meso15 method=ml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource frogid;
    model logZE1 = frogpersistent bdsource / ddfm=satterth s;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
    LSMEANS frogpersistent;
    LSMEANS bdsource;
run;


/*  Likelihood ratio test to show that x (week) has a significant effect */
data LRT;
    dev1 = 774.4;     /* deviance for full model */
    dev2 = 813.1;     /* deviance without x and x^2 */

    /* The difference between the deviances will follow a chi-squared distribution  */
    /* with degrees of freedom equal to the difference in the number of parameters  */
    /* between the full and reduced models.                                         */
    chi = dev2 - dev1;
    thisdf = 2;
    p = 1-probchi(chi,thisdf);  /* calculate the p-value from a chi-squared distribution */
run;

proc print data=LRT;
TITLE 'Likelihood ratio test comparing full model with and without x^2';
run;

/*************************************************************************************/
/*    Try leaving in x, but removing x^2, from best-fit Fixed Effects model          */
/*************************************************************************************/

proc mixed data=meso15 method=ml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource frogid;
    model logZE1 = frogpersistent bdsource x / ddfm=satterth s;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
    LSMEANS frogpersistent;
    LSMEANS bdsource;
run;


/*  Likelihood ratio test to show that x (week) has a significant effect */
data LRT;
    dev1 = 774.4;     /* deviance for full model */
    dev2 = 778.4;     /* deviance without x^2 */

    /* The difference between the deviances will follow a chi-squared distribution  */
    /* with degrees of freedom equal to the difference in the number of parameters  */
    /* between the full and reduced models.                                         */
    chi = dev2 - dev1;
    thisdf = 1;
    p = 1-probchi(chi,thisdf);  /* calculate the p-value from a chi-squared distribution */
run;

proc print data=LRT;
    TITLE 'Likelihood ratio test comparing full model with and without x and x^2';
run;


/*************************************************************************************/
/*    Present the results of best-fit model using method = REML                      */
/*************************************************************************************/

proc mixed data=meso15 method=reml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource frogid;
    model logZE1 = frogpersistent bdsource x x2 / ddfm=satterth s noint;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
    LSMEANS frogpersistent;
    LSMEANS bdsource;
    run;

  
/*************************************************************************************/
/*   To compare models:                                                              */
/*   Calculate AIC for model with: frogpersistent/bdsource                           */
/*************************************************************************************/

proc mixed data=meso15 method=ml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource tank frogid sex;
    model logZE1 = frogpersistent bdsource x x2 / ddfm=satterth s noint;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
run;

/*************************************************************************************/
/*   To compare models:                                                              */
/*   Calculate AIC for model with: frogsource/bdsource                               */
/*************************************************************************************/

proc mixed data=meso15 method=ml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource tank frogid sex;
    model logZE1 = frogsource bdsource x x2 / ddfm=satterth s noint;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
run;

/*************************************************************************************/
/*   To compare models:                                                              */
/*   Calculate AIC for model with: frogpersistent/bdpersistent                       */
/*************************************************************************************/

proc mixed data=meso15 method=reml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource tank frogid sex;
    model logZE1 = frogpersistent bdpersistent x x2 / ddfm=satterth s;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
run;

/*************************************************************************************/
/*   To compare models:                                                              */
/*   Calculate AIC for model with: frogsource/bdpersistent                           */
/*************************************************************************************/

proc mixed data=meso15 method=reml alpha=.05 covtest IC;
    class frogpersistent bdpersistent bdsource frogsource tank frogid sex;
    model logZE1 = frogsource bdpersistent x x2 / ddfm=satterth s;
    repeated / type=ar(1) subject=frogid  group=bdpersistent r;
run;




