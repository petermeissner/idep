---
title: "Code book"
author: "pm"
date: '2015-07-31 13:59:15'
output:
  pdf_document:
    keep_tex: yes
    number_sections: yes
  html_document:
    keep_md: yes
    number_sections: yes
    self_contained: no
---





# The reforms dataset (version 1.12)
The data-set is based on the IDEP data - data on Standing Orders versions (*texts*), data on Standing Orders Text (*textlines*) and data on Standing Orders change between versions (*linelinkage*). Information from all three sources are aggregated on Standing Orders version level - i.e. each version has its own line in the data-set. This aggregation allows for studying what happened - in an aggregate - at each reform of Standing Orders. 

The data set incorporates aggregated data for 
770 reforms in
15 countries and consists of 
225 variables. 

**Example:**


```r
reforms  %>% 
  select(t_id, wds_clean_rel, wds_chg, pro_min, pro_maj, wds_corp_agg_1)
```

```
## Source: local data frame [786 x 6]
## 
##                t_id wds_clean_rel wds_chg pro_min pro_maj wds_corp_agg_1
## 1  AUT_1928-02-01.0          7802       0      NA      NA           2530
## 2  AUT_1948-06-04.0          7907     242       0       1           2523
## 3  AUT_1961-09-01.0          9103    3983      17       5           2832
## 4  AUT_1975-10-01.0         13558   11307      36      23           4242
## 5  AUT_1976-07-01.0         13676      78       1       0           4318
## 6  AUT_1979-10-01.0         13826     454       2       0           4356
## 7  AUT_1986-09-01.0         14225    1036       3       4           4454
## 8  AUT_1989-01-01.0         16910    6094      33      24           4772
## 9  AUT_1993-09-15.0         18295    3002      15      16           4951
## 10 AUT_1996-10-15.0         20639    5712      20      29           5332
## ..              ...           ...     ...     ...     ...            ...
```

# Shortcuts 

**SP** is short for subparagraph and in most cases identical to **line** or text line due to the fact that sub-paragraphs have in the data gathering process been transfered (from PDFs and Word documents and the like) to simple text files in which each sub-paragraph was put on a single line and on one single line only.

**SO** is short for Standing Orders (rules of procedure) and usually refers to one particular version of Standing Orders in force in a particular country from a particular time point on. 



# General variable name shortcuts

**wds** is short for words, like the number of words within a SP. 

**lns** is short for lines an equivalent to SP. 

**rel** is short for relevant, like whether or not a SP contains relevant information or can be  dismissed as headline, blank-line, comment, appendix or some other not relevant part of the text (the opposite usually is **all**)

**raw** versus **clean** denote whether or not the SP was used as found in the official documents or cleaned up. Cleaned SPs have been stripped by their enumeration (only at the start of the SP), thus pure changes of enumeration (only at the start of the SP) are not considered as changes nor are they counted as relevant content. 

**ins**, **del**, **mdf**, **non**: denote the type of change that occurred for a particular SP - insertion, deletion, modification and no-change. The shorthand **chg** is for change and refers to all three possible forms that change might come by. 

**pro_...** indicate minority/majority codings, e.g. *pro_min* indicates how many SPs were changed in a way considered minority friendly. 


# Shortcuts indicating their raw data sets 

**db_** and **int_** denote variables that have to do with the database that serves as basis for all data-sets and are most likely not relevant to the user. 

**t_** information on text or Standing Orders version level, e.g. the data when a particular standing order was accepted, the country it belongs to or total number of words of the  version, ... .

**tl_** information on text lines aka SPs, e.g whether or not a SP is relevant, how many words it contains, it's corpus code, ... .


**ll_** information on the what happened to SPs from one version to the next - e.g. was it changed or deleted. 

Other shortcuts or variable names missing the above mentioned shortcuts indicate that those variables have been computed from other variables and most likely were result from some form of aggregation. See below for more detailed descriptions. 


# Variable descriptions










## meta



**t_id** (texts)

Unique identifier of a SO version by including country shorthand, date, and version counter.

```r
   Length     Class      Mode 
      786 character character 

```


<p>&nbsp;</p>\vspace{1em}

**t_date** (texts)

