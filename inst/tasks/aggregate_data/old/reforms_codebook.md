---
title: "Code book"
author: "pm"
date: '2015-07-30 16:43:40'
output:
  pdf_document:
    keep_tex: yes
    number_sections: yes
  html_document:
    keep_md: yes
    number_sections: yes
    self_contained: no
---





# The reforms dataset (version 1.11)
The data-set is based on the IDEP data - data on Standing Orders versions, data on Standing Orders Text and data on Standing Orders change between versions. Information from all three sources are aggregated on Standing Orders version level - i.e. each version has its own line in the data-set. This aggregation allows for studying what happened - in an aggregate - at each reform of Standing Orders. 



# Shortcuts 

**SP** is short for subparagraph and in most cases identical to line or text line due to the fact that sub-paragraphs have been stored in a way that each subparagraph is stored on one line in a plain text file

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




```r
names(reforms)[!(names(reforms) %in% description$name)]
```

```
## [1] "lns_chg" "wds_chg"
```


```r
names(reforms)[!(description$name %in% names(reforms))]
```

```
## [1] "lns_chg" "wds_chg"
```


## meta



**t_id** (texts)

Unique identifier of a SO version by including country shorthand, date, and version counter.

<p>&nbsp;</p>\vspace{1em}

**t_date** (texts)

Date of the SO version - equals to (according to availibility) enactment, promulgation, acceptance.

<p>&nbsp;</p>\vspace{1em}

**t_dplus** (texts)

Version counter that is zero under normal circumstances but might be higher if more than one version got enacted on the same date.

<p>&nbsp;</p>\vspace{1em}

**t_country** (texts)

Country shorthand. In case of Swiss two seperate shorthands exist because there SO are spread among two bodies.

<p>&nbsp;</p>\vspace{1em}

**t_daccept** (texts)

Date on which the SO were accepted, voted upon, decided upon, ... .

<p>&nbsp;</p>\vspace{1em}

**t_dpromul** (texts)

Date on which the SO were promulgated - made puplic, printed, published, ... .

<p>&nbsp;</p>\vspace{1em}

**t_denact** (texts)

Date on which the SO were enacted - came into force / took effect.

<p>&nbsp;</p>\vspace{1em}
## db



**int_dupdate_texts** (db)

Date at which the 'texts' table of the database was last updated.

<p>&nbsp;</p>\vspace{1em}

**int_id_texts** (db)

Database internal enumeration of SO - this might change at any time. Do **not** use this as an id variable.

<p>&nbsp;</p>\vspace{1em}

**db_version** (db)

Version of the database from which was used to form the data set. On every change the version number goes up by 0.01 - there is no distinction between major and minor version.

<p>&nbsp;</p>\vspace{1em}

**db_lastupdate** (db)

Date at which the database was last updated.

<p>&nbsp;</p>\vspace{1em}
## length



**lns_all** (textlines)

Number of lines - also known as sub paragraphs - within a particular SO.

<p>&nbsp;</p>\vspace{1em}

**wds_raw_all** (textlines)

Number of words within a particular SO.

<p>&nbsp;</p>\vspace{1em}

**wds_clean_all** (textlines)

Number of words within a particular SO after having striped away enumerations like, a), b), ..., 1., 2., ... I, II, ... and so forth.

<p>&nbsp;</p>\vspace{1em}

**lns_rel** (textlines)

Number of lines that contain relevant content - e.g. no blank lines, no headlines, no appendices.

<p>&nbsp;</p>\vspace{1em}

**wds_raw_rel** (textlines)

Number of words that are not from irrelevant lines - e.g. no blank lines, no headlines, no appendices.

<p>&nbsp;</p>\vspace{1em}

**wds_clean_rel** (textlines)

Number of words that are not from irrelevant lines - e.g. no blank lines, no headlines, no appendices - after having striped away enumerations like, a), b), ..., 1., 2., ... I, II, ... and so forth.

<p>&nbsp;</p>\vspace{1em}
## change



**lns_mdf** (textlines)

Number of lines that were mofified - i.e. changed but not deleted or inserted

<p>&nbsp;</p>\vspace{1em}

**wds_mdf** (textlines)



<p>&nbsp;</p>\vspace{1em}
## 



**pro_maj_mdf** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_min_mdf** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_non_mdf** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_maj_mdf** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_min_mdf** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_non_mdf** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_ins** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**lns_ins** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_maj_ins** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_min_ins** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_non_ins** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_maj_ins** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_min_ins** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_non_ins** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_del** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**lns_del** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_maj_del** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_min_del** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_non_del** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_maj_del** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_min_del** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_non_del** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_maj** (linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_min** (linelinkage)



<p>&nbsp;</p>\vspace{1em}

**pro_non** (linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_maj** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_min** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_pro_non** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**lns_changed** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}

**wds_changed** (textlines, linelinkage)



<p>&nbsp;</p>\vspace{1em}
## raw corpus codes



**lns_corp_8** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_9** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_10** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_21** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_22** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_23** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_25** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_26** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_27** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_28** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_29** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_31** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_32** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_33** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_34** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_43** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_45** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_51** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_52** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_53** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_54** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_55** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_56** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_66** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_67** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_68** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_71** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_72** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_73** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_111** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_112** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_113** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_114** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_121** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_122** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_123** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_124** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_125** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_131** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_132** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_133** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_134** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_141** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_142** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_143** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_144** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_145** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_241** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_242** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_243** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_244** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_411** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_412** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_421** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_422** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_441** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_442** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_611** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_612** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_613** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_631** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_632** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_633** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_634** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_636** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_637** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_638** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_639** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_641** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_642** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_643** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_651** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_652** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_653** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_999** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_6211** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_6212** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_6221** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_6222** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_6351** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_6352** (textlines)



<p>&nbsp;</p>\vspace{1em}

**wds_corp_8** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_9** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_10** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_21** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_22** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_23** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_25** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_26** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_27** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_28** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_29** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_31** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_32** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_33** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_34** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_43** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_45** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_51** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_52** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_53** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_54** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_55** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_56** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_66** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_67** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_68** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_71** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_72** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_73** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_111** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_112** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_113** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_114** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_121** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_122** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_123** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_124** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_125** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_131** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_132** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_133** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_134** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_141** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_142** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_143** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_144** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_145** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_241** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_242** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_243** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_244** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_411** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_412** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_421** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_422** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_441** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_442** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_611** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_612** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_613** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_631** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_632** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_633** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_634** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_636** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_637** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_638** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_639** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_641** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_642** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_643** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_651** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_652** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_653** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_999** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_6211** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_6212** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_6221** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_6222** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_6351** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}

**wds_corp_6352** (textlines)

Number of words with corpus code ... . See lns_corp_... for more.

<p>&nbsp;</p>\vspace{1em}
## aggregated corpus codes



**lns_corp_agg_1** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_2** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_3** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_4** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_5** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_6** (textlines)



<p>&nbsp;</p>\vspace{1em}

**lns_corp_agg_7** (textlines)



<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_1** (textlines)



<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_2** (textlines)



<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_3** (textlines)



<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_4** (textlines)



<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_5** (textlines)



<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_6** (textlines)



<p>&nbsp;</p>\vspace{1em}

**wds_corp_agg_7** (textlines)



<p>&nbsp;</p>\vspace{1em}






















