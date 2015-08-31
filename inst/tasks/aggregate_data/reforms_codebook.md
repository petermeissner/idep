---
title: "Code book"
author: "pm"
date: '2015-08-26 12:14:20'
output:
  pdf_document:
    keep_tex: yes
    number_sections: yes
  html_document:
    keep_md: yes
    number_sections: yes
    self_contained: no
---





# The reforms dataset (version 1.71)
The data-set is based on the IDEP data - data on Standing Orders versions (*texts*), data on Standing Orders Text (*textlines*) and data on Standing Orders change between versions (*linelinkage*). Information from all three sources are aggregated on Standing Orders version level - i.e. each version has its own line in the data-set. This aggregation allows for studying what happened - in an aggregate - at each reform of Standing Orders. 

The data set incorporates aggregated data for 
770 reforms in
15 countries and consists of 
237 variables. 

**Example:**


```r
reforms  %>% 
  select(t_id, wds_clean_rel, wds_chg, pro_min, pro_maj, wds_corp_top_1)
```

```
## Source: local data frame [786 x 6]
## 
##                t_id wds_clean_rel wds_chg pro_min pro_maj wds_corp_top_1
## 1  AUT_1928-02-01.0          7802      NA      NA      NA           2530
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

**ADDING FURTHER DESCRIPTION OF REFORM AND TEXT DATA**


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




# General Notes and Remarks


## change measure interpretaion

While SO lengths are given as SP counts (lns) and word counts (wds) and are furthermore subdivided by relevance (rel) and whether or not the word counts are based on raw text or cleaned up text this variance in measures does not exist for changes between SO versions. 
Since all coding and analysis was only pursued on the basis of relevant and cleaned SPs all change measures refer to SPs that were relevant and cleansed from enumerations. 



# Variable descriptions










## 1 meta



**t_id** (texts)

Unique identifier of a SO version by including country shorthand, date, and version counter.

**class:**  character \
<br>**unique:**  786 \
<br>**NAs:**  0 \
<br>**range:** *[ AUT_1928-02-01.0 ]* ... *[ UK_2009-06-25.0 ]* \
<br>**examples:**  *[ IRE_1997-10-21.0 ], [ UK_1990-02-01.0 ], [ LUX_2004-08-05.0 ], [ NOR_2002-01-* ... \
<br>

<p>&nbsp;</p>

**t_date** (texts)

Date of the SO version - equals to (according to availibility) enactment, promulgation, acceptance.

**class:**  character \
<br>**unique:**  702 \
<br>**NAs:**  0 \
<br>**range:** *[ 1903-01-20 ]* ... *[ 2011-07-01 ]* \
<br>**examples:**  *[ 1975-06-24 ], [ 2008-07-17 ], [ 1991-04-15 ], [ 2009-10-06 ], [ 1991-03-21 ],* ... \
<br>

<p>&nbsp;</p>

**t_dplus** (texts)

Version counter that is zero under normal circumstances but might be higher if more than one version got enacted on the same date.

**class:**  integer \
<br>**unique:**  5 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 4 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**t_country** (texts)

Country shorthand. In case of Swiss two seperate shorthands exist because there SO are spread among two bodies.

**class:**  character \
<br>**unique:**  16 \
<br>**NAs:**  0 \
<br>**range:** *[ AUT ]* ... *[ UK ]* \
<br>**examples:**  *[ AUT ], [ BEL ], [ BEL ], [ SWE ], [ FRA ], [ SWE ], [ SWIGRN ], [ NED ], [ UK* ... \
<br>

<p>&nbsp;</p>

**t_daccept** (texts)

Date on which the SO were accepted, voted upon, decided upon, ... .

**class:**  character \
<br>**unique:**  690 \
<br>**NAs:**  38 \
<br>**range:** *[ 1902-10-09 ]* ... *[ 2011-04-28 ]* \
<br>**examples:**  *[ 1983-06-14 ], [ NA ], [ 1980-06-25 ], [ 1999-07-20 ], [ 2001-03-29 ], [ 1997-* ... \
<br>

<p>&nbsp;</p>

**t_dpromul** (texts)

Date on which the SO were promulgated - made puplic, printed, published, ... .

**class:**  character \
<br>**unique:**  313 \
<br>**NAs:**  450 \
<br>**range:** *[ 1902-10-15 ]* ... *[ 2011-04-19 ]* \
<br>**examples:**  *[ 1979-07-12 ], [ NA ], [ NA ], [ NA ], [ 1982-03-17 ], [ NA ], [ 2001-01-23 ],* ... \
<br>

<p>&nbsp;</p>

**t_denact** (texts)

Date on which the SO were enacted - came into force / took effect.

**class:**  character \
<br>**unique:**  303 \
<br>**NAs:**  418 \
<br>**range:** *[ 1903-01-20 ]* ... *[ 2011-07-01 ]* \
<br>**examples:**  *[ 1999-05-04 ], [ NA ], [ NA ], [ 1985-01-01 ], [ 1979-11-01 ], [ 1999-09-28 ],* ... \
<br>

<p>&nbsp;</p>
## 2 db



**int_dupdate_texts** (db)

Date at which the 'texts' table of the database was last updated.

**class:**  character \
<br>**unique:**  19 \
<br>**NAs:**  0 \
<br>**range:** *[ 2015-08-26 11:10:14 ]* ... *[ 2015-08-26 11:45:55 ]* \
<br>**examples:**  *[ 2015-08-26 11:16:57 ], [ 2015-08-26 11:14:33 ], [ 2015-08-26 11:16:57 ], [ 20* ... \
<br>

<p>&nbsp;</p>

**int_id_texts** (db)

Database internal enumeration of SO - this might change at any time. Do **not** use this as an id variable.

**class:**  numeric \
<br>**unique:**  786 \
<br>**NAs:**  0 \
<br>**range:** *[ 1 ]* ... *[ 786 ]* \
<br>**examples:**  *[ 123 ], [ 335 ], [ 290 ], [ 756 ], [ 623 ], [ 330 ], [ 557 ], [ 254 ], [ 191 ]* ... \
<br>

<p>&nbsp;</p>

**db_version** (db)

Version of the database which was used to create the data set. On every change the version number goes up by 0.01 - there is no distinction between major and minor version.

**class:**  numeric \
<br>**unique:**  1 \
<br>**NAs:**  0 \
<br>**range:** *[ 1.71 ]* ... *[ 1.71 ]* \
<br>**examples:**  *[ 1.71 ], [ 1.71 ], [ 1.71 ], [ 1.71 ], [ 1.71 ], [ 1.71 ], [ 1.71 ], [ 1.71 ],* ... \
<br>

<p>&nbsp;</p>

**db_lastupdate** (db)

Date at which the database was last updated.

**class:**  character \
<br>**unique:**  1 \
<br>**NAs:**  0 \
<br>**range:** *[ 2015-08-26 11:47:17 ]* ... *[ 2015-08-26 11:47:17 ]* \
<br>**examples:**  *[ 2015-08-26 11:47:17 ], [ 2015-08-26 11:47:17 ], [ 2015-08-26 11:47:17 ], [ 20* ... \
<br>

<p>&nbsp;</p>
## 3 length



**lns_all** (textlines)

Number of lines - also known as sub paragraphs - within a particular SO.

**class:**  integer \
<br>**unique:**  473 \
<br>**NAs:**  0 \
<br>**range:** *[ 88 ]* ... *[ 2645 ]* \
<br>**examples:**  *[ 1319 ], [ 332 ], [ 385 ], [ 1275 ], [ 1246 ], [ 728 ], [ 811 ], [ 558 ], [ 30* ... \
<br>

<p>&nbsp;</p>

**wds_raw_all** (textlines)

Number of words within a particular SO.

**class:**  integer \
<br>**unique:**  744 \
<br>**NAs:**  0 \
<br>**range:** *[ 2318 ]* ... *[ 61397 ]* \
<br>**examples:**  *[ 20600 ], [ 10495 ], [ 19184 ], [ 17047 ], [ 17730 ], [ 19480 ], [ 15878 ], [ * ... \
<br>

<p>&nbsp;</p>

**wds_clean_all** (textlines)

Number of words within a particular SO after having striped away enumerations like, a), b), ..., 1., 2., ... I, II, ... and so forth.

**class:**  integer \
<br>**unique:**  739 \
<br>**NAs:**  0 \
<br>**range:** *[ 2236 ]* ... *[ 59628 ]* \
<br>**examples:**  *[ 30583 ], [ 18711 ], [ 10438 ], [ 10446 ], [ 11741 ], [ 8118 ], [ 16260 ], [ 2* ... \
<br>

<p>&nbsp;</p>

**lns_rel** (textlines)

Number of lines that contain relevant content - e.g. no blank lines, no headlines, no appendices.

**class:**  integer \
<br>**unique:**  401 \
<br>**NAs:**  0 \
<br>**range:** *[ 38 ]* ... *[ 1242 ]* \
<br>**examples:**  *[ 539 ], [ 117 ], [ 556 ], [ 444 ], [ 962 ], [ 263 ], [ 379 ], [ 430 ], [ 291 ]* ... \
<br>

<p>&nbsp;</p>

**wds_raw_rel** (textlines)

Number of words that are not from irrelevant lines - e.g. no blank lines, no headlines, no appendices.

**class:**  integer \
<br>**unique:**  740 \
<br>**NAs:**  0 \
<br>**range:** *[ 2122 ]* ... *[ 43046 ]* \
<br>**examples:**  *[ 19023 ], [ 10768 ], [ 24138 ], [ 11532 ], [ 10405 ], [ 18787 ], [ 28661 ], [ * ... \
<br>

<p>&nbsp;</p>

**wds_clean_rel** (textlines)

Number of words that are not from irrelevant lines - e.g. no blank lines, no headlines, no appendices - after having striped away enumerations like, a), b), ..., 1., 2., ... I, II, ... and so forth.

**class:**  integer \
<br>**unique:**  742 \
<br>**NAs:**  0 \
<br>**range:** *[ 2122 ]* ... *[ 41488 ]* \
<br>**examples:**  *[ 29476 ], [ 9968 ], [ 11462 ], [ 11663 ], [ 22768 ], [ 20169 ], [ 41488 ], [ 2* ... \
<br>

<p>&nbsp;</p>
## 4 change



**lns_mdf** (textlines)

Number of lines that were mofified - i.e. changed but not deleted or inserted.

**class:**  numeric \
<br>**unique:**  98 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 583 ]* \
<br>**examples:**  *[ 1 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 4 ], [ 144 ], [ 3 ], [ 4 ], [ 3 ]* ... \
<br>

<p>&nbsp;</p>

**wds_mdf** (textlines)

Number of words modified - i.e. changed but not deleted or inserted.

**class:**  numeric \
<br>**unique:**  347 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 12273 ]* \
<br>**examples:**  *[ 15 ], [ 0 ], [ 512 ], [ 19 ], [ 669 ], [ NA ], [ 2 ], [ 119 ], [ 1533 ], [ 22* ... \
<br>

<p>&nbsp;</p>

**wds_ins** (textlines, linelinkage)

Number of words that were inserted into SO.

**class:**  numeric \
<br>**unique:**  357 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 11246 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 3 ], [ 367 ], [ 48 ], [ 251 ], [ 0 ], [ 88 ], [ 7 ], [ 85 ]* ... \
<br>

<p>&nbsp;</p>

**lns_ins** (textlines, linelinkage)

Number of lines that were inserted into SO.

**class:**  numeric \
<br>**unique:**  80 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 375 ]* \
<br>**examples:**  *[ 13 ], [ 4 ], [ 0 ], [ 21 ], [ 1 ], [ 2 ], [ 0 ], [ NA ], [ 9 ], [ 66 ]* ... \
<br>

<p>&nbsp;</p>

**wds_del** (textlines, linelinkage)

Number of words that were deleted from old SO.

**class:**  numeric \
<br>**unique:**  204 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 6059 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 376 ], [ 11 ], [ 1198 ], [ 0 ], [ 171 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_del** (textlines, linelinkage)

Number of lines that were deleted from old SO.

**class:**  numeric \
<br>**unique:**  51 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 229 ]* \
<br>**examples:**  *[ 0 ], [ 3 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**lns_chg** (textlines, linelinkage)

Number of lines that were changed from the old SO to the current - i.e. the sum of insertions, deletions and modifikations.

**class:**  numeric \
<br>**unique:**  134 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 778 ]* \
<br>**examples:**  *[ 1 ], [ 4 ], [ 9 ], [ NA ], [ 31 ], [ 40 ], [ 88 ], [ 6 ], [ 2 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**wds_chg** (textlines, linelinkage)

Number of words that were changed from the old SO to the current - i.e. the sum of insertions, deletions and modifikations.

**class:**  numeric \
<br>**unique:**  519 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 23366 ]* \
<br>**examples:**  *[ 78 ], [ 0 ], [ 247 ], [ 1494 ], [ 18 ], [ 39 ], [ NA ], [ 55 ], [ 102 ], [ 12* ... \
<br>

<p>&nbsp;</p>
## 5 minority/majority



**pro_maj_mdf** (textlines, linelinkage)

Number of lines modified that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  16 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 32 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 12 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 2 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_min_mdf** (textlines, linelinkage)

Number of lines modified that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  17 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 25 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 2 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_non_mdf** (textlines, linelinkage)

Number of lines modified that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  85 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 583 ]* \
<br>**examples:**  *[ 2 ], [ NA ], [ 3 ], [ 12 ], [ 2 ], [ 3 ], [ 0 ], [ 3 ], [ 1 ], [ 7 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_maj_mdf** (textlines, linelinkage)

Number of words modified that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  83 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 4008 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 65 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_min_mdf** (textlines, linelinkage)

Number of words modified that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  83 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 1162 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_non_mdf** (textlines, linelinkage)

Number of words modified that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  317 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 11883 ]* \
<br>**examples:**  *[ 22 ], [ 162 ], [ 554 ], [ 586 ], [ 0 ], [ 50 ], [ 1758 ], [ 0 ], [ 0 ], [ 808* ... \
<br>

<p>&nbsp;</p>

**pro_maj_ins** (textlines, linelinkage)

Number of lines inserted that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  15 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 38 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ NA ], [ 0 ], [ NA ], [ 0 ], [ 2 ]* ... \
<br>

<p>&nbsp;</p>

**pro_min_ins** (textlines, linelinkage)

Number of lines inserted that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  15 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 17 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ NA ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_non_ins** (textlines, linelinkage)

Number of lines inserted that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  73 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 317 ]* \
<br>**examples:**  *[ NA ], [ 3 ], [ 1 ], [ 6 ], [ 0 ], [ 7 ], [ 5 ], [ 317 ], [ 3 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_maj_ins** (textlines, linelinkage)

Number of words inserted that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  77 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 1439 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 38 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_min_ins** (textlines, linelinkage)

Number of words inserted that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  80 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 601 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 91 ], [ 171 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_non_ins** (textlines, linelinkage)

Number of words inserted that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  313 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 11108 ]* \
<br>**examples:**  *[ 25 ], [ 12 ], [ 0 ], [ 111 ], [ 177 ], [ 26 ], [ 0 ], [ 733 ], [ 183 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_maj_del** (textlines, linelinkage)

Number of lines deleted that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  7 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 25 ]* \
<br>**examples:**  *[ 0 ], [ NA ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_min_del** (textlines, linelinkage)

Number of lines deleted that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  7 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 7 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ NA ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_non_del** (textlines, linelinkage)

Number of lines deleted that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  46 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 229 ]* \
<br>**examples:**  *[ NA ], [ 0 ], [ 1 ], [ NA ], [ 19 ], [ 0 ], [ NA ], [ 2 ], [ 0 ], [ NA ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_maj_del** (textlines, linelinkage)

Number of words deleted that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  26 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 980 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ NA ], [ 0 ], [ 0 ], [ 0 ], [ NA ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_min_del** (textlines, linelinkage)

Number of words deleted that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  26 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 192 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_non_del** (textlines, linelinkage)

Number of words deleted that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  179 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 5992 ]* \
<br>**examples:**  *[ NA ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ NA ], [ 103 ], [ NA ], [ 71 ]* ... \
<br>

<p>&nbsp;</p>

**pro_maj** (linelinkage)

Number of lines coded as majority friendly.

**class:**  numeric \
<br>**unique:**  24 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 44 ]* \
<br>**examples:**  *[ NA ], [ 0 ], [ NA ], [ 4 ], [ 0 ], [ 7 ], [ 0 ], [ 0 ], [ 3 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**pro_min** (linelinkage)

Number of lines coded as minority friendly.

**class:**  numeric \
<br>**unique:**  21 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 37 ]* \
<br>**examples:**  *[ 1 ], [ 0 ], [ 1 ], [ 1 ], [ 0 ], [ 0 ], [ 1 ], [ 20 ], [ 0 ], [ 4 ]* ... \
<br>

<p>&nbsp;</p>

**pro_non** (linelinkage)

Number of lines coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  121 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 778 ]* \
<br>**examples:**  *[ 2 ], [ 18 ], [ 2 ], [ 8 ], [ 1 ], [ 18 ], [ 5 ], [ 15 ], [ 5 ], [ 46 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_maj** (textlines, linelinkage)

Number of words coded as majority friendly.

**class:**  numeric \
<br>**unique:**  123 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 4022 ]* \
<br>**examples:**  *[ 0 ], [ 207 ], [ 26 ], [ NA ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_min** (textlines, linelinkage)

Number of words coded as minority friendly.

**class:**  numeric \
<br>**unique:**  124 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 1680 ]* \
<br>**examples:**  *[ 0 ], [ NA ], [ 0 ], [ 0 ], [ 0 ], [ NA ], [ 30 ], [ 111 ], [ 0 ], [ 68 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_non** (textlines, linelinkage)

Number of words coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  475 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 22843 ]* \
<br>**examples:**  *[ 1108 ], [ 1132 ], [ 2221 ], [ 244 ], [ 109 ], [ 41 ], [ 29 ], [ 1702 ], [ 102* ... \
<br>

<p>&nbsp;</p>
## 7 raw corpus codes - 1 law making



**lns_corp_111** (textlines)

Number of lines with corpus code 111  

 1 Law-Making 

 11 Bills and motions 

 111 types of bills and motions; printing and distribution of bills and motions to MPs

**class:**  numeric \
<br>**unique:**  24 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 33 ]* \
<br>**examples:**  *[ 7 ], [ 6 ], [ 2 ], [ 2 ], [ 11 ], [ 2 ], [ 1 ], [ 19 ], [ 2 ], [ 2 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_112** (textlines)

Number of lines with corpus code 112  

 1 Law-Making 

 11 Bills and motions 

 112 right to initiate bills and motions 

**class:**  numeric \
<br>**unique:**  17 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 28 ]* \
<br>**examples:**  *[ 1 ], [ 7 ], [ 5 ], [ 4 ], [ 2 ], [ 0 ], [ 2 ], [ 3 ], [ 11 ], [ 11 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_113** (textlines)

Number of lines with corpus code 113  

 1 Law-Making 

 11 Bills and motions 

 113 restrictions and deadlines (if not assignable to more specific category, e.g. code 121; 32; 134)

**class:**  numeric \
<br>**unique:**  26 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 31 ]* \
<br>**examples:**  *[ 8 ], [ 2 ], [ 3 ], [ 1 ], [ 6 ], [ 7 ], [ 25 ], [ 10 ], [ 7 ], [ 24 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_114** (textlines)

Number of lines with corpus code 114  

 1 Law-Making 

 11 Bills and motions 

 114 legislative planning (concerns the whole term- general schedule)

**class:**  numeric \
<br>**unique:**  9 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 12 ]* \
<br>**examples:**  *[ 1 ], [ 1 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 1 ], [ 0 ], [ 2 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_121** (textlines)

Number of lines with corpus code 121  

 1 Law-Making 

 12 Treatment of Bills and motions in the plenary 

 121 debate in the plenary

**class:**  numeric \
<br>**unique:**  34 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 49 ]* \
<br>**examples:**  *[ 11 ], [ 16 ], [ 0 ], [ 2 ], [ 49 ], [ 19 ], [ 20 ], [ 0 ], [ 8 ], [ 11 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_122** (textlines)

Number of lines with corpus code 122  

 1 Law-Making 

 12 Treatment of Bills and motions in the plenary 

 122 right of amendment in the plenary 

**class:**  numeric \
<br>**unique:**  26 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 26 ]* \
<br>**examples:**  *[ 4 ], [ 0 ], [ 8 ], [ 8 ], [ 0 ], [ 5 ], [ 6 ], [ 3 ], [ 7 ], [ 11 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_123** (textlines)

Number of lines with corpus code 123  

 1 Law-Making 

 12 Treatment of Bills and motions in the plenary 

 123 subject of vote, rules of vote (including quorum), voting technology in the plenary

**class:**  integer \
<br>**unique:**  49 \
<br>**NAs:**  0 \
<br>**range:** *[ 2 ]* ... *[ 67 ]* \
<br>**examples:**  *[ 67 ], [ 17 ], [ 41 ], [ 7 ], [ 26 ], [ 17 ], [ 36 ], [ 27 ], [ 14 ], [ 17 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_124** (textlines)

Number of lines with corpus code 124  

 1 Law-Making 

 12 Treatment of Bills and motions in the plenary 

 124 the plenary as Committee of the Whole House

**class:**  numeric \
<br>**unique:**  7 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 9 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 8 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_125** (textlines)

Number of lines with corpus code 125  

 1 Law-Making 

 12 Treatment of Bills and motions in the plenary 

 125 referral to committee, withdrawal from committee

**class:**  numeric \
<br>**unique:**  18 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 22 ]* \
<br>**examples:**  *[ 21 ], [ 6 ], [ 10 ], [ 10 ], [ 10 ], [ 19 ], [ 11 ], [ 6 ], [ 8 ], [ 6 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_131** (textlines)

Number of lines with corpus code 131  

 1 Law-Making 

 13 Treatment of bills and motions in committee 

 131 debate in committee (including hearing)  

**class:**  numeric \
<br>**unique:**  13 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 13 ]* \
<br>**examples:**  *[ 1 ], [ 4 ], [ 2 ], [ 1 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 3 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_132** (textlines)

Number of lines with corpus code 132  

 1 Law-Making 

 13 Treatment of bills and motions in committee 

 132 amendment rights in committee 

**class:**  numeric \
<br>**unique:**  9 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 10 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 5 ], [ 2 ], [ 0 ], [ 0 ], [ 1 ], [ 2 ], [ 1 ], [ 5 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_133** (textlines)

Number of lines with corpus code 133  

 1 Law-Making 

 13 Treatment of bills and motions in committee 

 133 subject of vote, rules of vote (including quorum), voting technology in committee 

**class:**  numeric \
<br>**unique:**  11 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 11 ]* \
<br>**examples:**  *[ 2 ], [ 9 ], [ 1 ], [ 8 ], [ 0 ], [ 3 ], [ 2 ], [ 1 ], [ 3 ], [ 4 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_134** (textlines)

Number of lines with corpus code 134  

 1 Law-Making 

 13 Treatment of bills and motions in committee 

 134 report to the plenary 

**class:**  numeric \
<br>**unique:**  21 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 22 ]* \
<br>**examples:**  *[ 4 ], [ 13 ], [ 11 ], [ 2 ], [ 12 ], [ 15 ], [ 0 ], [ 5 ], [ 7 ], [ 10 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_141** (textlines)

Number of lines with corpus code 141  

 1 Law-Making 

 14 Post-parliamentary stage 

 141 veto right of government actors and head of state ( any case when government actors can oppose themselves to the decisions of parliament) 

**class:**  numeric \
<br>**unique:**  6 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 6 ]* \
<br>**examples:**  *[ 2 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_142** (textlines)

Number of lines with corpus code 142  

 1 Law-Making 

 14 Post-parliamentary stage 

 142 referral to second chamber, conciliation committee, and renewed decision after intervention  

**class:**  numeric \
<br>**unique:**  20 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 47 ]* \
<br>**examples:**  *[ 1 ], [ 9 ], [ 3 ], [ 0 ], [ 5 ], [ 1 ], [ 0 ], [ 6 ], [ 0 ], [ 5 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_143** (textlines)

Number of lines with corpus code 143  

 1 Law-Making 

 14 Post-parliamentary stage 

 143 	direct democratic procedures following the legislative stage  

**class:**  numeric \
<br>**unique:**  7 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 13 ]* \
<br>**examples:**  *[ 13 ], [ 4 ], [ 0 ], [ 0 ], [ 0 ], [ 4 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_144** (textlines)

Number of lines with corpus code 144  

 1 Law-Making 

 14 Post-parliamentary stage 

 144 promulgation and enactment	 

**class:**  numeric \
<br>**unique:**  5 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 6 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ 1 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_145** (textlines)

Number of lines with corpus code 145  

 1 Law-Making 

 14 Post-parliamentary stage 

 145 referral to the constitutional court/supreme court 

**class:**  numeric \
<br>**unique:**  5 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 15 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 13 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_111** (textlines)

Number of words with corpus code 111  - see lns_corp_111  for more information.

**class:**  numeric \
<br>**unique:**  68 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 651 ]* \
<br>**examples:**  *[ 70 ], [ 131 ], [ 0 ], [ 64 ], [ 35 ], [ 0 ], [ 0 ], [ 106 ], [ 0 ], [ 256 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_112** (textlines)

Number of words with corpus code 112  - see lns_corp_112  for more information.

**class:**  numeric \
<br>**unique:**  79 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 522 ]* \
<br>**examples:**  *[ 83 ], [ 0 ], [ 65 ], [ 167 ], [ 13 ], [ 25 ], [ 169 ], [ 284 ], [ 178 ], [ 13* ... \
<br>

<p>&nbsp;</p>

**wds_corp_113** (textlines)

Number of words with corpus code 113  - see lns_corp_113  for more information.

**class:**  numeric \
<br>**unique:**  100 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 806 ]* \
<br>**examples:**  *[ 58 ], [ 81 ], [ 29 ], [ 254 ], [ 378 ], [ 0 ], [ 58 ], [ 576 ], [ 58 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_114** (textlines)

Number of words with corpus code 114  - see lns_corp_114  for more information.

**class:**  numeric \
<br>**unique:**  23 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 635 ]* \
<br>**examples:**  *[ 0 ], [ 100 ], [ 30 ], [ 0 ], [ 0 ], [ 25 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_121** (textlines)

Number of words with corpus code 121  - see lns_corp_121  for more information.

**class:**  numeric \
<br>**unique:**  109 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1536 ]* \
<br>**examples:**  *[ 0 ], [ 685 ], [ 266 ], [ 0 ], [ 0 ], [ 141 ], [ 128 ], [ 141 ], [ 1363 ], [ 0* ... \
<br>

<p>&nbsp;</p>

**wds_corp_122** (textlines)

Number of words with corpus code 122  - see lns_corp_122  for more information.

**class:**  numeric \
<br>**unique:**  91 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1189 ]* \
<br>**examples:**  *[ 113 ], [ 0 ], [ 721 ], [ 0 ], [ 0 ], [ 277 ], [ 905 ], [ 172 ], [ 367 ], [ 60* ... \
<br>

<p>&nbsp;</p>

**wds_corp_123** (textlines)

Number of words with corpus code 123  - see lns_corp_123  for more information.

**class:**  integer \
<br>**unique:**  182 \
<br>**NAs:**  0 \
<br>**range:** *[ 80 ]* ... *[ 2366 ]* \
<br>**examples:**  *[ 432 ], [ 1165 ], [ 502 ], [ 714 ], [ 522 ], [ 532 ], [ 522 ], [ 619 ], [ 703 * ... \
<br>

<p>&nbsp;</p>

**wds_corp_124** (textlines)

Number of words with corpus code 124  - see lns_corp_124  for more information.

**class:**  numeric \
<br>**unique:**  18 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 498 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 496 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 457 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_125** (textlines)

Number of words with corpus code 125  - see lns_corp_125  for more information.

**class:**  numeric \
<br>**unique:**  106 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1073 ]* \
<br>**examples:**  *[ 692 ], [ 583 ], [ 50 ], [ 694 ], [ 269 ], [ 269 ], [ 486 ], [ 992 ], [ 583 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_131** (textlines)

Number of words with corpus code 131  - see lns_corp_131  for more information.

**class:**  numeric \
<br>**unique:**  58 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 636 ]* \
<br>**examples:**  *[ 0 ], [ 88 ], [ 0 ], [ 0 ], [ 331 ], [ 99 ], [ 48 ], [ 0 ], [ 53 ], [ 74 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_132** (textlines)

Number of words with corpus code 132  - see lns_corp_132  for more information.

**class:**  numeric \
<br>**unique:**  46 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 435 ]* \
<br>**examples:**  *[ 72 ], [ 0 ], [ 68 ], [ 72 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 122 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_133** (textlines)

Number of words with corpus code 133  - see lns_corp_133  for more information.

**class:**  numeric \
<br>**unique:**  60 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 489 ]* \
<br>**examples:**  *[ 78 ], [ 37 ], [ 132 ], [ 22 ], [ 0 ], [ 110 ], [ 18 ], [ 12 ], [ 309 ], [ 37 * ... \
<br>

<p>&nbsp;</p>

**wds_corp_134** (textlines)

Number of words with corpus code 134  - see lns_corp_134  for more information.

**class:**  numeric \
<br>**unique:**  126 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 761 ]* \
<br>**examples:**  *[ 180 ], [ 180 ], [ 180 ], [ 200 ], [ 41 ], [ 632 ], [ 298 ], [ 263 ], [ 115 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_141** (textlines)

Number of words with corpus code 141  - see lns_corp_141  for more information.

**class:**  numeric \
<br>**unique:**  9 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 187 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 187 ], [ 0 ], [ 187 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_142** (textlines)

Number of words with corpus code 142  - see lns_corp_142  for more information.

**class:**  numeric \
<br>**unique:**  59 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1359 ]* \
<br>**examples:**  *[ 121 ], [ 150 ], [ 194 ], [ 0 ], [ 451 ], [ 0 ], [ 169 ], [ 26 ], [ 1121 ], [ * ... \
<br>

<p>&nbsp;</p>

**wds_corp_143** (textlines)

Number of words with corpus code 143  - see lns_corp_143  for more information.

**class:**  numeric \
<br>**unique:**  18 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 555 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 546 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_144** (textlines)

Number of words with corpus code 144  - see lns_corp_144  for more information.

**class:**  numeric \
<br>**unique:**  10 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 136 ]* \
<br>**examples:**  *[ 28 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 21 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_145** (textlines)

Number of words with corpus code 145  - see lns_corp_145  for more information.

**class:**  numeric \
<br>**unique:**  9 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 857 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>
## 7 raw corpus codes - 2 special decision procedures



**lns_corp_21** (textlines)

Number of lines with corpus code 21   

 2 Special Decision Procedures other than Regular Law-Making 

 21 constitutional change and amendment

**class:**  numeric \
<br>**unique:**  22 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 35 ]* \
<br>**examples:**  *[ 0 ], [ 5 ], [ 0 ], [ 7 ], [ 0 ], [ 9 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_22** (textlines)

Number of lines with corpus code 22   

 2 Special Decision Procedures other than Regular Law-Making 

 22 financial laws (money bills) and budgeting 

**class:**  numeric \
<br>**unique:**  48 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 65 ]* \
<br>**examples:**  *[ 13 ], [ 9 ], [ 1 ], [ 34 ], [ 0 ], [ 19 ], [ 16 ], [ 51 ], [ 14 ], [ 3 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_23** (textlines)

Number of lines with corpus code 23   

 2 Special Decision Procedures other than Regular Law-Making 

 23 foreign policy

**class:**  numeric \
<br>**unique:**  16 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 29 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 2 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_25** (textlines)

Number of lines with corpus code 25   

 2 Special Decision Procedures other than Regular Law-Making 

 25 general rules on elections in parliament (if not coded as election of government (31), or election of specific officials (411; 421; 441; 6211; 6221; 632))

**class:**  numeric \
<br>**unique:**  34 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 80 ]* \
<br>**examples:**  *[ 0 ], [ 22 ], [ 0 ], [ 1 ], [ 76 ], [ 0 ], [ 2 ], [ 0 ], [ 3 ], [ 76 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_26** (textlines)

Number of lines with corpus code 26   

 2 Special Decision Procedures other than Regular Law-Making 

 26 further special decision procedures (leading to a decision, e.g. resolution, or leading to a decree/act/bylaw (not mere debate or question time) but cannot be coded as regular law-making nor special decision procedures (21 - 24) )

**class:**  numeric \
<br>**unique:**  32 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 44 ]* \
<br>**examples:**  *[ 1 ], [ 6 ], [ 8 ], [ 10 ], [ 21 ], [ 3 ], [ 8 ], [ 9 ], [ 0 ], [ 16 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_27** (textlines)

Number of lines with corpus code 27   

 2 Special Decision Procedures other than Regular Law-Making 

 27 procedures concerning laws that are hierarchically situated between regular laws and constitutional laws (above regular laws; e.g. organic laws in Spain)

**class:**  numeric \
<br>**unique:**  6 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 9 ]* \
<br>**examples:**  *[ 0 ], [ 5 ], [ 5 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 7 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_28** (textlines)

Number of lines with corpus code 28   

 2 Special Decision Procedures other than Regular Law-Making 

 28 emergency legislation

**class:**  numeric \
<br>**unique:**  6 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 32 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 12 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_29** (textlines)

Number of lines with corpus code 29   

 2 Special Decision Procedures other than Regular Law-Making 

 29 relationship to sub-national level (law-making, rights of participation of sub-national level)

**class:**  numeric \
<br>**unique:**  36 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 245 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 208 ], [ 91 ], [ 0 ], [ 23 ], [ 221 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_241** (textlines)

Number of lines with corpus code 241  

 2 Special Decision Procedures other than Regular Law-Making 

 24 EU 

 241 treatment of EU-bills and motions

**class:**  numeric \
<br>**unique:**  14 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 24 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 4 ], [ 0 ], [ 4 ], [ 3 ], [ 0 ], [ 0 ], [ 0 ], [ 3 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_242** (textlines)

Number of lines with corpus code 242  

 2 Special Decision Procedures other than Regular Law-Making 

 24 EU 

 242 EU-committee: election and resignation 

**class:**  numeric \
<br>**unique:**  23 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 48 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 39 ], [ 0 ], [ 7 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_243** (textlines)

Number of lines with corpus code 243  

 2 Special Decision Procedures other than Regular Law-Making 

 24 EU 

 243 instructions to the government concerning EU decisions

**class:**  numeric \
<br>**unique:**  4 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 4 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_244** (textlines)

Number of lines with corpus code 244  

 2 Special Decision Procedures other than Regular Law-Making 

 24 EU 

 244 further rights of participation in EU matters (e.g. debates about EU topics not based on EU bills and motions, reaction to violations of subsidiary principle) 

**class:**  numeric \
<br>**unique:**  14 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 29 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 13 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_21** (textlines)

Number of words with corpus code 21   - see lns_corp_21   for more information.

**class:**  numeric \
<br>**unique:**  54 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 885 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 51 ], [ 279 ], [ 0 ], [ 127 ], [ 51 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_22** (textlines)

Number of words with corpus code 22   - see lns_corp_22   for more information.

**class:**  numeric \
<br>**unique:**  155 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2938 ]* \
<br>**examples:**  *[ 489 ], [ 151 ], [ 414 ], [ 137 ], [ 352 ], [ 2330 ], [ 635 ], [ 38 ], [ 166 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_23** (textlines)

Number of words with corpus code 23   - see lns_corp_23   for more information.

**class:**  numeric \
<br>**unique:**  40 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 777 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 777 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_25** (textlines)

Number of words with corpus code 25   - see lns_corp_25   for more information.

**class:**  numeric \
<br>**unique:**  94 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1942 ]* \
<br>**examples:**  *[ 348 ], [ 290 ], [ 0 ], [ 0 ], [ 608 ], [ 190 ], [ 222 ], [ 0 ], [ 80 ], [ 190* ... \
<br>

<p>&nbsp;</p>

**wds_corp_26** (textlines)

Number of words with corpus code 26   - see lns_corp_26   for more information.

**class:**  numeric \
<br>**unique:**  86 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2217 ]* \
<br>**examples:**  *[ 0 ], [ 70 ], [ 0 ], [ 0 ], [ 70 ], [ 1868 ], [ 0 ], [ 0 ], [ 679 ], [ 376 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_27** (textlines)

Number of words with corpus code 27   - see lns_corp_27   for more information.

**class:**  numeric \
<br>**unique:**  15 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 475 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 475 ], [ 195 ], [ 306 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_28** (textlines)

Number of words with corpus code 28   - see lns_corp_28   for more information.

**class:**  numeric \
<br>**unique:**  8 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 775 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 669 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_29** (textlines)

Number of words with corpus code 29   - see lns_corp_29   for more information.

**class:**  numeric \
<br>**unique:**  70 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 8107 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 570 ], [ 0 ], [ 0 ], [ 0 ], [ 1550 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_241** (textlines)

Number of words with corpus code 241  - see lns_corp_241  for more information.

**class:**  numeric \
<br>**unique:**  42 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1348 ]* \
<br>**examples:**  *[ 0 ], [ 188 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 123 ], [ 97 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_242** (textlines)

Number of words with corpus code 242  - see lns_corp_242  for more information.

**class:**  numeric \
<br>**unique:**  50 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1310 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 296 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_243** (textlines)

Number of words with corpus code 243  - see lns_corp_243  for more information.

**class:**  numeric \
<br>**unique:**  7 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 84 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 70 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_244** (textlines)

Number of words with corpus code 244  - see lns_corp_244  for more information.

**class:**  numeric \
<br>**unique:**  28 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 927 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 918 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>
## 7 raw corpus codes - 3 relationship to government 



**lns_corp_31** (textlines)

Number of lines with corpus code 31   

 3 Relationship to Government 

 31 election of government / mandatory investiture vote; entry into office

**class:**  numeric \
<br>**unique:**  9 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 18 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ 1 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_32** (textlines)

Number of lines with corpus code 32   

 3 Relationship to Government 

 32 vote of no confidence / government resignation

**class:**  numeric \
<br>**unique:**  15 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 27 ]* \
<br>**examples:**  *[ 0 ], [ 16 ], [ 0 ], [ 12 ], [ 0 ], [ 0 ], [ 2 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_33** (textlines)

Number of lines with corpus code 33   

 3 Relationship to Government 

 33 vote of confidence

**class:**  numeric \
<br>**unique:**  8 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 9 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 7 ], [ 0 ], [ 0 ], [ 0 ], [ 5 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_34** (textlines)

Number of lines with corpus code 34   

 3 Relationship to Government 

 34 instructions to government, involvement of members of government in parliamentary activities (rights to compel witnesses [usually right of parliament against members of government], right to speak [usually members of government's right], request of information about state of execution of decisions of parliament)

**class:**  numeric \
<br>**unique:**  27 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 37 ]* \
<br>**examples:**  *[ 9 ], [ 29 ], [ 1 ], [ 7 ], [ 1 ], [ 2 ], [ 6 ], [ 2 ], [ 28 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_31** (textlines)

Number of words with corpus code 31   - see lns_corp_31   for more information.

**class:**  numeric \
<br>**unique:**  17 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 426 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 27 ], [ 376 ], [ 0 ], [ 48 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_32** (textlines)

Number of words with corpus code 32   - see lns_corp_32   for more information.

**class:**  numeric \
<br>**unique:**  33 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 861 ]* \
<br>**examples:**  *[ 55 ], [ 475 ], [ 0 ], [ 93 ], [ 0 ], [ 0 ], [ 0 ], [ 57 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_33** (textlines)

Number of words with corpus code 33   - see lns_corp_33   for more information.

**class:**  numeric \
<br>**unique:**  19 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 268 ]* \
<br>**examples:**  *[ 161 ], [ 0 ], [ 0 ], [ 0 ], [ 243 ], [ 0 ], [ 240 ], [ 0 ], [ 0 ], [ 189 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_34** (textlines)

Number of words with corpus code 34   - see lns_corp_34   for more information.

**class:**  numeric \
<br>**unique:**  102 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 860 ]* \
<br>**examples:**  *[ 64 ], [ 33 ], [ 150 ], [ 64 ], [ 92 ], [ 114 ], [ 68 ], [ 110 ], [ 110 ], [ 6* ... \
<br>

<p>&nbsp;</p>
## 7 raw corpus codes - 4 relationship to others



**lns_corp_43** (textlines)

Number of lines with corpus code 43   

 4 Relationship to External Offices/Institutions apart from the Government 

 43 second chamber (if not coded as law-making (142))

**class:**  numeric \
<br>**unique:**  10 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 16 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ 2 ], [ 0 ], [ 10 ], [ 0 ], [ 0 ], [ 0 ], [ 4 ], [ 15 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_45** (textlines)

Number of lines with corpus code 45   

 4 Relationship to External Offices/Institutions apart from the Government 

 45 constitutional courts

**class:**  numeric \
<br>**unique:**  10 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 34 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_411** (textlines)

Number of lines with corpus code 411  

 4 Relationship to External Offices/Institutions apart from the Government 

 41 parliamentary support bodies (e.g. general accounting office, ombudsman, ...) 

 411 election and resignation

**class:**  numeric \
<br>**unique:**  14 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 46 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 6 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_412** (textlines)

Number of lines with corpus code 412  

 4 Relationship to External Offices/Institutions apart from the Government 

 41 parliamentary support bodies (e.g. general accounting office, ombudsman, ...) 

 412 competences and resources of external offices/institutions; relations to parliament (e.g. reports, questions, ...)

**class:**  numeric \
<br>**unique:**  13 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 22 ]* \
<br>**examples:**  *[ 0 ], [ 5 ], [ 4 ], [ 0 ], [ 0 ], [ 0 ], [ 6 ], [ 5 ], [ 0 ], [ 5 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_421** (textlines)

Number of lines with corpus code 421  

 4 Relationship to External Offices/Institutions apart from the Government 

 42 head of state 

 421 election and resignation

**class:**  numeric \
<br>**unique:**  6 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 15 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_422** (textlines)

Number of lines with corpus code 422  

 4 Relationship to External Offices/Institutions apart from the Government 

 42 head of state 

 422 relation to parliament (if not coded as law-making (141, 144))

**class:**  numeric \
<br>**unique:**  4 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 6 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 6 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_441** (textlines)

Number of lines with corpus code 441  

 4 Relationship to External Offices/Institutions apart from the Government 

 44 constitutional courts 

 441 election and resignation

**class:**  numeric \
<br>**unique:**  3 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 4 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_442** (textlines)

Number of lines with corpus code 442  

 4 Relationship to External Offices/Institutions apart from the Government 

 44 constitutional courts 

 442 relation to parliament (if not coded as law-making (145))

**class:**  numeric \
<br>**unique:**  4 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 5 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_43** (textlines)

Number of words with corpus code 43   - see lns_corp_43   for more information.

**class:**  numeric \
<br>**unique:**  25 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 335 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 58 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_45** (textlines)

Number of words with corpus code 45   - see lns_corp_45   for more information.

**class:**  numeric \
<br>**unique:**  14 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1001 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_411** (textlines)

Number of words with corpus code 411  - see lns_corp_411  for more information.

**class:**  numeric \
<br>**unique:**  27 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1435 ]* \
<br>**examples:**  *[ 9 ], [ 0 ], [ 0 ], [ 177 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 181 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_412** (textlines)

Number of words with corpus code 412  - see lns_corp_412  for more information.

**class:**  numeric \
<br>**unique:**  42 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 629 ]* \
<br>**examples:**  *[ 0 ], [ 207 ], [ 0 ], [ 0 ], [ 171 ], [ 0 ], [ 53 ], [ 207 ], [ 225 ], [ 179 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_421** (textlines)

Number of words with corpus code 421  - see lns_corp_421  for more information.

**class:**  numeric \
<br>**unique:**  13 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 391 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 44 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_422** (textlines)

Number of words with corpus code 422  - see lns_corp_422  for more information.

**class:**  numeric \
<br>**unique:**  10 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 170 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 69 ], [ 18 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_441** (textlines)

Number of words with corpus code 441  - see lns_corp_441  for more information.

**class:**  numeric \
<br>**unique:**  4 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 99 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_442** (textlines)

Number of words with corpus code 442  - see lns_corp_442  for more information.

**class:**  numeric \
<br>**unique:**  10 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 142 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 142 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>
## 7 raw corpus codes - 5 publicity



**lns_corp_51** (textlines)

Number of lines with corpus code 51   

 5 Generating Publicity 

 51 general rules regarding debate (e.g. time allotted for speaking, proportional representation of parties during debate, closure of debate) 

**class:**  numeric \
<br>**unique:**  64 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 111 ]* \
<br>**examples:**  *[ 19 ], [ 9 ], [ 15 ], [ 15 ], [ 40 ], [ 67 ], [ 0 ], [ 14 ], [ 11 ], [ 17 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_52** (textlines)

Number of lines with corpus code 52   

 5 Generating Publicity 

 52 debates outside of law-making (e.g. topical hours ...)

**class:**  numeric \
<br>**unique:**  19 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 32 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 2 ], [ 6 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_53** (textlines)

Number of lines with corpus code 53   

 5 Generating Publicity 

 53 question rights

**class:**  numeric \
<br>**unique:**  55 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 89 ]* \
<br>**examples:**  *[ 11 ], [ 17 ], [ 21 ], [ 1 ], [ 22 ], [ 33 ], [ 20 ], [ 35 ], [ 25 ], [ 7 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_54** (textlines)

Number of lines with corpus code 54   

 5 Generating Publicity 

 54 petitions and petition committee

**class:**  numeric \
<br>**unique:**  25 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 49 ]* \
<br>**examples:**  *[ 0 ], [ 6 ], [ 5 ], [ 35 ], [ 4 ], [ 2 ], [ 0 ], [ 11 ], [ 4 ], [ 12 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_55** (textlines)

Number of lines with corpus code 55   

 5 Generating Publicity 

 55 relationship to media and citizens (e.g. parliamentary TV, accreditation of journalists, publicity of meetings, admissibility of visitors); regulation of matters of confidentiality 

**class:**  numeric \
<br>**unique:**  31 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 67 ]* \
<br>**examples:**  *[ 19 ], [ 7 ], [ 9 ], [ 4 ], [ 11 ], [ 1 ], [ 20 ], [ 6 ], [ 12 ], [ 4 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_56** (textlines)

Number of lines with corpus code 56   

 5 Generating Publicity 

 56 protocols and parliamentary documents; forwarding of documents and decisions to other bodies 

**class:**  numeric \
<br>**unique:**  36 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 61 ]* \
<br>**examples:**  *[ 13 ], [ 14 ], [ 7 ], [ 13 ], [ 16 ], [ 9 ], [ 11 ], [ 9 ], [ 0 ], [ 11 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_51** (textlines)

Number of words with corpus code 51   - see lns_corp_51   for more information.

**class:**  numeric \
<br>**unique:**  171 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1649 ]* \
<br>**examples:**  *[ 0 ], [ 785 ], [ 594 ], [ 0 ], [ 674 ], [ 1606 ], [ 779 ], [ 1185 ], [ 839 ], * ... \
<br>

<p>&nbsp;</p>

**wds_corp_52** (textlines)

Number of words with corpus code 52   - see lns_corp_52   for more information.

**class:**  numeric \
<br>**unique:**  43 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1025 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 41 ], [ 41 ], [ 0 ], [ 0 ], [ 0 ], [ 251 ], [ 419 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_53** (textlines)

Number of words with corpus code 53   - see lns_corp_53   for more information.

**class:**  numeric \
<br>**unique:**  189 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2691 ]* \
<br>**examples:**  *[ 785 ], [ 968 ], [ 739 ], [ 75 ], [ 727 ], [ 831 ], [ 301 ], [ 785 ], [ 496 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_54** (textlines)

Number of words with corpus code 54   - see lns_corp_54   for more information.

**class:**  numeric \
<br>**unique:**  74 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1106 ]* \
<br>**examples:**  *[ 123 ], [ 0 ], [ 473 ], [ 33 ], [ 292 ], [ 366 ], [ 287 ], [ 521 ], [ 0 ], [ 3* ... \
<br>

<p>&nbsp;</p>

**wds_corp_55** (textlines)

Number of words with corpus code 55   - see lns_corp_55   for more information.

**class:**  numeric \
<br>**unique:**  128 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1851 ]* \
<br>**examples:**  *[ 1851 ], [ 482 ], [ 504 ], [ 249 ], [ 301 ], [ 0 ], [ 781 ], [ 582 ], [ 482 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_56** (textlines)

Number of words with corpus code 56   - see lns_corp_56   for more information.

**class:**  numeric \
<br>**unique:**  147 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1340 ]* \
<br>**examples:**  *[ 381 ], [ 710 ], [ 1092 ], [ 474 ], [ 700 ], [ 233 ], [ 700 ], [ 273 ], [ 700 * ... \
<br>

<p>&nbsp;</p>
## 7 raw corpus codes - 6 committees



**lns_corp_66** (textlines)

Number of lines with corpus code 66   

 6 Internal Organization of Parliament 

 66 opposition

**class:**  numeric \
<br>**unique:**  2 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_67** (textlines)

Number of lines with corpus code 67   

 6 Internal Organization of Parliament 

 67 special bodies for emergency situations

**class:**  numeric \
<br>**unique:**  5 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 7 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 6 ], [ 0 ], [ 0 ], [ 7 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_68** (textlines)

Number of lines with corpus code 68   

 6 Internal Organization of Parliament 

 68 parliamentary administration

**class:**  numeric \
<br>**unique:**  26 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 47 ]* \
<br>**examples:**  *[ 6 ], [ 11 ], [ 3 ], [ 9 ], [ 3 ], [ 0 ], [ 10 ], [ 11 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_611** (textlines)

Number of lines with corpus code 611  

 6 Internal Organization of Parliament 

 61 plenary 

 611 agenda setting and removal of items from the agenda (general rules which are not specifically regulated under 114)

**class:**  numeric \
<br>**unique:**  73 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 200 ]* \
<br>**examples:**  *[ 19 ], [ 51 ], [ 76 ], [ 6 ], [ 9 ], [ 0 ], [ 4 ], [ 9 ], [ 44 ], [ 53 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_612** (textlines)

Number of lines with corpus code 612  

 6 Internal Organization of Parliament 

 61 plenary 

 612 chairing of meetings and measures to uphold order

**class:**  numeric \
<br>**unique:**  32 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 60 ]* \
<br>**examples:**  *[ 41 ], [ 15 ], [ 12 ], [ 41 ], [ 11 ], [ 16 ], [ 12 ], [ 2 ], [ 16 ], [ 2 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_613** (textlines)

Number of lines with corpus code 613  

 6 Internal Organization of Parliament 

 61 plenary 

 613 sitting times

**class:**  numeric \
<br>**unique:**  21 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 32 ]* \
<br>**examples:**  *[ 17 ], [ 12 ], [ 0 ], [ 17 ], [ 6 ], [ 5 ], [ 6 ], [ 6 ], [ 2 ], [ 6 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_631** (textlines)

Number of lines with corpus code 631  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 631 general regulations regarding types of committees

**class:**  numeric \
<br>**unique:**  13 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 13 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 11 ], [ 0 ], [ 0 ], [ 0 ], [ 8 ], [ 3 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_632** (textlines)

Number of lines with corpus code 632  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 632 membership and committee jurisdiction (area of influence-control .g. finance, economy, agriculture...)

**class:**  numeric \
<br>**unique:**  56 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 164 ]* \
<br>**examples:**  *[ 1 ], [ 160 ], [ 32 ], [ 41 ], [ 43 ], [ 160 ], [ 26 ], [ 5 ], [ 58 ], [ 13 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_633** (textlines)

Number of lines with corpus code 633  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 633 formal organizational units of committee (e.g. chair of committee, sub-committees, staff)

**class:**  numeric \
<br>**unique:**  17 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 24 ]* \
<br>**examples:**  *[ 5 ], [ 4 ], [ 7 ], [ 7 ], [ 3 ], [ 7 ], [ 1 ], [ 5 ], [ 3 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_634** (textlines)

Number of lines with corpus code 634  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 634 agenda and procedures (details on how decisions are taken) within committees (if not coded as law-making (13))

**class:**  numeric \
<br>**unique:**  30 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 39 ]* \
<br>**examples:**  *[ 4 ], [ 23 ], [ 34 ], [ 5 ], [ 6 ], [ 7 ], [ 12 ], [ 22 ], [ 0 ], [ 8 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_636** (textlines)

Number of lines with corpus code 636  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 636 investigative competencies of regular committees (NOT committees of inquiry (637))

**class:**  numeric \
<br>**unique:**  18 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 21 ]* \
<br>**examples:**  *[ 1 ], [ 6 ], [ 5 ], [ 0 ], [ 15 ], [ 0 ], [ 0 ], [ 5 ], [ 0 ], [ 5 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_637** (textlines)

Number of lines with corpus code 637  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 637 committee of inquiry 

**class:**  numeric \
<br>**unique:**  25 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 78 ]* \
<br>**examples:**  *[ 0 ], [ 21 ], [ 0 ], [ 5 ], [ 6 ], [ 0 ], [ 0 ], [ 0 ], [ 3 ], [ 10 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_638** (textlines)

Number of lines with corpus code 638  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 638 enquete commission

**class:**  numeric \
<br>**unique:**  11 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 20 ]* \
<br>**examples:**  *[ 0 ], [ 8 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_639** (textlines)

Number of lines with corpus code 639  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 639 other special committees which are not explicitly referenced in this coding manual  (e.g. oversight committees in Switzerland)

**class:**  numeric \
<br>**unique:**  79 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 211 ]* \
<br>**examples:**  *[ 3 ], [ 70 ], [ 3 ], [ 12 ], [ 2 ], [ 175 ], [ 5 ], [ 11 ], [ 3 ], [ 38 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_641** (textlines)

Number of lines with corpus code 641  

 6 Internal Organization of Parliament 

 64 parliamentary party groups 

 641 formation of parliamentary party groups

**class:**  numeric \
<br>**unique:**  11 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 12 ]* \
<br>**examples:**  *[ 5 ], [ 0 ], [ 8 ], [ 0 ], [ 5 ], [ 5 ], [ 5 ], [ 0 ], [ 1 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_642** (textlines)

Number of lines with corpus code 642  

 6 Internal Organization of Parliament 

 64 parliamentary party groups 

 642 rights and obligations of parliamentary party groups (if not coded more specifically as e.g. 112; 51; 52; 53)

**class:**  numeric \
<br>**unique:**  14 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 55 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 5 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_643** (textlines)

Number of lines with corpus code 643  

 6 Internal Organization of Parliament 

 64 parliamentary party groups 

 643 financial and staff resources

**class:**  numeric \
<br>**unique:**  7 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 6 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_651** (textlines)

Number of lines with corpus code 651  

 6 Internal Organization of Parliament 

 65 individual members of parlaiment 

 651 election, entry into office, resignation, incompatibilities, legal status, immunity, indemnity

**class:**  numeric \
<br>**unique:**  34 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 56 ]* \
<br>**examples:**  *[ 25 ], [ 0 ], [ 5 ], [ 23 ], [ 2 ], [ 13 ], [ 17 ], [ 7 ], [ 15 ], [ 17 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_652** (textlines)

Number of lines with corpus code 652  

 6 Internal Organization of Parliament 

 65 individual members of parlaiment 

 652 rights and obligations of individual members of parliament (if not coded more specifically as e.g. 112; 51; 52; 53)

**class:**  numeric \
<br>**unique:**  29 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 67 ]* \
<br>**examples:**  *[ 8 ], [ 4 ], [ 3 ], [ 2 ], [ 18 ], [ 2 ], [ 1 ], [ 3 ], [ 7 ], [ 6 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_653** (textlines)

Number of lines with corpus code 653  

 6 Internal Organization of Parliament 

 65 individual members of parlaiment 

 653 salary, financial and staff resources

**class:**  numeric \
<br>**unique:**  6 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 7 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 2 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_6211** (textlines)

Number of lines with corpus code 6211 

 6 Internal Organization of Parliament 

 62 parliamentary presiding bodies 

 621 president of parliament, vice presidents, secretaries and clerks 

 6211 election, resignation and internal decision rules

**class:**  numeric \
<br>**unique:**  26 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 36 ]* \
<br>**examples:**  *[ 0 ], [ 9 ], [ 0 ], [ 4 ], [ 9 ], [ 7 ], [ 16 ], [ 12 ], [ 8 ], [ 6 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_6212** (textlines)

Number of lines with corpus code 6212 

 6 Internal Organization of Parliament 

 62 parliamentary presiding bodies 

 621 president of parliament, vice presidents, secretaries and clerks 

 6212 responsibilities (if not coded as more specific category  (e.g. 612))

**class:**  numeric \
<br>**unique:**  24 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 72 ]* \
<br>**examples:**  *[ 1 ], [ 0 ], [ 7 ], [ 2 ], [ 5 ], [ 3 ], [ 10 ], [ 2 ], [ 0 ], [ 8 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_6221** (textlines)

Number of lines with corpus code 6221 

 6 Internal Organization of Parliament 

 62 parliamentary presiding bodies 

 622 council of elders or similar coordination body 

 6221 composition, election, resignation, internal decision rules

**class:**  numeric \
<br>**unique:**  12 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 13 ]* \
<br>**examples:**  *[ 1 ], [ 0 ], [ 0 ], [ 3 ], [ 0 ], [ 2 ], [ 0 ], [ 0 ], [ 1 ], [ 6 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_6222** (textlines)

Number of lines with corpus code 6222 

 6 Internal Organization of Parliament 

 62 parliamentary presiding bodies 

 622 council of elders or similar coordination body 

 6222 responsibilities (if not coded as more specific category (e.g. 612))

**class:**  numeric \
<br>**unique:**  16 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 16 ]* \
<br>**examples:**  *[ 4 ], [ 0 ], [ 4 ], [ 15 ], [ 11 ], [ 1 ], [ 2 ], [ 2 ], [ 0 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_6351** (textlines)

Number of lines with corpus code 6351 

 6 Internal Organization of Parliament 

 63 committees 

 relations to other bodies 

 6351 relation to plenary (if not coded as 124; 134; 34)

**class:**  numeric \
<br>**unique:**  6 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 6 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_6352** (textlines)

Number of lines with corpus code 6352 

 6 Internal Organization of Parliament 

 63 committees 

 relations to other bodies 

 6352 relation to other committees

**class:**  numeric \
<br>**unique:**  8 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 7 ]* \
<br>**examples:**  *[ 1 ], [ 0 ], [ 2 ], [ 1 ], [ 2 ], [ 1 ], [ 1 ], [ 6 ], [ 2 ], [ 3 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_66** (textlines)

Number of words with corpus code 66   - see lns_corp_66   for more information.

**class:**  numeric \
<br>**unique:**  2 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 41 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_67** (textlines)

Number of words with corpus code 67   - see lns_corp_67   for more information.

**class:**  numeric \
<br>**unique:**  8 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 137 ]* \
<br>**examples:**  *[ 119 ], [ 0 ], [ 119 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_68** (textlines)

Number of words with corpus code 68   - see lns_corp_68   for more information.

**class:**  numeric \
<br>**unique:**  77 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1093 ]* \
<br>**examples:**  *[ 126 ], [ 133 ], [ 108 ], [ 66 ], [ 16 ], [ 0 ], [ 0 ], [ 66 ], [ 453 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_611** (textlines)

Number of words with corpus code 611  - see lns_corp_611  for more information.

**class:**  numeric \
<br>**unique:**  157 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 6791 ]* \
<br>**examples:**  *[ 359 ], [ 4490 ], [ 1866 ], [ 3756 ], [ 252 ], [ 135 ], [ 629 ], [ 793 ], [ 82* ... \
<br>

<p>&nbsp;</p>

**wds_corp_612** (textlines)

Number of words with corpus code 612  - see lns_corp_612  for more information.

**class:**  numeric \
<br>**unique:**  94 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2221 ]* \
<br>**examples:**  *[ 533 ], [ 120 ], [ 0 ], [ 294 ], [ 574 ], [ 742 ], [ 777 ], [ 88 ], [ 0 ], [ 6* ... \
<br>

<p>&nbsp;</p>

**wds_corp_613** (textlines)

Number of words with corpus code 613  - see lns_corp_613  for more information.

**class:**  numeric \
<br>**unique:**  96 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 842 ]* \
<br>**examples:**  *[ 100 ], [ 270 ], [ 202 ], [ 98 ], [ 253 ], [ 325 ], [ 97 ], [ 454 ], [ 38 ], [* ... \
<br>

<p>&nbsp;</p>

**wds_corp_631** (textlines)

Number of words with corpus code 631  - see lns_corp_631  for more information.

**class:**  numeric \
<br>**unique:**  56 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 518 ]* \
<br>**examples:**  *[ 35 ], [ 0 ], [ 81 ], [ 0 ], [ 86 ], [ 0 ], [ 0 ], [ 13 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_632** (textlines)

Number of words with corpus code 632  - see lns_corp_632  for more information.

**class:**  numeric \
<br>**unique:**  243 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1313 ]* \
<br>**examples:**  *[ 1130 ], [ 0 ], [ 761 ], [ 882 ], [ 44 ], [ 64 ], [ 1245 ], [ 896 ], [ 350 ], * ... \
<br>

<p>&nbsp;</p>

**wds_corp_633** (textlines)

Number of words with corpus code 633  - see lns_corp_633  for more information.

**class:**  numeric \
<br>**unique:**  94 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 790 ]* \
<br>**examples:**  *[ 70 ], [ 59 ], [ 210 ], [ 304 ], [ 243 ], [ 198 ], [ 56 ], [ 115 ], [ 71 ], [ * ... \
<br>

<p>&nbsp;</p>

**wds_corp_634** (textlines)

Number of words with corpus code 634  - see lns_corp_634  for more information.

**class:**  numeric \
<br>**unique:**  129 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1288 ]* \
<br>**examples:**  *[ 1124 ], [ 241 ], [ 151 ], [ 134 ], [ 1196 ], [ 287 ], [ 471 ], [ 54 ], [ 151 * ... \
<br>

<p>&nbsp;</p>

**wds_corp_636** (textlines)

Number of words with corpus code 636  - see lns_corp_636  for more information.

**class:**  numeric \
<br>**unique:**  84 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 878 ]* \
<br>**examples:**  *[ 417 ], [ 174 ], [ 88 ], [ 218 ], [ 195 ], [ 62 ], [ 215 ], [ 87 ], [ 249 ], [* ... \
<br>

<p>&nbsp;</p>

**wds_corp_637** (textlines)

Number of words with corpus code 637  - see lns_corp_637  for more information.

**class:**  numeric \
<br>**unique:**  55 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2444 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 855 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_638** (textlines)

Number of words with corpus code 638  - see lns_corp_638  for more information.

**class:**  numeric \
<br>**unique:**  20 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 649 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_639** (textlines)

Number of words with corpus code 639  - see lns_corp_639  for more information.

**class:**  numeric \
<br>**unique:**  207 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 6014 ]* \
<br>**examples:**  *[ 956 ], [ 4767 ], [ 2437 ], [ 1025 ], [ 271 ], [ 310 ], [ 304 ], [ 16 ], [ 797* ... \
<br>

<p>&nbsp;</p>

**wds_corp_641** (textlines)

Number of words with corpus code 641  - see lns_corp_641  for more information.

**class:**  numeric \
<br>**unique:**  45 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 439 ]* \
<br>**examples:**  *[ 0 ], [ 137 ], [ 0 ], [ 224 ], [ 0 ], [ 63 ], [ 78 ], [ 0 ], [ 135 ], [ 59 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_642** (textlines)

Number of words with corpus code 642  - see lns_corp_642  for more information.

**class:**  numeric \
<br>**unique:**  32 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 643 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 149 ], [ 95 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_643** (textlines)

Number of words with corpus code 643  - see lns_corp_643  for more information.

**class:**  numeric \
<br>**unique:**  22 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 202 ]* \
<br>**examples:**  *[ 0 ], [ 202 ], [ 93 ], [ 91 ], [ 0 ], [ 0 ], [ 46 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_651** (textlines)

Number of words with corpus code 651  - see lns_corp_651  for more information.

**class:**  numeric \
<br>**unique:**  121 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2439 ]* \
<br>**examples:**  *[ 547 ], [ 159 ], [ 1192 ], [ 304 ], [ 765 ], [ 468 ], [ 274 ], [ 108 ], [ 78 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_652** (textlines)

Number of words with corpus code 652  - see lns_corp_652  for more information.

**class:**  numeric \
<br>**unique:**  113 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2080 ]* \
<br>**examples:**  *[ 130 ], [ 94 ], [ 108 ], [ 123 ], [ 233 ], [ 215 ], [ 166 ], [ 233 ], [ 215 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_653** (textlines)

Number of words with corpus code 653  - see lns_corp_653  for more information.

**class:**  numeric \
<br>**unique:**  14 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 328 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 50 ], [ 0 ], [ 148 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6211** (textlines)

Number of words with corpus code 6211 - see lns_corp_6211 for more information.

**class:**  numeric \
<br>**unique:**  96 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1308 ]* \
<br>**examples:**  *[ 186 ], [ 1308 ], [ 261 ], [ 1307 ], [ 383 ], [ 1307 ], [ 259 ], [ 331 ], [ 15* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6212** (textlines)

Number of words with corpus code 6212 - see lns_corp_6212 for more information.

**class:**  numeric \
<br>**unique:**  106 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1060 ]* \
<br>**examples:**  *[ 443 ], [ 199 ], [ 166 ], [ 97 ], [ 307 ], [ 102 ], [ 152 ], [ 102 ], [ 0 ], [* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6221** (textlines)

Number of words with corpus code 6221 - see lns_corp_6221 for more information.

**class:**  numeric \
<br>**unique:**  63 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 312 ]* \
<br>**examples:**  *[ 128 ], [ 0 ], [ 0 ], [ 57 ], [ 9 ], [ 308 ], [ 183 ], [ 184 ], [ 0 ], [ 136 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6222** (textlines)

Number of words with corpus code 6222 - see lns_corp_6222 for more information.

**class:**  numeric \
<br>**unique:**  61 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 598 ]* \
<br>**examples:**  *[ 58 ], [ 0 ], [ 106 ], [ 0 ], [ 0 ], [ 0 ], [ 75 ], [ 0 ], [ 429 ], [ 27 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6351** (textlines)

Number of words with corpus code 6351 - see lns_corp_6351 for more information.

**class:**  numeric \
<br>**unique:**  22 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 179 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 46 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6352** (textlines)

Number of words with corpus code 6352 - see lns_corp_6352 for more information.

**class:**  numeric \
<br>**unique:**  42 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 323 ]* \
<br>**examples:**  *[ 156 ], [ 0 ], [ 101 ], [ 0 ], [ 265 ], [ 156 ], [ 278 ], [ 109 ], [ 0 ], [ 0 * ... \
<br>

<p>&nbsp;</p>
## 7 raw corpus codes - 7 to 999



**lns_corp_8** (textlines)

Number of lines with corpus code 8    

 8   General Rules Regarding Formation and Legislative Session; Discontinuity

**class:**  numeric \
<br>**unique:**  17 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 22 ]* \
<br>**examples:**  *[ 10 ], [ 0 ], [ 2 ], [ 9 ], [ 3 ], [ 7 ], [ 9 ], [ 10 ], [ 7 ], [ 9 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_9** (textlines)

Number of lines with corpus code 9    

 9   Final Provisions

**class:**  numeric \
<br>**unique:**  13 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 12 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 6 ], [ 0 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_10** (textlines)

Number of lines with corpus code 10   

 10  Miscellaneous (cannot be coded otherwise)

**class:**  numeric \
<br>**unique:**  48 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 164 ]* \
<br>**examples:**  *[ 4 ], [ 8 ], [ 5 ], [ 21 ], [ 19 ], [ 15 ], [ 11 ], [ 5 ], [ 24 ], [ 8 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_71** (textlines)

Number of lines with corpus code 71   

 7 Change and Interpretation of the Standing Orders 

 71 rules regarding changing the standing orders

**class:**  numeric \
<br>**unique:**  12 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 25 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 5 ], [ 6 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_72** (textlines)

Number of lines with corpus code 72   

 7 Change and Interpretation of the Standing Orders 

 72 rules regarding interpretation of and deviation from standing orders

**class:**  numeric \
<br>**unique:**  6 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 6 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 6 ], [ 0 ], [ 0 ], [ 0 ], [ 3 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_73** (textlines)

Number of lines with corpus code 73   

 7 Change and Interpretation of the Standing Orders 

 73 debate about standing orders and motions regarding the standing orders

**class:**  numeric \
<br>**unique:**  8 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 20 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 3 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_8** (textlines)

Number of words with corpus code 8    - see lns_corp_8    for more information.

**class:**  numeric \
<br>**unique:**  89 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 729 ]* \
<br>**examples:**  *[ 0 ], [ 347 ], [ 308 ], [ 271 ], [ 78 ], [ 0 ], [ 93 ], [ 315 ], [ 384 ], [ 64* ... \
<br>

<p>&nbsp;</p>

**wds_corp_9** (textlines)

Number of words with corpus code 9    - see lns_corp_9    for more information.

**class:**  numeric \
<br>**unique:**  45 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 633 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 24 ], [ 24 ], [ 0 ], [ 0 ], [ 42 ], [ 0 ], [ 0 ], [ 181 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_10** (textlines)

Number of words with corpus code 10   - see lns_corp_10   for more information.

**class:**  numeric \
<br>**unique:**  162 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 3571 ]* \
<br>**examples:**  *[ 435 ], [ 271 ], [ 358 ], [ 10 ], [ 275 ], [ 204 ], [ 61 ], [ 14 ], [ 3563 ], * ... \
<br>

<p>&nbsp;</p>

**wds_corp_71** (textlines)

Number of words with corpus code 71   - see lns_corp_71   for more information.

**class:**  numeric \
<br>**unique:**  43 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 588 ]* \
<br>**examples:**  *[ 0 ], [ 87 ], [ 27 ], [ 0 ], [ 0 ], [ 27 ], [ 93 ], [ 112 ], [ 0 ], [ 87 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_72** (textlines)

Number of words with corpus code 72   - see lns_corp_72   for more information.

**class:**  numeric \
<br>**unique:**  23 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 148 ]* \
<br>**examples:**  *[ 0 ], [ 148 ], [ 0 ], [ 37 ], [ 0 ], [ 42 ], [ 0 ], [ 0 ], [ 0 ], [ 42 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_73** (textlines)

Number of words with corpus code 73   - see lns_corp_73   for more information.

**class:**  numeric \
<br>**unique:**  18 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 296 ]* \
<br>**examples:**  *[ 245 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>
## 7 raw corpus codes - from 7 to 999



**lns_corp_999** (textlines)

Number of lines with corpus code 999  

 999 Footnotes and Titles Without Relevant Content

**class:**  integer \
<br>**unique:**  265 \
<br>**NAs:**  0 \
<br>**range:** *[ 29 ]* ... *[ 1728 ]* \
<br>**examples:**  *[ 262 ], [ 48 ], [ 47 ], [ 214 ], [ 217 ], [ 183 ], [ 169 ], [ 139 ], [ 43 ], [* ... \
<br>

<p>&nbsp;</p>

**wds_corp_999** (textlines)

Number of words with corpus code 999  - see lns_corp_999  for more information.

**class:**  integer \
<br>**unique:**  333 \
<br>**NAs:**  0 \
<br>**range:** *[ 38 ]* ... *[ 30211 ]* \
<br>**examples:**  *[ 87 ], [ 217 ], [ 751 ], [ 535 ], [ 194 ], [ 461 ], [ 532 ], [ 923 ], [ 162 ],* ... \
<br>

<p>&nbsp;</p>
## 8 aggregated corpus codes - topics



**lns_corp_top_1** (textlines)

Number of lines with aggregated corpus code 1  - lawmaking               

 codes: 111, 112, 113, 114, 121, 122, 123, 124, 125, 131, 132, 133, 134, 141, 142, 143, 144, 145 

**class:**  integer \
<br>**unique:**  114 \
<br>**NAs:**  0 \
<br>**range:** *[ 9 ]* ... *[ 192 ]* \
<br>**examples:**  *[ 71 ], [ 103 ], [ 99 ], [ 59 ], [ 89 ], [ 111 ], [ 71 ], [ 98 ], [ 58 ], [ 66 * ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_2** (textlines)

Number of lines with aggregated corpus code 2  - special decission rules 

 codes: 21, 22, 23, 241, 242, 243, 244, 26, 27, 28, 29, 67, 71, 72, 73

**class:**  numeric \
<br>**unique:**  130 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 342 ]* \
<br>**examples:**  *[ 119 ], [ 22 ], [ 67 ], [ 126 ], [ 112 ], [ 306 ], [ 15 ], [ 33 ], [ 113 ], [ * ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_3** (textlines)

Number of lines with aggregated corpus code 3  - elections               

 codes: 25, 31, 32, 33, 411, 421, 441 

**class:**  numeric \
<br>**unique:**  45 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 98 ]* \
<br>**examples:**  *[ 8 ], [ 15 ], [ 0 ], [ 42 ], [ 3 ], [ 19 ], [ 16 ], [ 13 ], [ 16 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_4** (textlines)

Number of lines with aggregated corpus code 4  - government control      

 codes: 412, 53, 54, 636, 637, 66 

**class:**  integer \
<br>**unique:**  83 \
<br>**NAs:**  0 \
<br>**range:** *[ 1 ]* ... *[ 164 ]* \
<br>**examples:**  *[ 55 ], [ 18 ], [ 18 ], [ 62 ], [ 61 ], [ 41 ], [ 22 ], [ 46 ], [ 13 ], [ 49 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_5** (textlines)

Number of lines with aggregated corpus code 5  - puplicity               

 codes: 121, 51, 52, 53, 55, 56, 611, 612, 613 

**class:**  integer \
<br>**unique:**  137 \
<br>**NAs:**  0 \
<br>**range:** *[ 7 ]* ... *[ 290 ]* \
<br>**examples:**  *[ 111 ], [ 149 ], [ 197 ], [ 60 ], [ 119 ], [ 88 ], [ 73 ], [ 99 ], [ 115 ], [ * ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_66** (textlines)

Number of lines with aggregated corpus code 66 - not used for aggregation

 codes: 34, 422, 43, 442, 45, 6211, 6212, 6221, 6222, 631, 632, 633, 634, 6351, 6352, 638, 639, 641, 642, 643, 651, 652, 653, 68, 8, 9, 10, 999

**class:**  integer \
<br>**unique:**  205 \
<br>**NAs:**  0 \
<br>**range:** *[ 21 ]* ... *[ 464 ]* \
<br>**examples:**  *[ 64 ], [ 206 ], [ 126 ], [ 114 ], [ 169 ], [ 153 ], [ 109 ], [ 272 ], [ 129 ],* ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_77** (textlines)

Number of lines with aggregated corpus code 77 - not relevant 

 codes: 999

**class:**  integer \
<br>**unique:**  265 \
<br>**NAs:**  0 \
<br>**range:** *[ 29 ]* ... *[ 1728 ]* \
<br>**examples:**  *[ 48 ], [ 351 ], [ 262 ], [ 29 ], [ 526 ], [ 448 ], [ 39 ], [ 97 ], [ 36 ], [ 2* ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_1** (textlines)

Number of words with aggregated corpus code 1 - lawmaking               

 codes: 111, 112, 113, 114, 121, 122, 123, 124, 125, 131, 132, 133, 134, 141, 142, 143, 144, 145 

**class:**  integer \
<br>**unique:**  334 \
<br>**NAs:**  0 \
<br>**range:** *[ 638 ]* ... *[ 7885 ]* \
<br>**examples:**  *[ 5541 ], [ 3964 ], [ 5543 ], [ 3742 ], [ 3048 ], [ 3990 ], [ 2358 ], [ 7376 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_2** (textlines)

Number of words with aggregated corpus code 2 - special decission rules 

 codes: 21, 22, 23, 241, 242, 243, 244, 26, 27, 28, 29, 67, 71, 72, 73

**class:**  numeric \
<br>**unique:**  325 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 11364 ]* \
<br>**examples:**  *[ 1520 ], [ 4873 ], [ 569 ], [ 5320 ], [ 480 ], [ 1218 ], [ 1313 ], [ 11108 ], * ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_3** (textlines)

Number of words with aggregated corpus code 3 - elections               

 codes: 25, 31, 32, 33, 411, 421, 441 

**class:**  numeric \
<br>**unique:**  128 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2478 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 786 ], [ 0 ], [ 1735 ], [ 1451 ], [ 1432 ], [ 0 ], [ 0 ], [ 67 * ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_4** (textlines)

Number of words with aggregated corpus code 4 - government control      

 codes: 412, 53, 54, 636, 637, 66 

**class:**  integer \
<br>**unique:**  271 \
<br>**NAs:**  0 \
<br>**range:** *[ 16 ]* ... *[ 5511 ]* \
<br>**examples:**  *[ 1369 ], [ 1544 ], [ 135 ], [ 765 ], [ 2429 ], [ 2204 ], [ 640 ], [ 4385 ], [ * ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_5** (textlines)

Number of words with aggregated corpus code 5 - puplicity               

 codes: 121, 51, 52, 53, 55, 56, 611, 612, 613 

**class:**  integer \
<br>**unique:**  368 \
<br>**NAs:**  0 \
<br>**range:** *[ 223 ]* ... *[ 10350 ]* \
<br>**examples:**  *[ 280 ], [ 3769 ], [ 2528 ], [ 7145 ], [ 2042 ], [ 2933 ], [ 1652 ], [ 4681 ], * ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_66** (textlines)

Number of words with aggregated corpus code 66 - not used for aggregation

 codes: 34, 422, 43, 442, 45, 6211, 6212, 6221, 6222, 631, 632, 633, 634, 6351, 6352, 638, 639, 641, 642, 643, 651, 652, 653, 68, 8, 9, 10

**class:**  integer \
<br>**unique:**  560 \
<br>**NAs:**  0 \
<br>**range:** *[ 1010 ]* ... *[ 13975 ]* \
<br>**examples:**  *[ 5422 ], [ 2957 ], [ 5231 ], [ 6048 ], [ 7093 ], [ 6211 ], [ 3579 ], [ 3119 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_77** (textlines)

Number of words with aggregated corpus code 77 - not relevant 

 codes: 999

**class:**  integer \
<br>**unique:**  333 \
<br>**NAs:**  0 \
<br>**range:** *[ 38 ]* ... *[ 30211 ]* \
<br>**examples:**  *[ 93 ], [ 197 ], [ 292 ], [ 87 ], [ 622 ], [ 232 ], [ 211 ], [ 2336 ], [ 340 ],* ... \
<br>

<p>&nbsp;</p>
## 9 aggregated corpus codes - actors



**lns_corp_act_1** (textlines)

Number of lines with aggregated corpus code 1  - MPs             

 codes: 111,651,652,653

**class:**  numeric \
<br>**unique:**  65 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 128 ]* \
<br>**examples:**  *[ 3 ], [ 55 ], [ 36 ], [ 12 ], [ 25 ], [ 25 ], [ 18 ], [ 37 ], [ 11 ], [ 10 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_act_2** (textlines)

Number of lines with aggregated corpus code 2  - PPGs            

 codes: 641,642,643

**class:**  numeric \
<br>**unique:**  23 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 61 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ 1 ], [ 6 ], [ 6 ], [ 0 ], [ 5 ], [ 0 ], [ 0 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_act_3** (textlines)

Number of lines with aggregated corpus code 3  - committees      

 codes: 125, 131, 132, 133, 134, 242, 54, 631, 632, 633, 634, 6351, 6352, 636, 637, 638, 639

**class:**  integer \
<br>**unique:**  168 \
<br>**NAs:**  0 \
<br>**range:** *[ 5 ]* ... *[ 404 ]* \
<br>**examples:**  *[ 60 ], [ 177 ], [ 31 ], [ 87 ], [ 140 ], [ 64 ], [ 33 ], [ 123 ], [ 88 ], [ 10* ... \
<br>

<p>&nbsp;</p>

**lns_corp_act_4** (textlines)

Number of lines with aggregated corpus code 4  - governing body  

 codes: 612, 6211, 6212, 6221, 6222

**class:**  numeric \
<br>**unique:**  64 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 126 ]* \
<br>**examples:**  *[ 14 ], [ 112 ], [ 44 ], [ 76 ], [ 105 ], [ 31 ], [ 77 ], [ 14 ], [ 34 ], [ 42 * ... \
<br>

<p>&nbsp;</p>

**lns_corp_act_66** (textlines)

Number of lines with aggregated corpus code 66 - not used for aggregation

 codes: 112, 123, 22, 55, 8, 56, 34, 113, 611, 121, 122, 51, 73, 21, 142, 32, 26, 71, 25, 53, 143, 23, 10, 9, 68, 412, 52, 411, 145, 43, 241, 243, 244, 72, 114, 613, 29, 124, 33, 31, 27, 28, 141, 442, 66, 441, 45, 422, 421, 144

**class:**  integer \
<br>**unique:**  284 \
<br>**NAs:**  0 \
<br>**range:** *[ 31 ]* ... *[ 738 ]* \
<br>**examples:**  *[ 654 ], [ 688 ], [ 224 ], [ 315 ], [ 193 ], [ 152 ], [ 159 ], [ 262 ], [ 360 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_act_77** (textlines)

Number of lines with aggregated corpus code 77 - not relevant 

 codes: 999

**class:**  integer \
<br>**unique:**  265 \
<br>**NAs:**  0 \
<br>**range:** *[ 29 ]* ... *[ 1728 ]* \
<br>**examples:**  *[ 175 ], [ 103 ], [ 214 ], [ 141 ], [ 383 ], [ 340 ], [ 163 ], [ 29 ], [ 421 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_1** (textlines)

Number of words with aggregated corpus code 1  - MPs             

 codes: 111,651,652,653

**class:**  numeric \
<br>**unique:**  202 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 4779 ]* \
<br>**examples:**  *[ 224 ], [ 311 ], [ 1050 ], [ 588 ], [ 492 ], [ 409 ], [ 241 ], [ 560 ], [ 0 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_2** (textlines)

Number of words with aggregated corpus code 2  - PPGs            

 codes: 641,642,643

**class:**  numeric \
<br>**unique:**  67 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 841 ]* \
<br>**examples:**  *[ 182 ], [ 229 ], [ 270 ], [ 30 ], [ 0 ], [ 152 ], [ 241 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_3** (textlines)

Number of words with aggregated corpus code 3  - committees      

 codes: 125, 131, 132, 133, 134, 242, 54, 631, 632, 633, 634, 6351, 6352, 636, 637, 638, 639

**class:**  integer \
<br>**unique:**  476 \
<br>**NAs:**  0 \
<br>**range:** *[ 264 ]* ... *[ 12091 ]* \
<br>**examples:**  *[ 12082 ], [ 1973 ], [ 2804 ], [ 5279 ], [ 771 ], [ 1891 ], [ 2172 ], [ 2493 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_4** (textlines)

Number of words with aggregated corpus code 4  - governing body  

 codes: 612, 6211, 6212, 6221, 6222

**class:**  numeric \
<br>**unique:**  201 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 3291 ]* \
<br>**examples:**  *[ 597 ], [ 3257 ], [ 1142 ], [ 48 ], [ 1188 ], [ 1277 ], [ 1462 ], [ 554 ], [ 3* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_66** (textlines)

Number of words with aggregated corpus code 66 - not used for aggregation

 codes: 112, 123, 22, 55, 8, 56, 34, 113, 611, 121, 122, 51, 73, 21, 142, 32, 26, 71, 25, 53, 143, 23, 10, 9, 68, 412, 52, 411, 145, 43, 241, 243, 244, 72, 114, 613, 29, 124, 33, 31, 27, 28, 141, 442, 66, 441, 45, 422, 421, 144

**class:**  integer \
<br>**unique:**  623 \
<br>**NAs:**  0 \
<br>**range:** *[ 1810 ]* ... *[ 25564 ]* \
<br>**examples:**  *[ 7305 ], [ 18919 ], [ 6888 ], [ 4117 ], [ 6471 ], [ 12758 ], [ 5371 ], [ 14973* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_77** (textlines)

Number of words with aggregated corpus code 77 - not relevant 

 codes: 999

**class:**  integer \
<br>**unique:**  333 \
<br>**NAs:**  0 \
<br>**range:** *[ 38 ]* ... *[ 30211 ]* \
<br>**examples:**  *[ 193 ], [ 340 ], [ 1500 ], [ 167 ], [ 198 ], [ 190 ], [ 132 ], [ 320 ], [ 107 * ... \
<br>

<p>&nbsp;</p>



# Appendix


## Coding Manual: Categories and Codes for Coding the Content of Parliamentary Standing Orders

### Basic Intuition:

Each and every code is exclusive, meaning that one subparagraph needs to have one code but one code only. For some codes there are notes on how to decide between multiple codes which may seem appropriate. Sometimes even the coding rules and additional notes will not help to decide between codes. In this case please let us know. Every decision accompanied by doubt should be documented.

### Further rules of the game:

-	Often sub-paragraphs can be coded differently, depending on whether or not one takes into consideration the overall context of the rule or the more specific regulation. If in doubt, code based on the overall context. Example: §14 GOBT: president grants vacation time &#8594; coded as rights and obligations of individual members of parliament if one takes into account the general context (652) and not as responsibility of the president (6212).

-	Rules which concern the interaction of two actors are attributed to the actor which takes the active part if he has discretion regarding this action. Example: §62 (2) GOBT: The plenary can request report of committee &#8594; coded as recall through the plenary (124) and not as report of committee to the plenary (134).

-	The right of those initiating a bill or law to be present at the committee meetings is coded as general right of individual members of parliament (652).



### Coding Scheme

**(1) Law Making**

&nbsp;

*Note: SPs that refer to both the plenary sessions and committees are coded as 12x; SPs dealing with both law-making and special decision procedures are coded as 1xx.*


* **11 Bills and Motions**
    + 111	types of bills and motions; printing and distribution of bills and motions to MPs
    + 112	right to initiate bills and motions 
    + 113	restrictions and deadlines (if not assignable to more specific category, e.g. code 121; 32; 134)
    + 114	legislative planning (concerns the whole term- general schedule)
* **12	Treatment of bills and motions in the plenary** *(Note: SPs including all stages of the treatment of bills and motions are coded as votes in the plenary (123); SPs which determine the subject of debate and vote are coded as subject of vote (123).)*
    + 121	debate in the plenary
    + 122	right of amendment in the plenary 
    + 123	subject of vote, rules of vote (including quorum), voting technology in the plenary
    + 124	the plenary as Committee of the Whole House *(Note: SPs referring to both committees and Committee of the Whole House are coded as committees (not 124 but 13x).)*
    + 125	referral to committee, withdrawal from committee
* **13	Treatment of bills and motions in committee** *(Note: SPs including all stages of the treatment of bills and motions in committee are coded as votes in committee (133); SPs which determine both the subject of debate and the subject of vote are coded as subject of vote in committee (133).)*
    + 131	debate in committee (including hearing) 
    + 132	amendment rights in committee
    + 133	subject of vote, rules of vote (including quorum), voting technology in committee
    + 134	report to the plenary


**(2) Special Decision Procedures other than Regular Law-Making**

&nbsp;

*Note: SPs which concern multiple special decision procedures apart from regular law-making are coded as follows: highest priority is given to constitutional matters, second highest priority is given to financial laws and budgeting, third highest priority is given to EU policy and fourth highest priority is given toforeign policy.*

* **21	constitutional change and amendment**
* **22	financial laws** (money bills) and budgeting
* **23	foreign policy**  (e.g. approval of law of nations, declaration of war *Note: If foreign policy and EU is treated together, the SP is coded as EU (241, 242, 243 or 244).*)
* **24	EU** *(Note: If foreign policy and EU is treated together, the SP is coded as EU (241, 242, 243 or 244))*
    + 241	treatment of EU-bills and motions
    + 242	EU-committee: election and resignation 
    + 243	instructions to the government concerning EU decisions
    + 244	further rights of participation in EU matters (e.g. debates about EU topics not based on EU bills and motions, reaction to violations of subsidiary principle) 
* **25	general rules on elections in parliament** (if not coded as election of government (31), or election of specific officials (411; 421; 441; 6211; 6221; 632))
* **26	further special decision procedures** leading to a decision, e.g. resolution, or leading to a decree/act/bylaw (not mere debate or question time) but cannot be coded as regular law-making nor special decision procedures (21-24)
* **27	procedures concerning laws that are hierarchically situated between regular laws and constitutional laws** (above regular laws; e.g. organic laws in Spain)
* **28 	emergency legislation**
* **29	relationship to sub-national level** (law-making, rights of participation of sub-national level)



**(3)	Relationship to Government**

&nbsp; 

*Note: If vote of no confidence and vote of confidence is treated together, the SP is coded as vote of no confidence (32).*

* **31	election of government / mandatory investiture vote; entry into office**
* **32	vote of no confidence / government resignation**
* **33	vote of confidence**
* **34	instructions to government, involvement of members of government in parliamentary activities** (rights to compel witnesses [usually right of parliament against members of government], right to speak [usually members of government's right], request of information about state of execution of decisions of parliament)


**(4)	Relationship to External Offices/Institutions apart from the Government**

* **41	parliamentary support bodies (e.g. general accounting office, ombudsman,...)**
    + 411	election and resignation
    + 412	competences and resources of external offices/institutions; relations to parliament (e.g. reports, questions, ...)
* **42	head of state**
    + 421	election and resignation
    + 422	relation to parliament (if not coded as law-making (141, 144))
* **43	second chamber (if not coded as law-making (142))**
* **44	constitutional courts**
    + 441	election and resignation
    + 442	relation to parliament (if not coded as law-making (145))
* **45	other external offices**


**(5)	Generating Publicity**

* **51	general rules regarding debate** (e.g. time allotted for speaking, proportional representation of parties during debate, closure of debate)
* **52	debates outside of law-making** (e.g. topical hours ...)
* **53	question rights**
* **54	petitions and petition committee**
* **55	relationship to media and citizens** (e.g. parliamentary TV, accreditation of journalists, publicity of meetings, admissibility of visitors); regulation of matters of confidentiality
* **56	protocols and parliamentary documents; forwarding of documents and decisions to other bodies**



**6	 Internal Organization of Parliament**

* **61	plenary**
    + 611	agenda setting and removal of items from the agenda (general rules which are not specifically regulated under 114)
    + 612	chairing of meetings and measures to uphold order
    + 613	sitting times *(Note: When members are to be present inside the parliament)*
* **62	parliamentary presiding bodies**
    + 621	president of parliament, vice presidents, secretaries and clerks
        * 6211	election, resignation and internal decision rules
        * 6212	responsibilities *(Note: if not coded as more specific category  (e.g. 612), Try to code in regard to the topic at first - 6212 only when no code corresponds)*
    + 622	council of elders or similar coordination body *(Note: The council of elders can be distinguished from the Presidency of Parliament (621) insofar as representatives of the parliamentary party groups are explicitly included.)*
        * 6221	composition, election, resignation, internal decision rules
        * 6222	responsibilities (if not coded as more specific category (e.g. 612))
* **63	committees** (if not coded as more specific category (e.g. 13; 24; 54; 55; 72))
    + 631	general regulations regarding types of committees
    + 632	membership and committee jurisdiction (area of influence-control .g. finance, economy, agriculture...)
    + 633	formal organizational units of committee *(Note: e.g. chair of committee, sub-committees, staff; This is about the appointment and election of the organizational units within committees and NOT about their responsibilities.)*
    + 634	agenda and procedures (details on how decisions are taken) within committees (if not coded as law-making (13))
    + 635	relations to other bodies
        * 6351	relation to plenary (if not coded as 124; 134; 34)
        * 6352 	relation to other committees
    + 636	investigative competencies of regular committees (NOT committees of inquiry (637))
		+ 637	committee of inquiry 
		+ 638	enquête commission
    + 639	other special committees which are not explicitly referenced in this coding manual  *(Note: e.g. oversight committees in Switzerland; Otherwise referenced are: EU-committee (242); committee of inquiry (637); petition committee (54); standing order committee (usually 72); council of elders or similar coordination body (622). Exception: committees which deal exclusively with the confirmation of the elections of members of parliament are coded as 651.)*
* **64	parliamentary party groups**
    + 641	formation of parliamentary party groups
    + 642	rights and obligations of parliamentary party groups (if not coded more specifically as e.g. 112; 51; 52; 53)
    + 643	financial and staff resources
* **65	individual members of parliament**
    + 651	election, entry into office, resignation, incompatibilities, legal status, immunity, indemnity
    + 652	rights and obligations of individual members of parliament (if not coded more specifically as e.g. 112; 51; 52; 53)
    + 653	salary, financial and staff resources
* **66	opposition**
* **67	special bodies for emergency situations**
* **68	parliamentary administration**



**7 	Change and Interpretation of the Standing Orders**

* **71	rules regarding changing the standing orders**
* **72	rules regarding interpretation of and deviation from standing orders**
* **73	debate about standing orders and motions regarding the standing orders**

**8 	General Rules Regarding Formation and Legislative Session; Discontinuity**

**9 	Final Provisions**

**10	Miscellaneous** (cannot be coded otherwise)

**999 	Footnotes and Titles Without Relevant Content**