Date of the SO version - equals to (according to availibility) enactment, promulgation, acceptance.

```r
   Length     Class      Mode 
      786 character character 

```


<p>&nbsp;</p>\vspace{1em}

**t_dplus** (texts)

Version counter that is zero under normal circumstances but might be higher if more than one version got enacted on the same date.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.1272  0.0000  4.0000 

```


<p>&nbsp;</p>\vspace{1em}

**t_country** (texts)

Country shorthand. In case of Swiss two seperate shorthands exist because there SO are spread among two bodies.

```r
   Length     Class      Mode 
      786 character character 

```


<p>&nbsp;</p>\vspace{1em}

**t_daccept** (texts)

Date on which the SO were accepted, voted upon, decided upon, ... .

```r
   Length     Class      Mode 
      786 character character 

```


<p>&nbsp;</p>\vspace{1em}

**t_dpromul** (texts)

Date on which the SO were promulgated - made puplic, printed, published, ... .

```r
   Length     Class      Mode 
      786 character character 

```


<p>&nbsp;</p>\vspace{1em}

**t_denact** (texts)

Date on which the SO were enacted - came into force / took effect.

```r
   Length     Class      Mode 
      786 character character 

```


<p>&nbsp;</p>\vspace{1em}
## db



**int_dupdate_texts** (db)

Date at which the 'texts' table of the database was last updated.

```r
   Length     Class      Mode 
      786 character character 

```


<p>&nbsp;</p>\vspace{1em}

**int_id_texts** (db)

Database internal enumeration of SO - this might change at any time. Do **not** use this as an id variable.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    1.0   396.2   592.5   564.8   788.8  1010.0 

```


<p>&nbsp;</p>\vspace{1em}

**db_version** (db)

Version of the database which was used to create the data set. On every change the version number goes up by 0.01 - there is no distinction between major and minor version.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   1.11    1.11    1.11    1.11    1.11    1.11 

```


<p>&nbsp;</p>\vspace{1em}

**db_lastupdate** (db)

Date at which the database was last updated.

```r
   Length     Class      Mode 
      786 character character 

```


<p>&nbsp;</p>\vspace{1em}
## length



**lns_all** (textlines)

Number of lines - also known as sub paragraphs - within a particular SO.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   88.0   375.2   618.0   671.8   863.2  2645.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_raw_all** (textlines)

Number of words within a particular SO.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   2318   10500   13990   16920   22290   61400 

```


<p>&nbsp;</p>\vspace{1em}

**wds_clean_all** (textlines)

Number of words within a particular SO after having striped away enumerations like, a), b), ..., 1., 2., ... I, II, ... and so forth.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   2236   10170   13600   16300   21490   59630 

```


<p>&nbsp;</p>\vspace{1em}

**lns_rel** (textlines)

Number of lines that contain relevant content - e.g. no blank lines, no headlines, no appendices.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   38.0   289.2   405.0   472.4   596.0  1242.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_raw_rel** (textlines)

Number of words that are not from irrelevant lines - e.g. no blank lines, no headlines, no appendices.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   2122   10150   13340   16220   21520   43050 

```


<p>&nbsp;</p>\vspace{1em}

**wds_clean_rel** (textlines)

Number of words that are not from irrelevant lines - e.g. no blank lines, no headlines, no appendices - after having striped away enumerations like, a), b), ..., 1., 2., ... I, II, ... and so forth.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   2122    9918   13030   15750   20900   41490 

```


<p>&nbsp;</p>\vspace{1em}
## change



**lns_mdf** (textlines)

Number of lines that were mofified - i.e. changed but not deleted or inserted.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.00    1.00    3.00   16.91   11.00  583.00      16 

```


<p>&nbsp;</p>\vspace{1em}

**wds_mdf** (textlines)

Number of words modified - i.e. changed but not deleted or inserted.

```r
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
    0.00     7.25    58.00   375.80   234.80 12270.00       16 

```


<p>&nbsp;</p>\vspace{1em}

**wds_ins** (textlines, linelinkage)

Number of words that were inserted into SO.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    0.0     0.0    67.0   341.0   281.5 11250.0      16 

