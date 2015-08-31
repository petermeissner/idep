---
title: "Code book"
author: "pm"
date: '2015-08-26 12:04:52'
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
  select(t_id, wds_clean_rel, wds_chg, pro_min, pro_maj, wds_corp_agg_1)
```

```
## Error in eval(expr, envir, enclos): object 'wds_corp_agg_1' not found
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
<br>**examples:**  *[ UK_1965-11-09.0 ], [ NOR_1958-01-25.0 ], [ SWIGRN_2000-01-01.0 ], [ UK_1981-1* ... \
<br>

<p>&nbsp;</p>

**t_date** (texts)

Date of the SO version - equals to (according to availibility) enactment, promulgation, acceptance.

**class:**  character \
<br>**unique:**  702 \
<br>**NAs:**  0 \
<br>**range:** *[ 1903-01-20 ]* ... *[ 2011-07-01 ]* \
<br>**examples:**  *[ 1994-11-01 ], [ 1994-02-28 ], [ 2009-10-06 ], [ 1996-12-17 ], [ 1954-01-22 ],* ... \
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
<br>**examples:**  *[ IRE ], [ UK ], [ SWIPARLG ], [ FRA ], [ DEN ], [ POR ], [ BEL ], [ GER ], [ N* ... \
<br>

<p>&nbsp;</p>

**t_daccept** (texts)

Date on which the SO were accepted, voted upon, decided upon, ... .

**class:**  character \
<br>**unique:**  690 \
<br>**NAs:**  38 \
<br>**range:** *[ 1902-10-09 ]* ... *[ 2011-04-28 ]* \
<br>**examples:**  *[ 1966-07-01 ], [ 2002-12-11 ], [ 2007-02-06 ], [ 1984-07-27 ], [ 2007-06-22 ],* ... \
<br>

<p>&nbsp;</p>

**t_dpromul** (texts)

Date on which the SO were promulgated - made puplic, printed, published, ... .

**class:**  character \
<br>**unique:**  313 \
<br>**NAs:**  450 \
<br>**range:** *[ 1902-10-15 ]* ... *[ 2011-04-19 ]* \
<br>**examples:**  *[ 2008-03-17 ], [ NA ], [ NA ], [ 1999-11-25 ], [ NA ], [ 1987-04-15 ], [ NA ],* ... \
<br>

<p>&nbsp;</p>

**t_denact** (texts)

Date on which the SO were enacted - came into force / took effect.

**class:**  character \
<br>**unique:**  303 \
<br>**NAs:**  418 \
<br>**range:** *[ 1903-01-20 ]* ... *[ 2011-07-01 ]* \
<br>**examples:**  *[ NA ], [ 1988-04-01 ], [ NA ], [ NA ], [ 1980-01-01 ], [ NA ], [ 2002-02-21 ],* ... \
<br>

<p>&nbsp;</p>
## 2 db



**int_dupdate_texts** (db)

Date at which the 'texts' table of the database was last updated.

**class:**  character \
<br>**unique:**  19 \
<br>**NAs:**  0 \
<br>**range:** *[ 2015-08-26 11:10:14 ]* ... *[ 2015-08-26 11:45:55 ]* \
<br>**examples:**  *[ 2015-08-26 11:10:59 ], [ 2015-08-26 11:20:21 ], [ 2015-08-26 11:27:41 ], [ 20* ... \
<br>

<p>&nbsp;</p>

**int_id_texts** (db)

Database internal enumeration of SO - this might change at any time. Do **not** use this as an id variable.

**class:**  numeric \
<br>**unique:**  786 \
<br>**NAs:**  0 \
<br>**range:** *[ 1 ]* ... *[ 786 ]* \
<br>**examples:**  *[ 514 ], [ 335 ], [ 89 ], [ 384 ], [ 106 ], [ 728 ], [ 2 ], [ 411 ], [ 437 ], [* ... \
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
<br>**examples:**  *[ 304 ], [ 357 ], [ 316 ], [ 706 ], [ 821 ], [ 879 ], [ 794 ], [ 341 ], [ 1441 * ... \
<br>

<p>&nbsp;</p>

**wds_raw_all** (textlines)

Number of words within a particular SO.

**class:**  integer \
<br>**unique:**  744 \
<br>**NAs:**  0 \
<br>**range:** *[ 2318 ]* ... *[ 61397 ]* \
<br>**examples:**  *[ 20236 ], [ 4499 ], [ 20430 ], [ 21126 ], [ 23459 ], [ 29348 ], [ 27646 ], [ 9* ... \
<br>

<p>&nbsp;</p>

**wds_clean_all** (textlines)

Number of words within a particular SO after having striped away enumerations like, a), b), ..., 1., 2., ... I, II, ... and so forth.

**class:**  integer \
<br>**unique:**  739 \
<br>**NAs:**  0 \
<br>**range:** *[ 2236 ]* ... *[ 59628 ]* \
<br>**examples:**  *[ 20169 ], [ 9071 ], [ 11208 ], [ 22185 ], [ 11182 ], [ 19222 ], [ 22364 ], [ 1* ... \
<br>

<p>&nbsp;</p>

**lns_rel** (textlines)

Number of lines that contain relevant content - e.g. no blank lines, no headlines, no appendices.

**class:**  integer \
<br>**unique:**  401 \
<br>**NAs:**  0 \
<br>**range:** *[ 38 ]* ... *[ 1242 ]* \
<br>**examples:**  *[ 620 ], [ 219 ], [ 222 ], [ 515 ], [ 232 ], [ 533 ], [ 1176 ], [ 517 ], [ 265 * ... \
<br>

<p>&nbsp;</p>

**wds_raw_rel** (textlines)

Number of words that are not from irrelevant lines - e.g. no blank lines, no headlines, no appendices.

**class:**  integer \
<br>**unique:**  740 \
<br>**NAs:**  0 \
<br>**range:** *[ 2122 ]* ... *[ 43046 ]* \
<br>**examples:**  *[ 32547 ], [ 11517 ], [ 10420 ], [ 21643 ], [ 19490 ], [ 24008 ], [ 41678 ], [ * ... \
<br>

<p>&nbsp;</p>

**wds_clean_rel** (textlines)

Number of words that are not from irrelevant lines - e.g. no blank lines, no headlines, no appendices - after having striped away enumerations like, a), b), ..., 1., 2., ... I, II, ... and so forth.

**class:**  integer \
<br>**unique:**  742 \
<br>**NAs:**  0 \
<br>**range:** *[ 2122 ]* ... *[ 41488 ]* \
<br>**examples:**  *[ 16408 ], [ 10241 ], [ 10952 ], [ 6650 ], [ 6604 ], [ 9913 ], [ 21145 ], [ 290* ... \
<br>

<p>&nbsp;</p>
## 4 change



**lns_mdf** (textlines)

Number of lines that were mofified - i.e. changed but not deleted or inserted.

**class:**  numeric \
<br>**unique:**  98 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 583 ]* \
<br>**examples:**  *[ 0 ], [ 64 ], [ 15 ], [ 9 ], [ 0 ], [ 2 ], [ 14 ], [ 1 ], [ 125 ], [ 5 ]* ... \
<br>

<p>&nbsp;</p>

**wds_mdf** (textlines)

Number of words modified - i.e. changed but not deleted or inserted.

**class:**  numeric \
<br>**unique:**  347 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 12273 ]* \
<br>**examples:**  *[ 72 ], [ NA ], [ 92 ], [ 0 ], [ 66 ], [ 65 ], [ 50 ], [ 304 ], [ 268 ], [ 60 ]* ... \
<br>

<p>&nbsp;</p>

**wds_ins** (textlines, linelinkage)

Number of words that were inserted into SO.

**class:**  numeric \
<br>**unique:**  357 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 11246 ]* \
<br>**examples:**  *[ 112 ], [ 43 ], [ 0 ], [ 678 ], [ 327 ], [ 216 ], [ 0 ], [ 85 ], [ 463 ], [ 91* ... \
<br>

<p>&nbsp;</p>

**lns_ins** (textlines, linelinkage)

Number of lines that were inserted into SO.

**class:**  numeric \
<br>**unique:**  80 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 375 ]* \
<br>**examples:**  *[ 1 ], [ 1 ], [ 0 ], [ 4 ], [ 1 ], [ 4 ], [ 1 ], [ 15 ], [ 2 ], [ 3 ]* ... \
<br>

<p>&nbsp;</p>

**wds_del** (textlines, linelinkage)

Number of words that were deleted from old SO.

**class:**  numeric \
<br>**unique:**  204 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 6059 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 3 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_del** (textlines, linelinkage)

Number of lines that were deleted from old SO.

**class:**  numeric \
<br>**unique:**  51 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 229 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ 0 ], [ 58 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_chg** (textlines, linelinkage)

Number of lines that were changed from the old SO to the current - i.e. the sum of insertions, deletions and modifikations.

**class:**  numeric \
<br>**unique:**  134 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 778 ]* \
<br>**examples:**  *[ 14 ], [ 0 ], [ 10 ], [ 10 ], [ 3 ], [ 10 ], [ 11 ], [ 15 ], [ 1 ], [ 47 ]* ... \
<br>

<p>&nbsp;</p>

**wds_chg** (textlines, linelinkage)

Number of words that were changed from the old SO to the current - i.e. the sum of insertions, deletions and modifikations.

**class:**  numeric \
<br>**unique:**  519 \
<br>**NAs:**  16 \
<br>**range:** *[ 0 ]* ... *[ 23366 ]* \
<br>**examples:**  *[ 26 ], [ 570 ], [ 117 ], [ 201 ], [ 13 ], [ 141 ], [ 466 ], [ 19248 ], [ 366 ]* ... \
<br>

<p>&nbsp;</p>
## 5 minority/majority



**pro_maj_mdf** (textlines, linelinkage)

Number of lines modified that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  16 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 32 ]* \
<br>**examples:**  *[ 0 ], [ 4 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_min_mdf** (textlines, linelinkage)

Number of lines modified that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  17 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 25 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ NA ], [ 0 ], [ 0 ], [ 0 ], [ 2 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_non_mdf** (textlines, linelinkage)

Number of lines modified that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  85 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 583 ]* \
<br>**examples:**  *[ 6 ], [ 2 ], [ 0 ], [ 2 ], [ 3 ], [ 1 ], [ 3 ], [ 17 ], [ 0 ], [ 3 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_maj_mdf** (textlines, linelinkage)

Number of words modified that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  83 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 4008 ]* \
<br>**examples:**  *[ 38 ], [ 0 ], [ 0 ], [ 0 ], [ 190 ], [ 384 ], [ 308 ], [ NA ], [ NA ], [ 18 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_min_mdf** (textlines, linelinkage)

Number of words modified that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  83 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 1162 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 40 ], [ 2 ], [ 0 ], [ 2 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_non_mdf** (textlines, linelinkage)

Number of words modified that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  317 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 11883 ]* \
<br>**examples:**  *[ 13 ], [ 2 ], [ 105 ], [ NA ], [ 0 ], [ NA ], [ 554 ], [ 11 ], [ 391 ], [ 50 ]* ... \
<br>

<p>&nbsp;</p>

**pro_maj_ins** (textlines, linelinkage)

Number of lines inserted that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  15 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 38 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 1 ], [ NA ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_min_ins** (textlines, linelinkage)

Number of lines inserted that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  15 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 17 ]* \
<br>**examples:**  *[ 0 ], [ NA ], [ 0 ], [ 0 ], [ NA ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_non_ins** (textlines, linelinkage)

Number of lines inserted that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  73 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 317 ]* \
<br>**examples:**  *[ 1 ], [ 6 ], [ 12 ], [ 22 ], [ 0 ], [ 13 ], [ 1 ], [ 0 ], [ 0 ], [ 3 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_maj_ins** (textlines, linelinkage)

Number of words inserted that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  77 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 1439 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 541 ], [ 0 ], [ 0 ], [ NA ], [ NA ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_min_ins** (textlines, linelinkage)

Number of words inserted that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  80 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 601 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 466 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_non_ins** (textlines, linelinkage)

Number of words inserted that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  313 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 11108 ]* \
<br>**examples:**  *[ 403 ], [ 45 ], [ 184 ], [ 270 ], [ 0 ], [ 279 ], [ 21 ], [ NA ], [ 116 ], [ 9* ... \
<br>

<p>&nbsp;</p>

**pro_maj_del** (textlines, linelinkage)

Number of lines deleted that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  7 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 25 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ NA ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_min_del** (textlines, linelinkage)

Number of lines deleted that were coded as minority friendly.

**class:**  numeric \
<br>**unique:**  7 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 7 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_non_del** (textlines, linelinkage)

Number of lines deleted that were coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  46 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 229 ]* \
<br>**examples:**  *[ 1 ], [ 0 ], [ 0 ], [ 0 ], [ NA ], [ 1 ], [ 7 ], [ 13 ], [ 0 ], [ 5 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_maj_del** (textlines, linelinkage)

Number of words deleted that were coded as majority friendly.

**class:**  numeric \
<br>**unique:**  26 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 980 ]* \
<br>**examples:**  *[ 0 ], [ NA ], [ 0 ], [ NA ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 40 ], [ 0 ], [ 71 ], [ 376 ], [ 68 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_maj** (linelinkage)

Number of lines coded as majority friendly.

**class:**  numeric \
<br>**unique:**  24 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 44 ]* \
<br>**examples:**  *[ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 25 ], [ 1 ], [ NA ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_min** (linelinkage)

Number of lines coded as minority friendly.

**class:**  numeric \
<br>**unique:**  21 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 37 ]* \
<br>**examples:**  *[ NA ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**pro_non** (linelinkage)

Number of lines coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  121 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 778 ]* \
<br>**examples:**  *[ 5 ], [ 13 ], [ 25 ], [ 20 ], [ 186 ], [ 4 ], [ 11 ], [ 1 ], [ 2 ], [ 8 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_maj** (textlines, linelinkage)

Number of words coded as majority friendly.

**class:**  numeric \
<br>**unique:**  123 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 4022 ]* \
<br>**examples:**  *[ 11 ], [ NA ], [ 272 ], [ NA ], [ 67 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_min** (textlines, linelinkage)

Number of words coded as minority friendly.

**class:**  numeric \
<br>**unique:**  124 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 1680 ]* \
<br>**examples:**  *[ 101 ], [ 135 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_pro_non** (textlines, linelinkage)

Number of words coded as neither majority nor minority friendly.

**class:**  numeric \
<br>**unique:**  475 \
<br>**NAs:**  87 \
<br>**range:** *[ 0 ]* ... *[ 22843 ]* \
<br>**examples:**  *[ 5 ], [ 172 ], [ 763 ], [ 218 ], [ 68 ], [ 2383 ], [ 49 ], [ 46 ], [ 338 ], [ * ... \
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
<br>**examples:**  *[ 2 ], [ 2 ], [ 0 ], [ 6 ], [ 0 ], [ 0 ], [ 2 ], [ 2 ], [ 2 ], [ 7 ]* ... \
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
<br>**examples:**  *[ 3 ], [ 3 ], [ 6 ], [ 3 ], [ 0 ], [ 1 ], [ 2 ], [ 2 ], [ 3 ], [ 9 ]* ... \
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
<br>**examples:**  *[ 11 ], [ 7 ], [ 18 ], [ 3 ], [ 2 ], [ 11 ], [ 5 ], [ 1 ], [ 1 ], [ 4 ]* ... \
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
<br>**examples:**  *[ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 11 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 2 ], [ 2 ], [ 0 ], [ 29 ], [ 4 ], [ 1 ], [ 5 ], [ 3 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 5 ], [ 7 ], [ 0 ], [ 3 ], [ 6 ], [ 22 ], [ 3 ], [ 3 ], [ 24 ], [ 21 ]* ... \
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
<br>**examples:**  *[ 11 ], [ 8 ], [ 21 ], [ 33 ], [ 27 ], [ 9 ], [ 50 ], [ 17 ], [ 18 ], [ 15 ]* ... \
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
<br>**examples:**  *[ 3 ], [ 7 ], [ 0 ], [ 0 ], [ 0 ], [ 3 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 4 ], [ 7 ], [ 7 ], [ 7 ], [ 6 ], [ 6 ], [ 1 ], [ 19 ], [ 7 ], [ 7 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 3 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 7 ], [ 0 ], [ 0 ], [ 1 ], [ 1 ], [ 0 ], [ 7 ], [ 0 ], [ 0 ], [ 2 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 7 ], [ 1 ], [ 0 ], [ 7 ], [ 1 ], [ 5 ], [ 2 ], [ 2 ]* ... \
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
<br>**examples:**  *[ 15 ], [ 4 ], [ 6 ], [ 4 ], [ 4 ], [ 11 ], [ 1 ], [ 11 ], [ 4 ], [ 3 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 2 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 1 ], [ 6 ], [ 2 ], [ 9 ], [ 41 ], [ 1 ], [ 9 ], [ 2 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 4 ], [ 4 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 5 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_111** (textlines)

Number of words with corpus code 111  - see lns_corp_111  for more information.

**class:**  numeric \
<br>**unique:**  68 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 651 ]* \
<br>**examples:**  *[ 105 ], [ 260 ], [ 209 ], [ 19 ], [ 106 ], [ 45 ], [ 35 ], [ 256 ], [ 85 ], [ * ... \
<br>

<p>&nbsp;</p>

**wds_corp_112** (textlines)

Number of words with corpus code 112  - see lns_corp_112  for more information.

**class:**  numeric \
<br>**unique:**  79 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 522 ]* \
<br>**examples:**  *[ 169 ], [ 0 ], [ 277 ], [ 0 ], [ 169 ], [ 174 ], [ 69 ], [ 410 ], [ 89 ], [ 0 * ... \
<br>

<p>&nbsp;</p>

**wds_corp_113** (textlines)

Number of words with corpus code 113  - see lns_corp_113  for more information.

**class:**  numeric \
<br>**unique:**  100 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 806 ]* \
<br>**examples:**  *[ 237 ], [ 0 ], [ 427 ], [ 110 ], [ 757 ], [ 129 ], [ 110 ], [ 0 ], [ 122 ], [ * ... \
<br>

<p>&nbsp;</p>

**wds_corp_114** (textlines)

Number of words with corpus code 114  - see lns_corp_114  for more information.

**class:**  numeric \
<br>**unique:**  23 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 635 ]* \
<br>**examples:**  *[ 23 ], [ 0 ], [ 0 ], [ 23 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 30 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_121** (textlines)

Number of words with corpus code 121  - see lns_corp_121  for more information.

**class:**  numeric \
<br>**unique:**  109 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1536 ]* \
<br>**examples:**  *[ 73 ], [ 147 ], [ 627 ], [ 36 ], [ 1213 ], [ 465 ], [ 203 ], [ 486 ], [ 179 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_122** (textlines)

Number of words with corpus code 122  - see lns_corp_122  for more information.

**class:**  numeric \
<br>**unique:**  91 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1189 ]* \
<br>**examples:**  *[ 277 ], [ 388 ], [ 0 ], [ 44 ], [ 0 ], [ 231 ], [ 277 ], [ 0 ], [ 240 ], [ 721* ... \
<br>

<p>&nbsp;</p>

**wds_corp_123** (textlines)

Number of words with corpus code 123  - see lns_corp_123  for more information.

**class:**  integer \
<br>**unique:**  182 \
<br>**NAs:**  0 \
<br>**range:** *[ 80 ]* ... *[ 2366 ]* \
<br>**examples:**  *[ 556 ], [ 739 ], [ 700 ], [ 349 ], [ 349 ], [ 816 ], [ 433 ], [ 522 ], [ 431 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_124** (textlines)

Number of words with corpus code 124  - see lns_corp_124  for more information.

**class:**  numeric \
<br>**unique:**  18 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 498 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 457 ], [ 0 ], [ 0 ], [ 496 ], [ 0 ], [ 0 ], [ 0 ], [ 244 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_125** (textlines)

Number of words with corpus code 125  - see lns_corp_125  for more information.

**class:**  numeric \
<br>**unique:**  106 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1073 ]* \
<br>**examples:**  *[ 50 ], [ 694 ], [ 992 ], [ 115 ], [ 583 ], [ 336 ], [ 0 ], [ 486 ], [ 329 ], [* ... \
<br>

<p>&nbsp;</p>

**wds_corp_131** (textlines)

Number of words with corpus code 131  - see lns_corp_131  for more information.

**class:**  numeric \
<br>**unique:**  58 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 636 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 42 ], [ 61 ], [ 620 ], [ 61 ], [ 0 ], [ 35 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_132** (textlines)

Number of words with corpus code 132  - see lns_corp_132  for more information.

**class:**  numeric \
<br>**unique:**  46 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 435 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 29 ], [ 53 ], [ 0 ], [ 68 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_133** (textlines)

Number of words with corpus code 133  - see lns_corp_133  for more information.

**class:**  numeric \
<br>**unique:**  60 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 489 ]* \
<br>**examples:**  *[ 220 ], [ 377 ], [ 234 ], [ 13 ], [ 248 ], [ 78 ], [ 62 ], [ 69 ], [ 15 ], [ 4* ... \
<br>

<p>&nbsp;</p>

**wds_corp_134** (textlines)

Number of words with corpus code 134  - see lns_corp_134  for more information.

**class:**  numeric \
<br>**unique:**  126 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 761 ]* \
<br>**examples:**  *[ 337 ], [ 180 ], [ 250 ], [ 115 ], [ 142 ], [ 245 ], [ 160 ], [ 142 ], [ 180 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_141** (textlines)

Number of words with corpus code 141  - see lns_corp_141  for more information.

**class:**  numeric \
<br>**unique:**  9 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 187 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 107 ], [ 0 ], [ 0 ], [ 187 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_142** (textlines)

Number of words with corpus code 142  - see lns_corp_142  for more information.

**class:**  numeric \
<br>**unique:**  59 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1359 ]* \
<br>**examples:**  *[ 74 ], [ 0 ], [ 71 ], [ 0 ], [ 13 ], [ 0 ], [ 128 ], [ 11 ], [ 156 ], [ 194 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_143** (textlines)

Number of words with corpus code 143  - see lns_corp_143  for more information.

**class:**  numeric \
<br>**unique:**  18 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 555 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 138 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_144** (textlines)

Number of words with corpus code 144  - see lns_corp_144  for more information.

**class:**  numeric \
<br>**unique:**  10 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 136 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 28 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 8 ], [ 3 ], [ 7 ], [ 11 ], [ 0 ], [ 0 ], [ 1 ], [ 13 ], [ 2 ]* ... \
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
<br>**examples:**  *[ 28 ], [ 52 ], [ 41 ], [ 5 ], [ 10 ], [ 10 ], [ 13 ], [ 43 ], [ 41 ], [ 15 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 10 ], [ 0 ], [ 6 ], [ 1 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 26 ], [ 0 ], [ 17 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 22 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 3 ], [ 4 ], [ 0 ], [ 3 ], [ 8 ], [ 0 ], [ 1 ], [ 0 ], [ 6 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 5 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 29 ], [ 0 ], [ 0 ], [ 0 ], [ 35 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 5 ], [ 0 ], [ 24 ], [ 0 ], [ 0 ], [ 0 ], [ 14 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 4 ], [ 0 ], [ 0 ], [ 0 ], [ 43 ], [ 0 ], [ 38 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 3 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 3 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 28 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_21** (textlines)

Number of words with corpus code 21   - see lns_corp_21   for more information.

**class:**  numeric \
<br>**unique:**  54 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 885 ]* \
<br>**examples:**  *[ 0 ], [ 183 ], [ 0 ], [ 124 ], [ 258 ], [ 18 ], [ 51 ], [ 0 ], [ 124 ], [ 303 * ... \
<br>

<p>&nbsp;</p>

**wds_corp_22** (textlines)

Number of words with corpus code 22   - see lns_corp_22   for more information.

**class:**  numeric \
<br>**unique:**  155 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2938 ]* \
<br>**examples:**  *[ 166 ], [ 0 ], [ 0 ], [ 1980 ], [ 719 ], [ 2819 ], [ 27 ], [ 2045 ], [ 2630 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_23** (textlines)

Number of words with corpus code 23   - see lns_corp_23   for more information.

**class:**  numeric \
<br>**unique:**  40 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 777 ]* \
<br>**examples:**  *[ 209 ], [ 639 ], [ 0 ], [ 67 ], [ 0 ], [ 53 ], [ 67 ], [ 217 ], [ 121 ], [ 639* ... \
<br>

<p>&nbsp;</p>

**wds_corp_25** (textlines)

Number of words with corpus code 25   - see lns_corp_25   for more information.

**class:**  numeric \
<br>**unique:**  94 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1942 ]* \
<br>**examples:**  *[ 1284 ], [ 71 ], [ 136 ], [ 1461 ], [ 1462 ], [ 0 ], [ 0 ], [ 0 ], [ 190 ], [ * ... \
<br>

<p>&nbsp;</p>

**wds_corp_26** (textlines)

Number of words with corpus code 26   - see lns_corp_26   for more information.

**class:**  numeric \
<br>**unique:**  86 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2217 ]* \
<br>**examples:**  *[ 413 ], [ 817 ], [ 266 ], [ 1735 ], [ 0 ], [ 0 ], [ 66 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_27** (textlines)

Number of words with corpus code 27   - see lns_corp_27   for more information.

**class:**  numeric \
<br>**unique:**  15 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 475 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_28** (textlines)

Number of words with corpus code 28   - see lns_corp_28   for more information.

**class:**  numeric \
<br>**unique:**  8 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 775 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_29** (textlines)

Number of words with corpus code 29   - see lns_corp_29   for more information.

**class:**  numeric \
<br>**unique:**  70 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 8107 ]* \
<br>**examples:**  *[ 0 ], [ 7921 ], [ 1576 ], [ 0 ], [ 19 ], [ 525 ], [ 8081 ], [ 8077 ], [ 0 ], [* ... \
<br>

<p>&nbsp;</p>

**wds_corp_241** (textlines)

Number of words with corpus code 241  - see lns_corp_241  for more information.

**class:**  numeric \
<br>**unique:**  42 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1348 ]* \
<br>**examples:**  *[ 224 ], [ 0 ], [ 0 ], [ 64 ], [ 0 ], [ 0 ], [ 0 ], [ 123 ], [ 70 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_242** (textlines)

Number of words with corpus code 242  - see lns_corp_242  for more information.

**class:**  numeric \
<br>**unique:**  50 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1310 ]* \
<br>**examples:**  *[ 44 ], [ 0 ], [ 0 ], [ 1250 ], [ 0 ], [ 0 ], [ 317 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_243** (textlines)

Number of words with corpus code 243  - see lns_corp_243  for more information.

**class:**  numeric \
<br>**unique:**  7 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 84 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 70 ], [ 70 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_244** (textlines)

Number of words with corpus code 244  - see lns_corp_244  for more information.

**class:**  numeric \
<br>**unique:**  28 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 927 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 80 ], [ 42 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 15 ], [ 1 ], [ 10 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 2 ], [ 0 ], [ 0 ], [ 0 ], [ 2 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 4 ], [ 9 ], [ 0 ], [ 2 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 1 ], [ 2 ], [ 3 ], [ 3 ], [ 7 ], [ 4 ], [ 4 ], [ 4 ], [ 4 ], [ 12 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_31** (textlines)

Number of words with corpus code 31   - see lns_corp_31   for more information.

**class:**  numeric \
<br>**unique:**  17 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 426 ]* \
<br>**examples:**  *[ 27 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 376 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_32** (textlines)

Number of words with corpus code 32   - see lns_corp_32   for more information.

**class:**  numeric \
<br>**unique:**  33 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 861 ]* \
<br>**examples:**  *[ 0 ], [ 511 ], [ 55 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 775 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_33** (textlines)

Number of words with corpus code 33   - see lns_corp_33   for more information.

**class:**  numeric \
<br>**unique:**  19 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 268 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 157 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_34** (textlines)

Number of words with corpus code 34   - see lns_corp_34   for more information.

**class:**  numeric \
<br>**unique:**  102 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 860 ]* \
<br>**examples:**  *[ 99 ], [ 0 ], [ 150 ], [ 57 ], [ 9 ], [ 104 ], [ 859 ], [ 64 ], [ 64 ], [ 304 * ... \
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
<br>**examples:**  *[ 2 ], [ 4 ], [ 0 ], [ 0 ], [ 10 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 21 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 7 ], [ 0 ], [ 0 ], [ 0 ], [ 7 ], [ 6 ], [ 0 ], [ 6 ], [ 46 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 9 ], [ 0 ], [ 0 ], [ 4 ], [ 5 ], [ 5 ], [ 2 ]* ... \
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
<br>**examples:**  *[ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 58 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 163 ], [ 58 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 177 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_412** (textlines)

Number of words with corpus code 412  - see lns_corp_412  for more information.

**class:**  numeric \
<br>**unique:**  42 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 629 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 110 ], [ 0 ], [ 207 ], [ 130 ], [ 113 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_421** (textlines)

Number of words with corpus code 421  - see lns_corp_421  for more information.

**class:**  numeric \
<br>**unique:**  13 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 391 ]* \
<br>**examples:**  *[ 235 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_422** (textlines)

Number of words with corpus code 422  - see lns_corp_422  for more information.

**class:**  numeric \
<br>**unique:**  10 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 170 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 18 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_441** (textlines)

Number of words with corpus code 441  - see lns_corp_441  for more information.

**class:**  numeric \
<br>**unique:**  4 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 99 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 99 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_442** (textlines)

Number of words with corpus code 442  - see lns_corp_442  for more information.

**class:**  numeric \
<br>**unique:**  10 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 142 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 37 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 3 ], [ 9 ], [ 18 ], [ 11 ], [ 14 ], [ 9 ], [ 18 ], [ 10 ], [ 89 ], [ 11 ]* ... \
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
<br>**examples:**  *[ 2 ], [ 0 ], [ 0 ], [ 3 ], [ 2 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 27 ], [ 17 ], [ 7 ], [ 21 ], [ 16 ], [ 27 ], [ 89 ], [ 4 ], [ 15 ], [ 20 ]* ... \
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
<br>**examples:**  *[ 13 ], [ 0 ], [ 4 ], [ 7 ], [ 0 ], [ 5 ], [ 0 ], [ 9 ], [ 4 ], [ 7 ]* ... \
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
<br>**examples:**  *[ 4 ], [ 7 ], [ 67 ], [ 24 ], [ 0 ], [ 14 ], [ 21 ], [ 4 ], [ 9 ], [ 20 ]* ... \
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
<br>**examples:**  *[ 14 ], [ 60 ], [ 38 ], [ 5 ], [ 24 ], [ 14 ], [ 8 ], [ 14 ], [ 8 ], [ 9 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_51** (textlines)

Number of words with corpus code 51   - see lns_corp_51   for more information.

**class:**  numeric \
<br>**unique:**  171 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1649 ]* \
<br>**examples:**  *[ 779 ], [ 1299 ], [ 551 ], [ 591 ], [ 640 ], [ 1142 ], [ 888 ], [ 518 ], [ 701* ... \
<br>

<p>&nbsp;</p>

**wds_corp_52** (textlines)

Number of words with corpus code 52   - see lns_corp_52   for more information.

**class:**  numeric \
<br>**unique:**  43 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1025 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 295 ], [ 0 ], [ 236 ], [ 343 ], [ 654 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_53** (textlines)

Number of words with corpus code 53   - see lns_corp_53   for more information.

**class:**  numeric \
<br>**unique:**  189 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2691 ]* \
<br>**examples:**  *[ 663 ], [ 1136 ], [ 399 ], [ 0 ], [ 2461 ], [ 495 ], [ 740 ], [ 739 ], [ 1154 * ... \
<br>

<p>&nbsp;</p>

**wds_corp_54** (textlines)

Number of words with corpus code 54   - see lns_corp_54   for more information.

**class:**  numeric \
<br>**unique:**  74 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1106 ]* \
<br>**examples:**  *[ 418 ], [ 553 ], [ 473 ], [ 292 ], [ 0 ], [ 234 ], [ 510 ], [ 349 ], [ 92 ], [* ... \
<br>

<p>&nbsp;</p>

**wds_corp_55** (textlines)

Number of words with corpus code 55   - see lns_corp_55   for more information.

**class:**  numeric \
<br>**unique:**  128 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1851 ]* \
<br>**examples:**  *[ 1783 ], [ 227 ], [ 57 ], [ 144 ], [ 287 ], [ 372 ], [ 144 ], [ 582 ], [ 464 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_56** (textlines)

Number of words with corpus code 56   - see lns_corp_56   for more information.

**class:**  numeric \
<br>**unique:**  147 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1340 ]* \
<br>**examples:**  *[ 222 ], [ 210 ], [ 658 ], [ 300 ], [ 394 ], [ 278 ], [ 83 ], [ 0 ], [ 253 ], [* ... \
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
<br>**examples:**  *[ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 3 ], [ 1 ], [ 3 ], [ 0 ], [ 0 ], [ 0 ], [ 4 ], [ 8 ], [ 5 ], [ 5 ]* ... \
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
<br>**examples:**  *[ 5 ], [ 4 ], [ 20 ], [ 18 ], [ 9 ], [ 36 ], [ 3 ], [ 6 ], [ 19 ], [ 6 ]* ... \
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
<br>**examples:**  *[ 7 ], [ 16 ], [ 15 ], [ 6 ], [ 2 ], [ 6 ], [ 10 ], [ 5 ], [ 16 ], [ 16 ]* ... \
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
<br>**examples:**  *[ 7 ], [ 0 ], [ 7 ], [ 0 ], [ 11 ], [ 1 ], [ 2 ], [ 3 ], [ 1 ], [ 11 ]* ... \
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
<br>**examples:**  *[ 2 ], [ 11 ], [ 3 ], [ 5 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 6 ], [ 3 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 8 ], [ 7 ], [ 39 ], [ 46 ], [ 41 ], [ 16 ], [ 1 ], [ 8 ], [ 11 ]* ... \
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
<br>**examples:**  *[ 3 ], [ 9 ], [ 5 ], [ 2 ], [ 6 ], [ 3 ], [ 1 ], [ 4 ], [ 5 ], [ 9 ]* ... \
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
<br>**examples:**  *[ 7 ], [ 21 ], [ 5 ], [ 34 ], [ 34 ], [ 9 ], [ 8 ], [ 37 ], [ 1 ], [ 34 ]* ... \
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
<br>**examples:**  *[ 5 ], [ 1 ], [ 6 ], [ 5 ], [ 3 ], [ 3 ], [ 2 ], [ 1 ], [ 7 ], [ 1 ]* ... \
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
<br>**examples:**  *[ 11 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 3 ], [ 0 ], [ 0 ], [ 18 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 32 ], [ 0 ], [ 4 ], [ 6 ], [ 65 ], [ 9 ], [ 12 ], [ 13 ], [ 122 ], [ 13 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 5 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 3 ], [ 6 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 2 ], [ 2 ], [ 0 ], [ 0 ], [ 1 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 1 ], [ 0 ], [ 2 ], [ 0 ], [ 0 ], [ 0 ], [ 6 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 7 ], [ 2 ], [ 2 ], [ 6 ], [ 2 ], [ 23 ], [ 6 ], [ 5 ], [ 6 ], [ 9 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 25 ], [ 4 ], [ 34 ], [ 9 ], [ 7 ], [ 7 ], [ 18 ], [ 3 ], [ 3 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 2 ], [ 0 ], [ 0 ], [ 3 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 8 ], [ 2 ], [ 4 ], [ 7 ], [ 3 ], [ 4 ], [ 27 ], [ 7 ], [ 4 ], [ 36 ]* ... \
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
<br>**examples:**  *[ 7 ], [ 9 ], [ 2 ], [ 8 ], [ 8 ], [ 6 ], [ 17 ], [ 2 ], [ 3 ], [ 7 ]* ... \
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
<br>**examples:**  *[ 1 ], [ 2 ], [ 0 ], [ 0 ], [ 0 ], [ 3 ], [ 0 ], [ 1 ], [ 0 ], [ 4 ]* ... \
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
<br>**examples:**  *[ 2 ], [ 16 ], [ 0 ], [ 4 ], [ 2 ], [ 0 ], [ 6 ], [ 0 ], [ 12 ], [ 4 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 1 ], [ 1 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 1 ], [ 0 ], [ 6 ], [ 2 ], [ 1 ], [ 1 ], [ 0 ], [ 1 ], [ 5 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_66** (textlines)

Number of words with corpus code 66   - see lns_corp_66   for more information.

**class:**  numeric \
<br>**unique:**  2 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 41 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 41 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_67** (textlines)

Number of words with corpus code 67   - see lns_corp_67   for more information.

**class:**  numeric \
<br>**unique:**  8 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 137 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_68** (textlines)

Number of words with corpus code 68   - see lns_corp_68   for more information.

**class:**  numeric \
<br>**unique:**  77 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1093 ]* \
<br>**examples:**  *[ 660 ], [ 16 ], [ 172 ], [ 0 ], [ 120 ], [ 0 ], [ 402 ], [ 149 ], [ 33 ], [ 0 * ... \
<br>

<p>&nbsp;</p>

**wds_corp_611** (textlines)

Number of words with corpus code 611  - see lns_corp_611  for more information.

**class:**  numeric \
<br>**unique:**  157 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 6791 ]* \
<br>**examples:**  *[ 0 ], [ 191 ], [ 810 ], [ 3685 ], [ 323 ], [ 252 ], [ 0 ], [ 168 ], [ 0 ], [ 1* ... \
<br>

<p>&nbsp;</p>

**wds_corp_612** (textlines)

Number of words with corpus code 612  - see lns_corp_612  for more information.

**class:**  numeric \
<br>**unique:**  94 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2221 ]* \
<br>**examples:**  *[ 88 ], [ 123 ], [ 695 ], [ 120 ], [ 727 ], [ 229 ], [ 88 ], [ 455 ], [ 0 ], [ * ... \
<br>

<p>&nbsp;</p>

**wds_corp_613** (textlines)

Number of words with corpus code 613  - see lns_corp_613  for more information.

**class:**  numeric \
<br>**unique:**  96 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 842 ]* \
<br>**examples:**  *[ 273 ], [ 202 ], [ 202 ], [ 347 ], [ 157 ], [ 275 ], [ 306 ], [ 168 ], [ 427 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_631** (textlines)

Number of words with corpus code 631  - see lns_corp_631  for more information.

**class:**  numeric \
<br>**unique:**  56 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 518 ]* \
<br>**examples:**  *[ 0 ], [ 86 ], [ 0 ], [ 100 ], [ 0 ], [ 0 ], [ 14 ], [ 137 ], [ 260 ], [ 211 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_632** (textlines)

Number of words with corpus code 632  - see lns_corp_632  for more information.

**class:**  numeric \
<br>**unique:**  243 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1313 ]* \
<br>**examples:**  *[ 160 ], [ 210 ], [ 44 ], [ 497 ], [ 366 ], [ 440 ], [ 921 ], [ 27 ], [ 560 ], * ... \
<br>

<p>&nbsp;</p>

**wds_corp_633** (textlines)

Number of words with corpus code 633  - see lns_corp_633  for more information.

**class:**  numeric \
<br>**unique:**  94 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 790 ]* \
<br>**examples:**  *[ 84 ], [ 161 ], [ 255 ], [ 59 ], [ 195 ], [ 125 ], [ 82 ], [ 56 ], [ 20 ], [ 1* ... \
<br>

<p>&nbsp;</p>

**wds_corp_634** (textlines)

Number of words with corpus code 634  - see lns_corp_634  for more information.

**class:**  numeric \
<br>**unique:**  129 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1288 ]* \
<br>**examples:**  *[ 161 ], [ 152 ], [ 289 ], [ 471 ], [ 251 ], [ 70 ], [ 1087 ], [ 293 ], [ 134 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_636** (textlines)

Number of words with corpus code 636  - see lns_corp_636  for more information.

**class:**  numeric \
<br>**unique:**  84 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 878 ]* \
<br>**examples:**  *[ 83 ], [ 0 ], [ 540 ], [ 0 ], [ 0 ], [ 173 ], [ 0 ], [ 95 ], [ 0 ], [ 68 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_637** (textlines)

Number of words with corpus code 637  - see lns_corp_637  for more information.

**class:**  numeric \
<br>**unique:**  55 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2444 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 120 ], [ 798 ], [ 0 ], [ 120 ], [ 856 ], [ 0 ], [ 120 ], [ 120 * ... \
<br>

<p>&nbsp;</p>

**wds_corp_638** (textlines)

Number of words with corpus code 638  - see lns_corp_638  for more information.

**class:**  numeric \
<br>**unique:**  20 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 649 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 12 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_639** (textlines)

Number of words with corpus code 639  - see lns_corp_639  for more information.

**class:**  numeric \
<br>**unique:**  207 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 6014 ]* \
<br>**examples:**  *[ 304 ], [ 248 ], [ 4044 ], [ 1091 ], [ 648 ], [ 180 ], [ 877 ], [ 503 ], [ 189* ... \
<br>

<p>&nbsp;</p>

**wds_corp_641** (textlines)

Number of words with corpus code 641  - see lns_corp_641  for more information.

**class:**  numeric \
<br>**unique:**  45 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 439 ]* \
<br>**examples:**  *[ 182 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 78 ], [ 19 ], [ 72 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_642** (textlines)

Number of words with corpus code 642  - see lns_corp_642  for more information.

**class:**  numeric \
<br>**unique:**  32 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 643 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 16 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 164 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_643** (textlines)

Number of words with corpus code 643  - see lns_corp_643  for more information.

**class:**  numeric \
<br>**unique:**  22 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 202 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 133 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_651** (textlines)

Number of words with corpus code 651  - see lns_corp_651  for more information.

**class:**  numeric \
<br>**unique:**  121 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2439 ]* \
<br>**examples:**  *[ 200 ], [ 198 ], [ 1230 ], [ 0 ], [ 78 ], [ 223 ], [ 344 ], [ 2439 ], [ 484 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_652** (textlines)

Number of words with corpus code 652  - see lns_corp_652  for more information.

**class:**  numeric \
<br>**unique:**  113 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2080 ]* \
<br>**examples:**  *[ 81 ], [ 214 ], [ 487 ], [ 123 ], [ 224 ], [ 158 ], [ 292 ], [ 225 ], [ 360 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_653** (textlines)

Number of words with corpus code 653  - see lns_corp_653  for more information.

**class:**  numeric \
<br>**unique:**  14 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 328 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 148 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6211** (textlines)

Number of words with corpus code 6211 - see lns_corp_6211 for more information.

**class:**  numeric \
<br>**unique:**  96 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1308 ]* \
<br>**examples:**  *[ 209 ], [ 227 ], [ 318 ], [ 189 ], [ 176 ], [ 656 ], [ 176 ], [ 209 ], [ 186 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6212** (textlines)

Number of words with corpus code 6212 - see lns_corp_6212 for more information.

**class:**  numeric \
<br>**unique:**  106 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 1060 ]* \
<br>**examples:**  *[ 99 ], [ 216 ], [ 233 ], [ 152 ], [ 667 ], [ 36 ], [ 185 ], [ 224 ], [ 185 ], * ... \
<br>

<p>&nbsp;</p>

**wds_corp_6221** (textlines)

Number of words with corpus code 6221 - see lns_corp_6221 for more information.

**class:**  numeric \
<br>**unique:**  63 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 312 ]* \
<br>**examples:**  *[ 184 ], [ 117 ], [ 0 ], [ 35 ], [ 171 ], [ 286 ], [ 120 ], [ 128 ], [ 0 ], [ 1* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6222** (textlines)

Number of words with corpus code 6222 - see lns_corp_6222 for more information.

**class:**  numeric \
<br>**unique:**  61 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 598 ]* \
<br>**examples:**  *[ 0 ], [ 33 ], [ 0 ], [ 492 ], [ 0 ], [ 149 ], [ 0 ], [ 213 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6351** (textlines)

Number of words with corpus code 6351 - see lns_corp_6351 for more information.

**class:**  numeric \
<br>**unique:**  22 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 179 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 43 ], [ 46 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 128 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_6352** (textlines)

Number of words with corpus code 6352 - see lns_corp_6352 for more information.

**class:**  numeric \
<br>**unique:**  42 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 323 ]* \
<br>**examples:**  *[ 87 ], [ 0 ], [ 32 ], [ 17 ], [ 20 ], [ 0 ], [ 22 ], [ 0 ], [ 21 ], [ 196 ]* ... \
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
<br>**examples:**  *[ 7 ], [ 1 ], [ 7 ], [ 7 ], [ 7 ], [ 6 ], [ 0 ], [ 3 ], [ 0 ], [ 22 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_9** (textlines)

Number of lines with corpus code 9    

 9   Final Provisions

**class:**  numeric \
<br>**unique:**  13 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 12 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 6 ], [ 1 ], [ 0 ], [ 0 ], [ 2 ], [ 0 ], [ 1 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_10** (textlines)

Number of lines with corpus code 10   

 10  Miscellaneous (cannot be coded otherwise)

**class:**  numeric \
<br>**unique:**  48 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 164 ]* \
<br>**examples:**  *[ 9 ], [ 10 ], [ 21 ], [ 12 ], [ 2 ], [ 46 ], [ 26 ], [ 11 ], [ 21 ], [ 4 ]* ... \
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
<br>**examples:**  *[ 2 ], [ 0 ], [ 2 ], [ 0 ], [ 5 ], [ 1 ], [ 3 ], [ 1 ], [ 6 ], [ 5 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 3 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 2 ], [ 0 ], [ 1 ]* ... \
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
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_8** (textlines)

Number of words with corpus code 8    - see lns_corp_8    for more information.

**class:**  numeric \
<br>**unique:**  89 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 729 ]* \
<br>**examples:**  *[ 46 ], [ 315 ], [ 134 ], [ 275 ], [ 39 ], [ 226 ], [ 713 ], [ 64 ], [ 379 ], [* ... \
<br>

<p>&nbsp;</p>

**wds_corp_9** (textlines)

Number of words with corpus code 9    - see lns_corp_9    for more information.

**class:**  numeric \
<br>**unique:**  45 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 633 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_10** (textlines)

Number of words with corpus code 10   - see lns_corp_10   for more information.

**class:**  numeric \
<br>**unique:**  162 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 3571 ]* \
<br>**examples:**  *[ 194 ], [ 430 ], [ 1444 ], [ 483 ], [ 541 ], [ 286 ], [ 3528 ], [ 263 ], [ 263* ... \
<br>

<p>&nbsp;</p>

**wds_corp_71** (textlines)

Number of words with corpus code 71   - see lns_corp_71   for more information.

**class:**  numeric \
<br>**unique:**  43 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 588 ]* \
<br>**examples:**  *[ 0 ], [ 142 ], [ 0 ], [ 0 ], [ 27 ], [ 0 ], [ 0 ], [ 91 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_72** (textlines)

Number of words with corpus code 72   - see lns_corp_72   for more information.

**class:**  numeric \
<br>**unique:**  23 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 148 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 148 ], [ 144 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 37 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_73** (textlines)

Number of words with corpus code 73   - see lns_corp_73   for more information.

**class:**  numeric \
<br>**unique:**  18 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 296 ]* \
<br>**examples:**  *[ 91 ], [ 66 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 0 ], [ 284 ], [ 0 ], [ 0 ]* ... \
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
<br>**examples:**  *[ 144 ], [ 105 ], [ 344 ], [ 30 ], [ 525 ], [ 595 ], [ 44 ], [ 447 ], [ 45 ], [* ... \
<br>

<p>&nbsp;</p>

**wds_corp_999** (textlines)

Number of words with corpus code 999  - see lns_corp_999  for more information.

**class:**  integer \
<br>**unique:**  333 \
<br>**NAs:**  0 \
<br>**range:** *[ 38 ]* ... *[ 30211 ]* \
<br>**examples:**  *[ 324 ], [ 1103 ], [ 2388 ], [ 646 ], [ 1384 ], [ 1299 ], [ 314 ], [ 1030 ], [ * ... \
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
<br>**examples:**  *[ 157 ], [ 69 ], [ 55 ], [ 161 ], [ 62 ], [ 89 ], [ 52 ], [ 89 ], [ 105 ], [ 71* ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_2** (textlines)

Number of lines with aggregated corpus code 2  - special decission rules 

 codes: 21, 22, 23, 241, 242, 243, 244, 26, 27, 28, 29, 67, 71, 72, 73

**class:**  numeric \
<br>**unique:**  130 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 342 ]* \
<br>**examples:**  *[ 119 ], [ 75 ], [ 6 ], [ 16 ], [ 127 ], [ 16 ], [ 30 ], [ 85 ], [ 0 ], [ 321 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_3** (textlines)

Number of lines with aggregated corpus code 3  - elections               

 codes: 25, 31, 32, 33, 411, 421, 441 

**class:**  numeric \
<br>**unique:**  45 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 98 ]* \
<br>**examples:**  *[ 0 ], [ 16 ], [ 0 ], [ 50 ], [ 3 ], [ 16 ], [ 13 ], [ 16 ], [ 51 ], [ 3 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_4** (textlines)

Number of lines with aggregated corpus code 4  - government control      

 codes: 412, 53, 54, 636, 637, 66 

**class:**  integer \
<br>**unique:**  83 \
<br>**NAs:**  0 \
<br>**range:** *[ 1 ]* ... *[ 164 ]* \
<br>**examples:**  *[ 29 ], [ 78 ], [ 37 ], [ 43 ], [ 3 ], [ 24 ], [ 30 ], [ 30 ], [ 150 ], [ 65 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_5** (textlines)

Number of lines with aggregated corpus code 5  - puplicity               

 codes: 121, 51, 52, 53, 55, 56, 611, 612, 613 

**class:**  integer \
<br>**unique:**  137 \
<br>**NAs:**  0 \
<br>**range:** *[ 7 ]* ... *[ 290 ]* \
<br>**examples:**  *[ 73 ], [ 71 ], [ 120 ], [ 104 ], [ 149 ], [ 149 ], [ 54 ], [ 22 ], [ 115 ], [ * ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_66** (textlines)

Number of lines with aggregated corpus code 66 - not used for aggregation

 codes: 34, 422, 43, 442, 45, 6211, 6212, 6221, 6222, 631, 632, 633, 634, 6351, 6352, 638, 639, 641, 642, 643, 651, 652, 653, 68, 8, 9, 10, 999

**class:**  integer \
<br>**unique:**  205 \
<br>**NAs:**  0 \
<br>**range:** *[ 21 ]* ... *[ 464 ]* \
<br>**examples:**  *[ 126 ], [ 296 ], [ 363 ], [ 97 ], [ 101 ], [ 115 ], [ 97 ], [ 167 ], [ 233 ], * ... \
<br>

<p>&nbsp;</p>

**lns_corp_top_77** (textlines)

Number of lines with aggregated corpus code 77 - not relevant 

 codes: 999

**class:**  integer \
<br>**unique:**  265 \
<br>**NAs:**  0 \
<br>**range:** *[ 29 ]* ... *[ 1728 ]* \
<br>**examples:**  *[ 45 ], [ 652 ], [ 427 ], [ 423 ], [ 105 ], [ 103 ], [ 117 ], [ 175 ], [ 70 ], * ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_1** (textlines)

Number of words with aggregated corpus code 1 - lawmaking               

 codes: 111, 112, 113, 114, 121, 122, 123, 124, 125, 131, 132, 133, 134, 141, 142, 143, 144, 145 

**class:**  integer \
<br>**unique:**  334 \
<br>**NAs:**  0 \
<br>**range:** *[ 638 ]* ... *[ 7885 ]* \
<br>**examples:**  *[ 4484 ], [ 2323 ], [ 2258 ], [ 3233 ], [ 1738 ], [ 2020 ], [ 2133 ], [ 3990 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_2** (textlines)

Number of words with aggregated corpus code 2 - special decission rules 

 codes: 21, 22, 23, 241, 242, 243, 244, 26, 27, 28, 29, 67, 71, 72, 73

**class:**  numeric \
<br>**unique:**  325 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 11364 ]* \
<br>**examples:**  *[ 6979 ], [ 379 ], [ 1503 ], [ 65 ], [ 2079 ], [ 329 ], [ 1245 ], [ 678 ], [ 32* ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_3** (textlines)

Number of words with aggregated corpus code 3 - elections               

 codes: 25, 31, 32, 33, 411, 421, 441 

**class:**  numeric \
<br>**unique:**  128 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 2478 ]* \
<br>**examples:**  *[ 222 ], [ 0 ], [ 0 ], [ 219 ], [ 0 ], [ 222 ], [ 2388 ], [ 0 ], [ 440 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_4** (textlines)

Number of words with aggregated corpus code 4 - government control      

 codes: 412, 53, 54, 636, 637, 66 

**class:**  integer \
<br>**unique:**  271 \
<br>**NAs:**  0 \
<br>**range:** *[ 16 ]* ... *[ 5511 ]* \
<br>**examples:**  *[ 1267 ], [ 1081 ], [ 1293 ], [ 1126 ], [ 735 ], [ 1411 ], [ 927 ], [ 1385 ], [* ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_5** (textlines)

Number of words with aggregated corpus code 5 - puplicity               

 codes: 121, 51, 52, 53, 55, 56, 611, 612, 613 

**class:**  integer \
<br>**unique:**  368 \
<br>**NAs:**  0 \
<br>**range:** *[ 223 ]* ... *[ 10350 ]* \
<br>**examples:**  *[ 6102 ], [ 1817 ], [ 6824 ], [ 6544 ], [ 3865 ], [ 10055 ], [ 3872 ], [ 2310 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_66** (textlines)

Number of words with aggregated corpus code 66 - not used for aggregation

 codes: 34, 422, 43, 442, 45, 6211, 6212, 6221, 6222, 631, 632, 633, 634, 6351, 6352, 638, 639, 641, 642, 643, 651, 652, 653, 68, 8, 9, 10

**class:**  integer \
<br>**unique:**  560 \
<br>**NAs:**  0 \
<br>**range:** *[ 1010 ]* ... *[ 13975 ]* \
<br>**examples:**  *[ 5661 ], [ 5909 ], [ 5636 ], [ 2301 ], [ 2788 ], [ 13212 ], [ 4936 ], [ 2788 ]* ... \
<br>

<p>&nbsp;</p>

**wds_corp_top_77** (textlines)

Number of words with aggregated corpus code 77 - not relevant 

 codes: 999

**class:**  integer \
<br>**unique:**  333 \
<br>**NAs:**  0 \
<br>**range:** *[ 38 ]* ... *[ 30211 ]* \
<br>**examples:**  *[ 979 ], [ 1370 ], [ 368 ], [ 768 ], [ 978 ], [ 136 ], [ 923 ], [ 1333 ], [ 148* ... \
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
<br>**examples:**  *[ 18 ], [ 0 ], [ 25 ], [ 16 ], [ 35 ], [ 14 ], [ 18 ], [ 18 ], [ 24 ], [ 18 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_act_2** (textlines)

Number of lines with aggregated corpus code 2  - PPGs            

 codes: 641,642,643

**class:**  numeric \
<br>**unique:**  23 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 61 ]* \
<br>**examples:**  *[ 0 ], [ 0 ], [ 1 ], [ 0 ], [ 17 ], [ 8 ], [ 5 ], [ 0 ], [ 0 ], [ 0 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_act_3** (textlines)

Number of lines with aggregated corpus code 3  - committees      

 codes: 125, 131, 132, 133, 134, 242, 54, 631, 632, 633, 634, 6351, 6352, 636, 637, 638, 639

**class:**  integer \
<br>**unique:**  168 \
<br>**NAs:**  0 \
<br>**range:** *[ 5 ]* ... *[ 404 ]* \
<br>**examples:**  *[ 78 ], [ 115 ], [ 206 ], [ 35 ], [ 89 ], [ 76 ], [ 105 ], [ 51 ], [ 142 ], [ 7* ... \
<br>

<p>&nbsp;</p>

**lns_corp_act_4** (textlines)

Number of lines with aggregated corpus code 4  - governing body  

 codes: 612, 6211, 6212, 6221, 6222

**class:**  numeric \
<br>**unique:**  64 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 126 ]* \
<br>**examples:**  *[ 73 ], [ 30 ], [ 38 ], [ 34 ], [ 2 ], [ 16 ], [ 52 ], [ 2 ], [ 30 ], [ 82 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_act_66** (textlines)

Number of lines with aggregated corpus code 66 - not used for aggregation

 codes: 112, 123, 22, 55, 8, 56, 34, 113, 611, 121, 122, 51, 73, 21, 142, 32, 26, 71, 25, 53, 143, 23, 10, 9, 68, 412, 52, 411, 145, 43, 241, 243, 244, 72, 114, 613, 29, 124, 33, 31, 27, 28, 141, 442, 66, 441, 45, 422, 421, 144

**class:**  integer \
<br>**unique:**  284 \
<br>**NAs:**  0 \
<br>**range:** *[ 31 ]* ... *[ 738 ]* \
<br>**examples:**  *[ 249 ], [ 506 ], [ 521 ], [ 233 ], [ 284 ], [ 341 ], [ 497 ], [ 313 ], [ 143 ]* ... \
<br>

<p>&nbsp;</p>

**lns_corp_act_77** (textlines)

Number of lines with aggregated corpus code 77 - not relevant 

 codes: 999

**class:**  integer \
<br>**unique:**  265 \
<br>**NAs:**  0 \
<br>**range:** *[ 29 ]* ... *[ 1728 ]* \
<br>**examples:**  *[ 85 ], [ 595 ], [ 91 ], [ 34 ], [ 40 ], [ 44 ], [ 587 ], [ 93 ], [ 343 ], [ 42* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_1** (textlines)

Number of words with aggregated corpus code 1  - MPs             

 codes: 111,651,652,653

**class:**  numeric \
<br>**unique:**  202 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 4779 ]* \
<br>**examples:**  *[ 409 ], [ 626 ], [ 666 ], [ 483 ], [ 483 ], [ 478 ], [ 2236 ], [ 379 ], [ 642 * ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_2** (textlines)

Number of words with aggregated corpus code 2  - PPGs            

 codes: 641,642,643

**class:**  numeric \
<br>**unique:**  67 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 841 ]* \
<br>**examples:**  *[ 127 ], [ 30 ], [ 297 ], [ 55 ], [ 585 ], [ 42 ], [ 0 ], [ 397 ], [ 297 ], [ 2* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_3** (textlines)

Number of words with aggregated corpus code 3  - committees      

 codes: 125, 131, 132, 133, 134, 242, 54, 631, 632, 633, 634, 6351, 6352, 636, 637, 638, 639

**class:**  integer \
<br>**unique:**  476 \
<br>**NAs:**  0 \
<br>**range:** *[ 264 ]* ... *[ 12091 ]* \
<br>**examples:**  *[ 1177 ], [ 2819 ], [ 5039 ], [ 2399 ], [ 10846 ], [ 771 ], [ 1281 ], [ 1427 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_4** (textlines)

Number of words with aggregated corpus code 4  - governing body  

 codes: 612, 6211, 6212, 6221, 6222

**class:**  numeric \
<br>**unique:**  201 \
<br>**NAs:**  0 \
<br>**range:** *[ 0 ]* ... *[ 3291 ]* \
<br>**examples:**  *[ 3236 ], [ 688 ], [ 751 ], [ 3257 ], [ 1193 ], [ 560 ], [ 624 ], [ 560 ], [ 21* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_66** (textlines)

Number of words with aggregated corpus code 66 - not used for aggregation

 codes: 112, 123, 22, 55, 8, 56, 34, 113, 611, 121, 122, 51, 73, 21, 142, 32, 26, 71, 25, 53, 143, 23, 10, 9, 68, 412, 52, 411, 145, 43, 241, 243, 244, 72, 114, 613, 29, 124, 33, 31, 27, 28, 141, 442, 66, 441, 45, 422, 421, 144

**class:**  integer \
<br>**unique:**  623 \
<br>**NAs:**  0 \
<br>**range:** *[ 1810 ]* ... *[ 25564 ]* \
<br>**examples:**  *[ 8621 ], [ 4472 ], [ 4951 ], [ 4498 ], [ 5778 ], [ 3641 ], [ 7428 ], [ 8661 ],* ... \
<br>

<p>&nbsp;</p>

**wds_corp_act_77** (textlines)

Number of words with aggregated corpus code 77 - not relevant 

 codes: 999

**class:**  integer \
<br>**unique:**  333 \
<br>**NAs:**  0 \
<br>**range:** *[ 38 ]* ... *[ 30211 ]* \
<br>**examples:**  *[ 198 ], [ 731 ], [ 640 ], [ 177 ], [ 543 ], [ 1068 ], [ 44 ], [ 197 ], [ 363 ]* ... \
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