```


<p>&nbsp;</p>\vspace{1em}

**lns_ins** (textlines, linelinkage)

Number of lines that were inserted into SO.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.00    0.00    2.00   11.17    8.00  375.00      16 

```


<p>&nbsp;</p>\vspace{1em}

**wds_del** (textlines, linelinkage)

Number of words that were deleted from old SO.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    0.0     0.0     0.0   128.9    44.5  6059.0      16 

```


<p>&nbsp;</p>\vspace{1em}

**lns_del** (textlines, linelinkage)

Number of lines that were deleted from old SO.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
  0.000   0.000   0.000   4.253   2.000 229.000      16 

```


<p>&nbsp;</p>\vspace{1em}

**lns_chg** (textlines, linelinkage)

Number of lines that were changed from the old SO to the current - i.e. the sum of insertions, deletions and modifikations.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     3.0     9.0    31.9    25.0   778.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_chg** (textlines, linelinkage)

Number of words that were changed from the old SO to the current - i.e. the sum of insertions, deletions and modifikations.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    66.0   251.5   837.0   700.8 23370.0 

```


<p>&nbsp;</p>\vspace{1em}
## minority/majority



**pro_maj_mdf** (textlines, linelinkage)

Number of lines modified that were coded as majority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
 0.0000  0.0000  0.0000  0.4964  0.0000 32.0000      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_min_mdf** (textlines, linelinkage)

Number of lines modified that were coded as minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
 0.0000  0.0000  0.0000  0.5494  0.0000 25.0000      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_non_mdf** (textlines, linelinkage)

Number of lines modified that were coded as neither majority nor minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    0.0     1.0     3.0    16.4    10.0   583.0      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_maj_mdf** (textlines, linelinkage)

Number of words modified that were coded as majority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.00    0.00    0.00   19.81    0.00 4008.00      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_min_mdf** (textlines, linelinkage)

Number of words modified that were coded as minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.00    0.00    0.00   18.45    0.00 1162.00      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_non_mdf** (textlines, linelinkage)

Number of words modified that were coded as neither majority nor minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    0.0     5.0    57.0   343.3   219.0 11880.0      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_maj_ins** (textlines, linelinkage)

Number of lines inserted that were coded as majority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
 0.0000  0.0000  0.0000  0.4292  0.0000 38.0000      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_min_ins** (textlines, linelinkage)

Number of lines inserted that were coded as minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
 0.0000  0.0000  0.0000  0.3577  0.0000 17.0000      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_non_ins** (textlines, linelinkage)

Number of lines inserted that were coded as neither majority nor minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
  0.000   0.000   1.000   9.811   7.000 317.000      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_maj_ins** (textlines, linelinkage)

Number of words inserted that were coded as majority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.00    0.00    0.00   15.65    0.00 1439.00      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_min_ins** (textlines, linelinkage)

Number of words inserted that were coded as minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.00    0.00    0.00   16.83    0.00  601.00      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_non_ins** (textlines, linelinkage)

Number of words inserted that were coded as neither majority nor minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    0.0     0.0    52.0   308.3   246.5 11110.0      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_maj_del** (textlines, linelinkage)

Number of lines deleted that were coded as majority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
 0.0000  0.0000  0.0000  0.0887  0.0000 25.0000      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_min_del** (textlines, linelinkage)

Number of lines deleted that were coded as minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
0.00000 0.00000 0.00000 0.05866 0.00000 7.00000      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_non_del** (textlines, linelinkage)

Number of lines deleted that were coded as neither majority nor minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
  0.000   0.000   0.000   3.737   1.000 229.000      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_maj_del** (textlines, linelinkage)

Number of words deleted that were coded as majority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
  0.000   0.000   0.000   3.914   0.000 980.000      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_min_del** (textlines, linelinkage)

Number of words deleted that were coded as minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
  0.000   0.000   0.000   1.936   0.000 192.000      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_non_del** (textlines, linelinkage)

Number of words deleted that were coded as neither majority nor minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    0.0     0.0     0.0   118.5    39.0  5992.0      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_maj** (linelinkage)

Number of lines coded as majority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
  0.000   0.000   0.000   1.014   0.000  44.000      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_min** (linelinkage)

Number of lines coded as minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
 0.0000  0.0000  0.0000  0.9657  1.0000 37.0000      87 

```


<p>&nbsp;</p>\vspace{1em}

**pro_non** (linelinkage)

Number of lines coded as neither majority nor minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.00    3.00    9.00   29.95   24.00  778.00      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_maj** (textlines, linelinkage)

Number of words coded as majority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.00    0.00    0.00   39.37    0.00 4022.00      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_min** (textlines, linelinkage)

Number of words coded as minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.00    0.00    0.00   37.21    6.00 1680.00      87 

```


<p>&nbsp;</p>\vspace{1em}

**wds_pro_non** (textlines, linelinkage)

Number of words coded as neither majority nor minority friendly.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    0.0    62.0   232.0   770.1   662.0 22840.0      87 

```


<p>&nbsp;</p>\vspace{1em}
## raw corpus codes



**lns_corp_8** (textlines)

Number of lines with corpus code 8   

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   1.000   5.000   5.144   8.000  22.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_9** (textlines)

Number of lines with corpus code 9   

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   1.107   1.000  12.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_10** (textlines)

Number of lines with corpus code 10  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    6.00    9.00   14.97   19.00  162.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_21** (textlines)

Number of lines with corpus code 21  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   4.337   7.000  35.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_22** (textlines)

Number of lines with corpus code 22  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    1.00   13.00   19.53   37.00   65.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_23** (textlines)

Number of lines with corpus code 23  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   2.244   1.000  29.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_25** (textlines)

Number of lines with corpus code 25  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    3.00   11.01   15.00   80.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_26** (textlines)

Number of lines with corpus code 26  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   2.000   6.429   9.000  44.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_27** (textlines)

Number of lines with corpus code 27  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.7748  0.0000  9.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_28** (textlines)

Number of lines with corpus code 28  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.5814  0.0000 32.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_29** (textlines)

Number of lines with corpus code 29  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   23.49   14.75  245.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_31** (textlines)

Number of lines with corpus code 31  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.8779  0.7500 18.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_32** (textlines)

Number of lines with corpus code 32  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   2.724   2.000  27.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_33** (textlines)

Number of lines with corpus code 33  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   1.004   0.000   9.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_34** (textlines)

Number of lines with corpus code 34  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   1.000   4.000   5.592   7.000  37.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_43** (textlines)

Number of lines with corpus code 43  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   1.274   1.000  16.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_45** (textlines)

Number of lines with corpus code 45  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.8333  0.0000 34.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_51** (textlines)

Number of lines with corpus code 51  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    10.0    14.0    19.6    19.0   110.0 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_52** (textlines)

Number of lines with corpus code 52  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   2.383   2.000  32.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_53** (textlines)

Number of lines with corpus code 53  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00   11.00   20.00   22.03   28.00   89.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_54** (textlines)

Number of lines with corpus code 54  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   5.000   6.454  10.000  49.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_55** (textlines)

Number of lines with corpus code 55  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    4.00    8.00   10.74   13.00   67.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_56** (textlines)

Number of lines with corpus code 56  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    8.00   12.00   12.86   14.00   61.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_66** (textlines)

Number of lines with corpus code 66  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.1132  0.0000  1.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_67** (textlines)

Number of lines with corpus code 67  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   0.813   0.000   7.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_68** (textlines)

Number of lines with corpus code 68  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   1.000   3.000   7.748   8.000  47.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_71** (textlines)

Number of lines with corpus code 71  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   1.415   2.000  25.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_72** (textlines)

Number of lines with corpus code 72  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   0.617   1.000   6.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_73** (textlines)

Number of lines with corpus code 73  

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   0.883   0.000  20.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_111** (textlines)

Number of lines with corpus code 111 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   2.000   4.191   4.000  32.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_112** (textlines)

Number of lines with corpus code 112 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   2.000   3.000   4.453   6.000  28.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_113** (textlines)

Number of lines with corpus code 113 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    2.00    7.00    8.16   11.00   31.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_114** (textlines)

Number of lines with corpus code 114 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.7176  1.0000 12.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_121** (textlines)

Number of lines with corpus code 121 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   4.000   6.486  10.000  49.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_122** (textlines)

Number of lines with corpus code 122 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   5.000   6.081   8.000  26.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_123** (textlines)

Number of lines with corpus code 123 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   2.00   12.00   20.00   23.65   28.75   67.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_124** (textlines)

Number of lines with corpus code 124 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   1.702   3.000   9.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_125** (textlines)

Number of lines with corpus code 125 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   5.000   7.000   7.435   9.000  22.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_131** (textlines)

Number of lines with corpus code 131 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   1.000   1.953   2.000  13.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_132** (textlines)

Number of lines with corpus code 132 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   1.000   1.536   2.000  10.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_133** (textlines)

Number of lines with corpus code 133 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   1.000   1.969   2.000  11.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_134** (textlines)

Number of lines with corpus code 134 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   4.000   7.000   7.494  10.000  22.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_141** (textlines)

Number of lines with corpus code 141 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.4618  0.0000  6.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_142** (textlines)

Number of lines with corpus code 142 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   2.000   5.545   6.000  47.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_143** (textlines)

Number of lines with corpus code 143 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.8868  0.0000 13.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_144** (textlines)

Number of lines with corpus code 144 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.3461  0.0000  6.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_145** (textlines)

Number of lines with corpus code 145 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.3397  0.0000 15.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_241** (textlines)

Number of lines with corpus code 241 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00    1.84    3.00   24.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_242** (textlines)

Number of lines with corpus code 242 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   5.557   3.000  48.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_243** (textlines)

Number of lines with corpus code 243 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.1298  0.0000  4.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_244** (textlines)

Number of lines with corpus code 244 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   0.841   0.000  29.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_411** (textlines)

Number of lines with corpus code 411 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   1.771   0.000  46.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_412** (textlines)

Number of lines with corpus code 412 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   2.444   5.000  22.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_421** (textlines)

Number of lines with corpus code 421 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.3715  0.0000 15.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_422** (textlines)

Number of lines with corpus code 422 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.1679  0.0000  6.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_441** (textlines)

Number of lines with corpus code 441 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.00000 0.00000 0.00000 0.08397 0.00000 4.00000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_442** (textlines)

Number of lines with corpus code 442 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.2519  0.0000  5.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_611** (textlines)

Number of lines with corpus code 611 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    6.00   15.00   29.04   38.75  200.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_612** (textlines)

Number of lines with corpus code 612 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    5.00   11.00   13.94   16.00   60.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_613** (textlines)

Number of lines with corpus code 613 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   3.000   6.000   6.724   9.000  32.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_631** (textlines)

Number of lines with corpus code 631 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    1.00    2.17    3.00   13.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_632** (textlines)

Number of lines with corpus code 632 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    8.00   25.00   27.01   40.00  164.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_633** (textlines)

Number of lines with corpus code 633 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   2.000   3.000   4.168   6.000  24.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_634** (textlines)

Number of lines with corpus code 634 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    5.00    7.00   12.01   14.00   39.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_636** (textlines)

Number of lines with corpus code 636 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   1.000   3.000   4.253   6.000  21.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_637** (textlines)

Number of lines with corpus code 637 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   5.416   5.000  78.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_638** (textlines)

Number of lines with corpus code 638 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.9949  0.0000 20.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_639** (textlines)

Number of lines with corpus code 639 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     5.0     9.0    28.1    31.0   211.0 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_641** (textlines)

Number of lines with corpus code 641 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   1.000   2.499   5.000  12.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_642** (textlines)

Number of lines with corpus code 642 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   1.102   1.000  30.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_643** (textlines)

Number of lines with corpus code 643 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.6527  1.0000  6.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_651** (textlines)

Number of lines with corpus code 651 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    4.00    6.00   10.41   13.00   56.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_652** (textlines)

Number of lines with corpus code 652 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   3.000   6.000   7.426   8.000  67.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_653** (textlines)

Number of lines with corpus code 653 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.5267  1.0000  7.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_999** (textlines)

Number of lines with corpus code 999 

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   7.642   1.000 188.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_6211** (textlines)

Number of lines with corpus code 6211

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   4.000   7.000   9.383  10.000  36.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_6212** (textlines)

Number of lines with corpus code 6212

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   2.000   6.000   6.931   8.000  72.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_6221** (textlines)

Number of lines with corpus code 6221

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   2.000   2.453   4.000  13.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_6222** (textlines)

Number of lines with corpus code 6222

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   2.000   3.218   4.000  16.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_6351** (textlines)

Number of lines with corpus code 6351

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.2723  0.0000  6.0000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_6352** (textlines)

Number of lines with corpus code 6352

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   1.000   1.559   2.000   7.000 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_8** (textlines)

Number of words with corpus code 8    - see lns_corp_8    for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    38.0   148.0   179.0   298.8   729.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_9** (textlines)

Number of words with corpus code 9    - see lns_corp_9    for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   33.02   13.00  633.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_10** (textlines)

Number of words with corpus code 10   - see lns_corp_10   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   194.0   358.0   432.2   452.0  3566.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_21** (textlines)

Number of words with corpus code 21   - see lns_corp_21   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0     0.0   127.3   258.0   885.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_22** (textlines)

Number of words with corpus code 22   - see lns_corp_22   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   137.0   537.0   815.3  1499.0  2938.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_23** (textlines)

Number of words with corpus code 23   - see lns_corp_23   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   94.98   53.00  777.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_25** (textlines)

Number of words with corpus code 25   - see lns_corp_25   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0       0     190     369     457    1942 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_26** (textlines)

Number of words with corpus code 26   - see lns_corp_26   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0    70.0   254.3   376.0  2217.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_27** (textlines)

Number of words with corpus code 27   - see lns_corp_27   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   32.16    0.00  475.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_28** (textlines)

Number of words with corpus code 28   - see lns_corp_28   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   15.29    0.00  775.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_29** (textlines)

Number of words with corpus code 29   - see lns_corp_29   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0     0.0   867.2   495.0  8107.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_31** (textlines)

Number of words with corpus code 31   - see lns_corp_31   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   22.72   20.25  426.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_32** (textlines)

Number of words with corpus code 32   - see lns_corp_32   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   90.25   64.00  861.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_33** (textlines)

Number of words with corpus code 33   - see lns_corp_33   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   33.08    0.00  268.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_34** (textlines)

Number of words with corpus code 34   - see lns_corp_34   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    64.0   106.0   171.8   236.0   860.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_43** (textlines)

Number of words with corpus code 43   - see lns_corp_43   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   36.17   34.00  335.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_45** (textlines)

Number of words with corpus code 45   - see lns_corp_45   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   28.82    0.00 1001.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_51** (textlines)

Number of words with corpus code 51   - see lns_corp_51   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   465.0   560.0   619.1   778.0  1649.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_52** (textlines)

Number of words with corpus code 52   - see lns_corp_52   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0     0.0    98.6   170.0  1025.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_53** (textlines)

Number of words with corpus code 53   - see lns_corp_53   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   495.0   749.0   788.9   943.5  2691.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_54** (textlines)

Number of words with corpus code 54   - see lns_corp_54   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0   208.0   228.1   418.0  1106.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_55** (textlines)

Number of words with corpus code 55   - see lns_corp_55   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   146.0   262.0   348.3   464.0  1851.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_56** (textlines)

Number of words with corpus code 56   - see lns_corp_56   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   254.0   370.0   428.2   589.8  1340.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_66** (textlines)

Number of words with corpus code 66   - see lns_corp_66   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   4.642   0.000  41.000 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_67** (textlines)

Number of words with corpus code 67   - see lns_corp_67   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   16.81    0.00  137.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_68** (textlines)

Number of words with corpus code 68   - see lns_corp_68   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    16.0   112.0   189.1   172.0  1093.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_71** (textlines)

Number of words with corpus code 71   - see lns_corp_71   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   46.43   85.00  588.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_72** (textlines)

Number of words with corpus code 72   - see lns_corp_72   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   21.06   28.00  148.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_73** (textlines)

Number of words with corpus code 73   - see lns_corp_73   for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   18.57    0.00  296.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_111** (textlines)

Number of words with corpus code 111  - see lns_corp_111  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00   64.00   99.37  106.00  651.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_112** (textlines)

Number of words with corpus code 112  - see lns_corp_112  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    64.0   167.0   144.6   176.0   522.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_113** (textlines)

Number of words with corpus code 113  - see lns_corp_113  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    96.5   237.0   269.8   368.0   806.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_114** (textlines)

Number of words with corpus code 114  - see lns_corp_114  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0     0.0    25.7    23.0   635.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_121** (textlines)

Number of words with corpus code 121  - see lns_corp_121  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0   169.0   229.3   316.8  1536.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_122** (textlines)

Number of words with corpus code 122  - see lns_corp_122  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0       0     139     223     277    1189 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_123** (textlines)

Number of words with corpus code 123  - see lns_corp_123  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   80.0   463.8   659.0   791.2   885.0  2366.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_124** (textlines)

Number of words with corpus code 124  - see lns_corp_124  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0     0.0   107.9   264.0   498.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_125** (textlines)

Number of words with corpus code 125  - see lns_corp_125  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   177.0   284.0   343.4   416.0  1073.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_131** (textlines)

Number of words with corpus code 131  - see lns_corp_131  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00   35.00   73.17   88.00  636.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_132** (textlines)

Number of words with corpus code 132  - see lns_corp_132  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00   43.50   66.71   86.00  435.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_133** (textlines)

Number of words with corpus code 133  - see lns_corp_133  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00   22.00   79.38  108.00  489.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_134** (textlines)

Number of words with corpus code 134  - see lns_corp_134  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   177.0   233.0   259.6   333.0   761.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_141** (textlines)

Number of words with corpus code 141  - see lns_corp_141  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   18.49    0.00  187.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_142** (textlines)

Number of words with corpus code 142  - see lns_corp_142  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0    74.0   214.3   274.0  1359.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_143** (textlines)

Number of words with corpus code 143  - see lns_corp_143  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   34.65    0.00  555.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_144** (textlines)

Number of words with corpus code 144  - see lns_corp_144  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   8.571   0.000 136.000 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_145** (textlines)

Number of words with corpus code 145  - see lns_corp_145  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   16.92    0.00  857.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_241** (textlines)

Number of words with corpus code 241  - see lns_corp_241  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   71.37   96.75 1348.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_242** (textlines)

Number of words with corpus code 242  - see lns_corp_242  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0     0.0   157.1    64.0  1310.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_243** (textlines)

Number of words with corpus code 243  - see lns_corp_243  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   4.749   0.000  84.000 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_244** (textlines)

Number of words with corpus code 244  - see lns_corp_244  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   31.46    0.00  927.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_411** (textlines)

Number of words with corpus code 411  - see lns_corp_411  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   51.68    0.00 1435.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_412** (textlines)

Number of words with corpus code 412  - see lns_corp_412  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   73.03  148.00  629.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_421** (textlines)

Number of words with corpus code 421  - see lns_corp_421  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   14.04    0.00  391.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_422** (textlines)

Number of words with corpus code 422  - see lns_corp_422  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   4.062   0.000 170.000 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_441** (textlines)

Number of words with corpus code 441  - see lns_corp_441  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   2.156   0.000  99.000 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_442** (textlines)

Number of words with corpus code 442  - see lns_corp_442  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   7.669   0.000 142.000 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_611** (textlines)

Number of words with corpus code 611  - see lns_corp_611  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0     191     375    1144    1431    6791 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_612** (textlines)

Number of words with corpus code 612  - see lns_corp_612  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   137.8   455.0   521.0   695.0  2221.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_613** (textlines)

Number of words with corpus code 613  - see lns_corp_613  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    98.0   202.0   226.4   306.0   842.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_631** (textlines)

Number of words with corpus code 631  - see lns_corp_631  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00   17.00   71.68  100.00  518.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_632** (textlines)

Number of words with corpus code 632  - see lns_corp_632  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   258.0   497.0   564.8   870.8  1313.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_633** (textlines)

Number of words with corpus code 633  - see lns_corp_633  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    55.0   115.0   134.3   210.0   790.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_634** (textlines)

Number of words with corpus code 634  - see lns_corp_634  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   122.0   222.0   388.2   469.2  1288.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_636** (textlines)

Number of words with corpus code 636  - see lns_corp_636  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    47.0   119.5   153.2   213.0   878.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_637** (textlines)

Number of words with corpus code 637  - see lns_corp_637  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0     0.0   173.5   177.0  2444.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_638** (textlines)

Number of words with corpus code 638  - see lns_corp_638  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   31.17    0.00  649.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_639** (textlines)

Number of words with corpus code 639  - see lns_corp_639  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   180.0   299.0   856.4   956.0  6014.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_641** (textlines)

Number of words with corpus code 641  - see lns_corp_641  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00   30.00   80.38  137.00  439.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_642** (textlines)

Number of words with corpus code 642  - see lns_corp_642  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   32.93   42.00  508.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_643** (textlines)

Number of words with corpus code 643  - see lns_corp_643  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   25.67   28.00  202.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_651** (textlines)

Number of words with corpus code 651  - see lns_corp_651  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   108.0   239.0   403.5   372.0  2439.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_652** (textlines)

Number of words with corpus code 652  - see lns_corp_652  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   122.0   183.0   242.4   262.0  2080.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_653** (textlines)

Number of words with corpus code 653  - see lns_corp_653  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   21.17   23.00  328.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_999** (textlines)

Number of words with corpus code 999  - see lns_corp_999  for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   30.48    1.00  757.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_6211** (textlines)

Number of words with corpus code 6211 - see lns_corp_6211 for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0   154.0   221.0   331.3   382.0  1308.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_6212** (textlines)

Number of words with corpus code 6212 - see lns_corp_6212 for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0    83.0   214.0   229.5   378.2  1060.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_6221** (textlines)

Number of words with corpus code 6221 - see lns_corp_6221 for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00   51.00   74.87  128.00  312.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_6222** (textlines)

Number of words with corpus code 6222 - see lns_corp_6222 for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0    64.0   112.3   149.0   598.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_6351** (textlines)

Number of words with corpus code 6351 - see lns_corp_6351 for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   10.39    0.00  179.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_6352** (textlines)

Number of words with corpus code 6352 - see lns_corp_6352 for more information.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00   17.00   52.93   80.00  323.00 

```


<p>&nbsp;</p>\vspace{1em}
## aggregated corpus codes



**lns_corp_agg_1** (textlines)

Number of lines with aggregated corpus code 1 - lawmaking.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    9.0    59.0    74.0    83.4    99.0   192.0 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_2** (textlines)

Number of lines with aggregated corpus code 2 - special decission rules.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00   20.00   36.00   69.49   88.00  342.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_3** (textlines)

Number of lines with aggregated corpus code 3 - elections.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    9.00   17.84   35.00   98.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_4** (textlines)

Number of lines with aggregated corpus code 4 - government control.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   1.00   24.00   33.00   40.71   54.00  164.00 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_5** (textlines)

Number of lines with aggregated corpus code 5 - puplicity

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    7.0    61.0    81.0    95.3   123.0   290.0 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_6** (textlines)

Number of lines with aggregated corpus code 6 - not relevant

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   0.000   7.642   1.000 188.000 

```


<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_7** (textlines)

Number of lines with aggregated corpus code 7 - not applicaple

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     21     104     130     158     185     464 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_1** (textlines)

Number of words with aggregated corpus code 1 - lawmaking.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    638    2020    2596    3006    3555    7885 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_2** (textlines)

Number of words with aggregated corpus code 2 - special decission rules.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0     574    1489    2574    3109   11360 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_3** (textlines)

Number of words with aggregated corpus code 3 - elections.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0   311.0   582.9  1019.0  2478.0 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_4** (textlines)

Number of words with aggregated corpus code 4 - government control.

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     16     940    1340    1421    1701    5511 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_5** (textlines)

Number of words with aggregated corpus code 5 - puplicity

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    223    1837    2636    3385    4598   10350 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_6** (textlines)

Number of words with aggregated corpus code 6 - not relevant

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   30.48    1.00  757.00 

```


<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_7** (textlines)

Number of words with aggregated corpus code 7 - not applicaple

```r
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   1010    3066    3995    4746    5970   13980 

```


<p>&nbsp;</p>\vspace{1em}






















