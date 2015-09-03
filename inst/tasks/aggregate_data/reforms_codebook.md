# Code book
pm  
`r Sys.time()`  





# The reforms dataset (version 1.92)
The data-set is based on the IDEP data - data on Standing Orders versions (*texts*), data on Standing Orders Text (*textlines*) and data on Standing Orders change between versions (*linelinkage*). Information from all three sources are aggregated on Standing Orders version level - i.e. each version has its own line in the data-set. This aggregation allows for studying what happened - in an aggregate - at each reform of Standing Orders. 

The data set incorporates aggregated data for 
770 reforms in
15 countries and consists of 
723 variables. 

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
## 2  AUT_1948-06-04.0          7882     139       0       1           2523
## 3  AUT_1961-09-01.0          9151    2825      13       4           2832
## 4  AUT_1975-10-01.0         13600   12706      40      24           4242
## 5  AUT_1976-07-01.0         13676      78       1       0           4318
## 6  AUT_1979-10-01.0         13826     412       2       0           4356
## 7  AUT_1986-09-01.0         14225     771       2       3           4454
## 8  AUT_1989-01-01.0         16910    6343      34      25           4772
## 9  AUT_1993-09-15.0         18295    2529      12      12           4951
## 10 AUT_1996-10-15.0         20639    5942      23      32           5332
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




# Coding Manual: Categories and Codes for Coding the Content of Parliamentary Standing Orders

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





# Variable descriptions










## 01 meta



**t_id** (texts)

Unique identifier of a SO version by including country shorthand, date, and version counter.

**`class    :`** `    character `\
<br>**`unique   :`** `          786 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `            - `\
<br>**`range    :`** `[ AUT_1928-02-01.0 ] ... [ UK_2009-06-25.0 ] `\
<br>**`examples :`** ` [ITA_1999-09-24.0], [FRA_1969-11-30.0], [SWE_1986-09-01.0], [NOR_1997-05-26.0],  ... `\
<br>

<p>&nbsp;</p>

**t_date** (texts)

Date of the SO version - equals to (according to availibility) enactment, promulgation, acceptance.

**`class    :`** `    character `\
<br>**`unique   :`** `          702 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `            - `\
<br>**`range    :`** `[ 1903-01-20 ] ... [ 2011-07-01 ] `\
<br>**`examples :`** ` [2003-01-09], [1988-02-01], [1995-05-17], [1982-07-01], [1995-09-30], [1990-05-0 ... `\
<br>

<p>&nbsp;</p>

**t_dplus** (texts)

Version counter that is zero under normal circumstances but might be higher if more than one version got enacted on the same date.

**`class    :`** `      integer `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           62 `\
<br>**`sum      :`** `          100 `\
<br>**`range    :`** `[ 0 ] ... [ 4 ] `\
<br>**`examples :`** ` [1], [0], [0], [0], [0], [1], [0], [0], [1], [0] ... `\
<br>

<p>&nbsp;</p>

**t_country** (texts)

Country shorthand. In case of Swiss two seperate shorthands exist because there SO are spread among two bodies.

**`class    :`** `    character `\
<br>**`unique   :`** `           16 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `            - `\
<br>**`range    :`** `[ AUT ] ... [ UK ] `\
<br>**`examples :`** ` [SWE], [NED], [UK], [IRE], [UK], [UK], [NOR], [UK], [NOR], [BEL] ... `\
<br>

<p>&nbsp;</p>

**t_daccept** (texts)

Date on which the SO were accepted, voted upon, decided upon, ... .

**`class    :`** `    character `\
<br>**`unique   :`** `          690 `\
<br>**`NAs      :`** `           38 `\
<br>**`not-NA   :`** `          748 `\
<br>**`not-0-NA :`** `          748 `\
<br>**`sum      :`** `            - `\
<br>**`range    :`** `[ 1902-10-09 ] ... [ 2011-04-28 ] `\
<br>**`examples :`** ` [1948-04-10], [1975-12-03], [1979-07-04], [2007-11-30], [1990-02-21], [1977-06-1 ... `\
<br>

<p>&nbsp;</p>

**t_dpromul** (texts)

Date on which the SO were promulgated - made puplic, printed, published, ... .

**`class    :`** `    character `\
<br>**`unique   :`** `          307 `\
<br>**`NAs      :`** `          456 `\
<br>**`not-NA   :`** `          330 `\
<br>**`not-0-NA :`** `          330 `\
<br>**`sum      :`** `            - `\
<br>**`range    :`** `[ 1928-12-26 ] ... [ 2011-04-19 ] `\
<br>**`examples :`** ` [NA], [NA], [NA], [NA], [2001-05-30], [1997-02-26], [NA], [1957-12-18], [1992-06 ... `\
<br>

<p>&nbsp;</p>

**t_denact** (texts)

Date on which the SO were enacted - came into force / took effect.

**`class    :`** `    character `\
<br>**`unique   :`** `          303 `\
<br>**`NAs      :`** `          418 `\
<br>**`not-NA   :`** `          368 `\
<br>**`not-0-NA :`** `          368 `\
<br>**`sum      :`** `            - `\
<br>**`range    :`** `[ 1903-01-20 ] ... [ 2011-07-01 ] `\
<br>**`examples :`** ` [NA], [NA], [NA], [1979-10-01], [NA], [NA], [NA], [NA], [2000-07-01], [NA] ... `\
<br>

<p>&nbsp;</p>
## 02 db



**int_dupdate_texts** (db)

Date at which the 'texts' table of the database was last updated.

**`class    :`** `    character `\
<br>**`unique   :`** `           16 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `            - `\
<br>**`range    :`** `[ 2015-08-27 13:20:49 ] ... [ 2015-08-28 11:48:07 ] `\
<br>**`examples :`** ` [2015-08-27 14:05:44], [2015-08-27 17:24:51], [2015-08-27 16:12:55], [2015-08-27 ... `\
<br>

<p>&nbsp;</p>

**int_id_texts** (db)

Database internal enumeration of SO - this might change at any time. Do **not** use this as an id variable.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          786 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      322 979 `\
<br>**`range    :`** `[ 1 ] ... [ 860 ] `\
<br>**`examples :`** ` [456], [573], [619], [839], [225], [549], [822], [381], [321], [111] ... `\
<br>

<p>&nbsp;</p>

**db_version** (db)

Version of the database which was used to create the data set. On every change the version number goes up by 0.01 - there is no distinction between major and minor version.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            1 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `     1 509.12 `\
<br>**`range    :`** `[ 1.92 ] ... [ 1.92 ] `\
<br>**`examples :`** ` [1.92], [1.92], [1.92], [1.92], [1.92], [1.92], [1.92], [1.92], [1.92], [1.92] ... `\
<br>

<p>&nbsp;</p>

**db_lastupdate** (db)

Date at which the database was last updated.

**`class    :`** `    character `\
<br>**`unique   :`** `            1 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `            - `\
<br>**`range    :`** `[ 2015-08-28 11:49:48 ] ... [ 2015-08-28 11:49:48 ] `\
<br>**`examples :`** ` [2015-08-28 11:49:48], [2015-08-28 11:49:48], [2015-08-28 11:49:48], [2015-08-28 ... `\
<br>

<p>&nbsp;</p>
## 03 length



**lns_all** (textlines)

Number of lines - also known as sub paragraphs - within a particular SO.

**`class    :`** `      integer `\
<br>**`unique   :`** `          473 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      528 002 `\
<br>**`range    :`** `[ 88 ] ... [ 2645 ] `\
<br>**`examples :`** ` [284], [292], [566], [420], [1319], [959], [832], [574], [388], [265] ... `\
<br>

<p>&nbsp;</p>

**wds_raw_all** (textlines)

Number of words within a particular SO.

**`class    :`** `      integer `\
<br>**`unique   :`** `          744 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `   13 299 515 `\
<br>**`range    :`** `[ 2318 ] ... [ 61397 ] `\
<br>**`examples :`** ` [10712], [8189], [44569], [12911], [4739], [16218], [8212], [12645], [11210], [1 ... `\
<br>

<p>&nbsp;</p>

**wds_clean_all** (textlines)

Number of words within a particular SO after having striped away enumerations like, a), b), ..., 1., 2., ... I, II, ... and so forth.

**`class    :`** `      integer `\
<br>**`unique   :`** `          739 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `   12 807 889 `\
<br>**`range    :`** `[ 2236 ] ... [ 59628 ] `\
<br>**`examples :`** ` [14754], [20189], [15547], [31648], [8478], [8960], [23051], [16346], [59628], [ ... `\
<br>

<p>&nbsp;</p>

**lns_rel** (textlines)

Number of lines that contain relevant content - e.g. no blank lines, no headlines, no appendices.

**`class    :`** `      integer `\
<br>**`unique   :`** `          389 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      365 434 `\
<br>**`range    :`** `[ 38 ] ... [ 1239 ] `\
<br>**`examples :`** ` [842], [323], [862], [537], [339], [636], [349], [1088], [232], [423] ... `\
<br>

<p>&nbsp;</p>

**wds_raw_rel** (textlines)

Number of words that are not from irrelevant lines - e.g. no blank lines, no headlines, no appendices.

**`class    :`** `      integer `\
<br>**`unique   :`** `          733 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `   12 714 053 `\
<br>**`range    :`** `[ 2122 ] ... [ 43031 ] `\
<br>**`examples :`** ` [8086], [6216], [22860], [9413], [22713], [10760], [10361], [11388], [18787], [9 ... `\
<br>

<p>&nbsp;</p>

**wds_clean_rel** (textlines)

Number of words that are not from irrelevant lines - e.g. no blank lines, no headlines, no appendices - after having striped away enumerations like, a), b), ..., 1., 2., ... I, II, ... and so forth.

**`class    :`** `      integer `\
<br>**`unique   :`** `          744 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `   12 354 641 `\
<br>**`range    :`** `[ 2122 ] ... [ 41476 ] `\
<br>**`examples :`** ` [7709], [22739], [21461], [40472], [12751], [17643], [13534], [10340], [14226],  ... `\
<br>

<p>&nbsp;</p>
## 04 change



**lns_mdf** (textlines)

Number of lines that were mofified - i.e. changed but not deleted or inserted.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           98 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          655 `\
<br>**`sum      :`** `       12 970 `\
<br>**`range    :`** `[ 0 ] ... [ 583 ] `\
<br>**`examples :`** ` [583], [8], [11], [61], [0], [0], [12], [0], [2], [45] ... `\
<br>

<p>&nbsp;</p>

**wds_mdf** (textlines)

Number of words modified - i.e. changed but not deleted or inserted.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          345 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          652 `\
<br>**`sum      :`** `      287 218 `\
<br>**`range    :`** `[ 0 ] ... [ 12273 ] `\
<br>**`examples :`** ` [2], [484], [638], [0], [14], [220], [32], [70], [41], [55] ... `\
<br>

<p>&nbsp;</p>

**wds_ins** (textlines, linelinkage)

Number of words that were inserted into SO.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          358 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          562 `\
<br>**`sum      :`** `      264 238 `\
<br>**`range    :`** `[ 0 ] ... [ 11246 ] `\
<br>**`examples :`** ` [95], [21], [145], [855], [0], [0], [2186], [NA], [99], [185] ... `\
<br>

<p>&nbsp;</p>

**lns_ins** (textlines, linelinkage)

Number of lines that were inserted into SO.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           78 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          562 `\
<br>**`sum      :`** `        8 665 `\
<br>**`range    :`** `[ 0 ] ... [ 381 ] `\
<br>**`examples :`** ` [0], [237], [5], [56], [1], [0], [1], [0], [8], [15] ... `\
<br>

<p>&nbsp;</p>

**wds_del** (textlines, linelinkage)

Number of words that were deleted from old SO.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          207 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          307 `\
<br>**`sum      :`** `      106 063 `\
<br>**`range    :`** `[ 0 ] ... [ 6059 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [139], [0], [43], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_del** (textlines, linelinkage)

Number of lines that were deleted from old SO.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           51 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          308 `\
<br>**`sum      :`** `        3 478 `\
<br>**`range    :`** `[ 0 ] ... [ 229 ] `\
<br>**`examples :`** ` [0], [0], [1], [2], [0], [0], [176], [0], [NA], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_chg** (textlines, linelinkage)

Number of lines that were changed from the old SO to the current - i.e. the sum of insertions, deletions and modifikations.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          124 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          765 `\
<br>**`sum      :`** `       25 113 `\
<br>**`range    :`** `[ 0 ] ... [ 1049 ] `\
<br>**`examples :`** ` [30], [4], [16], [2], [15], [1], [5], [1], [4], [2] ... `\
<br>

<p>&nbsp;</p>

**wds_chg** (textlines, linelinkage)

Number of words that were changed from the old SO to the current - i.e. the sum of insertions, deletions and modifikations.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          490 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          763 `\
<br>**`sum      :`** `      657 519 `\
<br>**`range    :`** `[ 0 ] ... [ 28711 ] `\
<br>**`examples :`** ` [12], [240], [182], [6095], [1302], [125], [5], [43], [3172], [52] ... `\
<br>

<p>&nbsp;</p>
## 05 minority/majority



**pro_maj_mdf** (textlines, linelinkage)

Number of lines modified that were coded as majority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           16 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          108 `\
<br>**`sum      :`** `          335 `\
<br>**`range    :`** `[ 0 ] ... [ 20 ] `\
<br>**`examples :`** ` [2], [1], [0], [0], [0], [4], [0], [0], [NA], [1] ... `\
<br>

<p>&nbsp;</p>

**pro_min_mdf** (textlines, linelinkage)

Number of lines modified that were coded as minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           17 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          128 `\
<br>**`sum      :`** `          384 `\
<br>**`range    :`** `[ 0 ] ... [ 25 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**pro_non_mdf** (textlines, linelinkage)

Number of lines modified that were coded as neither majority nor minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           85 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          581 `\
<br>**`sum      :`** `       11 429 `\
<br>**`range    :`** `[ 0 ] ... [ 583 ] `\
<br>**`examples :`** ` [4], [11], [NA], [7], [0], [10], [19], [2], [7], [12] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_maj_mdf** (textlines, linelinkage)

Number of words modified that were coded as majority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           83 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          108 `\
<br>**`sum      :`** `       12 191 `\
<br>**`range    :`** `[ 0 ] ... [ 2355 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_min_mdf** (textlines, linelinkage)

Number of words modified that were coded as minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           83 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          128 `\
<br>**`sum      :`** `       12 897 `\
<br>**`range    :`** `[ 0 ] ... [ 1162 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [94], [0], [0], [0], [152] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_non_mdf** (textlines, linelinkage)

Number of words modified that were coded as neither majority nor minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          316 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          578 `\
<br>**`sum      :`** `      239 511 `\
<br>**`range    :`** `[ 0 ] ... [ 11883 ] `\
<br>**`examples :`** ` [361], [NA], [0], [50], [NA], [88], [4254], [40], [0], [2232] ... `\
<br>

<p>&nbsp;</p>

**pro_maj_ins** (textlines, linelinkage)

Number of lines inserted that were coded as majority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           15 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `           95 `\
<br>**`sum      :`** `          300 `\
<br>**`range    :`** `[ 0 ] ... [ 38 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [NA], [0] ... `\
<br>

<p>&nbsp;</p>

**pro_min_ins** (textlines, linelinkage)

Number of lines inserted that were coded as minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           15 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          100 `\
<br>**`sum      :`** `          249 `\
<br>**`range    :`** `[ 0 ] ... [ 17 ] `\
<br>**`examples :`** ` [0], [0], [NA], [1], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**pro_non_ins** (textlines, linelinkage)

Number of lines inserted that were coded as neither majority nor minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           71 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          487 `\
<br>**`sum      :`** `        6 910 `\
<br>**`range    :`** `[ 0 ] ... [ 317 ] `\
<br>**`examples :`** ` [NA], [0], [0], [0], [0], [25], [0], [0], [0], [15] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_maj_ins** (textlines, linelinkage)

Number of words inserted that were coded as majority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           77 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `           95 `\
<br>**`sum      :`** `       10 939 `\
<br>**`range    :`** `[ 0 ] ... [ 1439 ] `\
<br>**`examples :`** ` [66], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_min_ins** (textlines, linelinkage)

Number of words inserted that were coded as minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           80 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          100 `\
<br>**`sum      :`** `       11 759 `\
<br>**`range    :`** `[ 0 ] ... [ 601 ] `\
<br>**`examples :`** ` [0], [349], [39], [0], [49], [0], [55], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_non_ins** (textlines, linelinkage)

Number of words inserted that were coded as neither majority nor minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          319 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          487 `\
<br>**`sum      :`** `      216 896 `\
<br>**`range    :`** `[ 0 ] ... [ 11108 ] `\
<br>**`examples :`** ` [2292], [299], [NA], [0], [633], [12], [1467], [273], [241], [54] ... `\
<br>

<p>&nbsp;</p>

**pro_maj_del** (textlines, linelinkage)

Number of lines deleted that were coded as majority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `           25 `\
<br>**`sum      :`** `           62 `\
<br>**`range    :`** `[ 0 ] ... [ 25 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**pro_min_del** (textlines, linelinkage)

Number of lines deleted that were coded as minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `           25 `\
<br>**`sum      :`** `           41 `\
<br>**`range    :`** `[ 0 ] ... [ 7 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**pro_non_del** (textlines, linelinkage)

Number of lines deleted that were coded as neither majority nor minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           46 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          276 `\
<br>**`sum      :`** `        2 815 `\
<br>**`range    :`** `[ 0 ] ... [ 229 ] `\
<br>**`examples :`** ` [26], [0], [0], [1], [0], [NA], [4], [0], [NA], [22] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_maj_del** (textlines, linelinkage)

Number of words deleted that were coded as majority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           26 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `           25 `\
<br>**`sum      :`** `        2 736 `\
<br>**`range    :`** `[ 0 ] ... [ 980 ] `\
<br>**`examples :`** ` [0], [0], [NA], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_min_del** (textlines, linelinkage)

Number of words deleted that were coded as minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           26 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `           25 `\
<br>**`sum      :`** `        1 353 `\
<br>**`range    :`** `[ 0 ] ... [ 192 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [0], [NA], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_non_del** (textlines, linelinkage)

Number of words deleted that were coded as neither majority nor minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          184 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          275 `\
<br>**`sum      :`** `       89 609 `\
<br>**`range    :`** `[ 0 ] ... [ 5992 ] `\
<br>**`examples :`** ` [11], [0], [23], [345], [0], [NA], [0], [553], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**pro_maj** (linelinkage)

Number of lines coded as majority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           22 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          161 `\
<br>**`sum      :`** `          697 `\
<br>**`range    :`** `[ 0 ] ... [ 44 ] `\
<br>**`examples :`** ` [0], [0], [NA], [2], [NA], [1], [1], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**pro_min** (linelinkage)

Number of lines coded as minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           21 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          182 `\
<br>**`sum      :`** `          674 `\
<br>**`range    :`** `[ 0 ] ... [ 40 ] `\
<br>**`examples :`** ` [2], [0], [0], [0], [0], [NA], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**pro_non** (linelinkage)

Number of lines coded as neither majority nor minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          121 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          673 `\
<br>**`sum      :`** `       21 154 `\
<br>**`range    :`** `[ 0 ] ... [ 1049 ] `\
<br>**`examples :`** ` [78], [17], [0], [29], [1], [20], [1], [1], [1], [1] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_maj** (textlines, linelinkage)

Number of words coded as majority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          123 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          161 `\
<br>**`sum      :`** `       25 866 `\
<br>**`range    :`** `[ 0 ] ... [ 2583 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [222], [NA], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_min** (textlines, linelinkage)

Number of words coded as minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          117 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          182 `\
<br>**`sum      :`** `       26 009 `\
<br>**`range    :`** `[ 0 ] ... [ 1810 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [0], [104], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_pro_non** (textlines, linelinkage)

Number of words coded as neither majority nor minority friendly.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          441 `\
<br>**`NAs      :`** `           87 `\
<br>**`not-NA   :`** `          699 `\
<br>**`not-0-NA :`** `          671 `\
<br>**`sum      :`** `      546 016 `\
<br>**`range    :`** `[ 0 ] ... [ 28188 ] `\
<br>**`examples :`** ` [NA], [426], [0], [1113], [435], [355], [74], [1104], [1458], [303] ... `\
<br>

<p>&nbsp;</p>
## 07 raw corpus codes - 1 law making



**lns_corp_111** (textlines)

Number of lines with corpus code 111  

 1 Law-Making 

 11 Bills and motions 

 111 types of bills and motions; printing and distribution of bills and motions to MPs

**`class    :`** `      numeric `\
<br>**`unique   :`** `           24 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          587 `\
<br>**`sum      :`** `        3 295 `\
<br>**`range    :`** `[ 0 ] ... [ 33 ] `\
<br>**`examples :`** ` [2], [6], [2], [0], [3], [5], [0], [3], [2], [6] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_112** (textlines)

Number of lines with corpus code 112  

 1 Law-Making 

 11 Bills and motions 

 112 right to initiate bills and motions 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           17 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          690 `\
<br>**`sum      :`** `        3 503 `\
<br>**`range    :`** `[ 0 ] ... [ 28 ] `\
<br>**`examples :`** ` [1], [1], [3], [3], [2], [6], [11], [2], [3], [7] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_113** (textlines)

Number of lines with corpus code 113  

 1 Law-Making 

 11 Bills and motions 

 113 restrictions and deadlines (if not assignable to more specific category, e.g. code 121; 32; 134)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           26 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          754 `\
<br>**`sum      :`** `        6 415 `\
<br>**`range    :`** `[ 0 ] ... [ 31 ] `\
<br>**`examples :`** ` [24], [25], [11], [19], [10], [3], [8], [1], [25], [6] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_114** (textlines)

Number of lines with corpus code 114  

 1 Law-Making 

 11 Bills and motions 

 114 legislative planning (concerns the whole term- general schedule)

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          236 `\
<br>**`sum      :`** `          564 `\
<br>**`range    :`** `[ 0 ] ... [ 12 ] `\
<br>**`examples :`** ` [0], [1], [6], [0], [0], [1], [0], [0], [1], [1] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_121** (textlines)

Number of lines with corpus code 121  

 1 Law-Making 

 12 Treatment of Bills and motions in the plenary 

 121 debate in the plenary

**`class    :`** `      numeric `\
<br>**`unique   :`** `           34 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          564 `\
<br>**`sum      :`** `        5 098 `\
<br>**`range    :`** `[ 0 ] ... [ 49 ] `\
<br>**`examples :`** ` [0], [4], [6], [11], [0], [1], [20], [7], [0], [13] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_122** (textlines)

Number of lines with corpus code 122  

 1 Law-Making 

 12 Treatment of Bills and motions in the plenary 

 122 right of amendment in the plenary 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           26 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          572 `\
<br>**`sum      :`** `        4 783 `\
<br>**`range    :`** `[ 0 ] ... [ 26 ] `\
<br>**`examples :`** ` [0], [3], [21], [8], [7], [0], [5], [0], [3], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_123** (textlines)

Number of lines with corpus code 123  

 1 Law-Making 

 12 Treatment of Bills and motions in the plenary 

 123 subject of vote, rules of vote (including quorum), voting technology in the plenary

**`class    :`** `      integer `\
<br>**`unique   :`** `           49 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `       18 587 `\
<br>**`range    :`** `[ 2 ] ... [ 67 ] `\
<br>**`examples :`** ` [27], [27], [19], [50], [9], [28], [15], [19], [27], [9] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_124** (textlines)

Number of lines with corpus code 124  

 1 Law-Making 

 12 Treatment of Bills and motions in the plenary 

 124 the plenary as Committee of the Whole House

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          207 `\
<br>**`sum      :`** `        1 338 `\
<br>**`range    :`** `[ 0 ] ... [ 9 ] `\
<br>**`examples :`** ` [0], [0], [0], [8], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_125** (textlines)

Number of lines with corpus code 125  

 1 Law-Making 

 12 Treatment of Bills and motions in the plenary 

 125 referral to committee, withdrawal from committee

**`class    :`** `      numeric `\
<br>**`unique   :`** `           18 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          750 `\
<br>**`sum      :`** `        5 845 `\
<br>**`range    :`** `[ 0 ] ... [ 22 ] `\
<br>**`examples :`** ` [7], [5], [10], [10], [0], [19], [6], [6], [7], [5] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_131** (textlines)

Number of lines with corpus code 131  

 1 Law-Making 

 13 Treatment of bills and motions in committee 

 131 debate in committee (including hearing)  

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          450 `\
<br>**`sum      :`** `        1 535 `\
<br>**`range    :`** `[ 0 ] ... [ 13 ] `\
<br>**`examples :`** ` [2], [3], [11], [0], [1], [1], [0], [9], [1], [5] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_132** (textlines)

Number of lines with corpus code 132  

 1 Law-Making 

 13 Treatment of bills and motions in committee 

 132 amendment rights in committee 

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          452 `\
<br>**`sum      :`** `        1 208 `\
<br>**`range    :`** `[ 0 ] ... [ 10 ] `\
<br>**`examples :`** ` [1], [0], [2], [0], [2], [2], [0], [1], [2], [2] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_133** (textlines)

Number of lines with corpus code 133  

 1 Law-Making 

 13 Treatment of bills and motions in committee 

 133 subject of vote, rules of vote (including quorum), voting technology in committee 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           11 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          566 `\
<br>**`sum      :`** `        1 548 `\
<br>**`range    :`** `[ 0 ] ... [ 11 ] `\
<br>**`examples :`** ` [1], [1], [2], [9], [2], [0], [1], [0], [1], [2] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_134** (textlines)

Number of lines with corpus code 134  

 1 Law-Making 

 13 Treatment of bills and motions in committee 

 134 report to the plenary 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           21 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          782 `\
<br>**`sum      :`** `        5 890 `\
<br>**`range    :`** `[ 0 ] ... [ 22 ] `\
<br>**`examples :`** ` [6], [7], [16], [4], [5], [4], [9], [4], [4], [7] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_141** (textlines)

Number of lines with corpus code 141  

 1 Law-Making 

 14 Post-parliamentary stage 

 141 veto right of government actors and head of state ( any case when government actors can oppose themselves to the decisions of parliament) 

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          107 `\
<br>**`sum      :`** `          363 `\
<br>**`range    :`** `[ 0 ] ... [ 6 ] `\
<br>**`examples :`** ` [0], [4], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_142** (textlines)

Number of lines with corpus code 142  

 1 Law-Making 

 14 Post-parliamentary stage 

 142 referral to second chamber, conciliation committee, and renewed decision after intervention  

**`class    :`** `      numeric `\
<br>**`unique   :`** `           20 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          562 `\
<br>**`sum      :`** `        4 359 `\
<br>**`range    :`** `[ 0 ] ... [ 47 ] `\
<br>**`examples :`** ` [1], [40], [0], [6], [0], [0], [0], [0], [5], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_143** (textlines)

Number of lines with corpus code 143  

 1 Law-Making 

 14 Post-parliamentary stage 

 143 	direct democratic procedures following the legislative stage  

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          136 `\
<br>**`sum      :`** `          697 `\
<br>**`range    :`** `[ 0 ] ... [ 13 ] `\
<br>**`examples :`** ` [0], [1], [0], [0], [0], [0], [1], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_144** (textlines)

Number of lines with corpus code 144  

 1 Law-Making 

 14 Post-parliamentary stage 

 144 promulgation and enactment	 

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          191 `\
<br>**`sum      :`** `          272 `\
<br>**`range    :`** `[ 0 ] ... [ 6 ] `\
<br>**`examples :`** ` [0], [6], [1], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_145** (textlines)

Number of lines with corpus code 145  

 1 Law-Making 

 14 Post-parliamentary stage 

 145 referral to the constitutional court/supreme court 

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           29 `\
<br>**`sum      :`** `          267 `\
<br>**`range    :`** `[ 0 ] ... [ 15 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [2] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_111** (textlines)

Number of words with corpus code 111  - see lns_corp_111  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           68 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          587 `\
<br>**`sum      :`** `       78 108 `\
<br>**`range    :`** `[ 0 ] ... [ 651 ] `\
<br>**`examples :`** ` [0], [0], [256], [105], [32], [256], [70], [0], [0], [15] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_112** (textlines)

Number of words with corpus code 112  - see lns_corp_112  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           79 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          690 `\
<br>**`sum      :`** `      113 699 `\
<br>**`range    :`** `[ 0 ] ... [ 522 ] `\
<br>**`examples :`** ` [0], [195], [120], [169], [172], [134], [53], [172], [134], [217] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_113** (textlines)

Number of words with corpus code 113  - see lns_corp_113  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          100 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          754 `\
<br>**`sum      :`** `      212 072 `\
<br>**`range    :`** `[ 0 ] ... [ 806 ] `\
<br>**`examples :`** ` [806], [170], [368], [81], [0], [29], [757], [214], [169], [143] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_114** (textlines)

Number of words with corpus code 114  - see lns_corp_114  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          236 `\
<br>**`sum      :`** `       20 198 `\
<br>**`range    :`** `[ 0 ] ... [ 635 ] `\
<br>**`examples :`** ` [0], [0], [23], [0], [23], [0], [0], [23], [0], [14] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_121** (textlines)

Number of words with corpus code 121  - see lns_corp_121  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          109 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          564 `\
<br>**`sum      :`** `      180 206 `\
<br>**`range    :`** `[ 0 ] ... [ 1536 ] `\
<br>**`examples :`** ` [56], [640], [131], [73], [498], [0], [0], [616], [552], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_122** (textlines)

Number of words with corpus code 122  - see lns_corp_122  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           91 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          572 `\
<br>**`sum      :`** `      175 271 `\
<br>**`range    :`** `[ 0 ] ... [ 1189 ] `\
<br>**`examples :`** ` [0], [0], [277], [0], [118], [101], [568], [415], [229], [905] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_123** (textlines)

Number of words with corpus code 123  - see lns_corp_123  for more information.

**`class    :`** `      integer `\
<br>**`unique   :`** `          182 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      621 902 `\
<br>**`range    :`** `[ 80 ] ... [ 2366 ] `\
<br>**`examples :`** ` [744], [786], [1641], [883], [620], [503], [1639], [1273], [565], [776] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_124** (textlines)

Number of words with corpus code 124  - see lns_corp_124  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           18 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          207 `\
<br>**`sum      :`** `       84 776 `\
<br>**`range    :`** `[ 0 ] ... [ 498 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [268], [264], [498], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_125** (textlines)

Number of words with corpus code 125  - see lns_corp_125  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          106 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          750 `\
<br>**`sum      :`** `      269 936 `\
<br>**`range    :`** `[ 0 ] ... [ 1073 ] `\
<br>**`examples :`** ` [269], [440], [158], [538], [525], [284], [694], [185], [284], [966] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_131** (textlines)

Number of words with corpus code 131  - see lns_corp_131  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           58 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          450 `\
<br>**`sum      :`** `       57 515 `\
<br>**`range    :`** `[ 0 ] ... [ 636 ] `\
<br>**`examples :`** ` [0], [636], [88], [184], [0], [224], [109], [159], [0], [48] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_132** (textlines)

Number of words with corpus code 132  - see lns_corp_132  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           46 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          452 `\
<br>**`sum      :`** `       52 435 `\
<br>**`range    :`** `[ 0 ] ... [ 435 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [239], [86], [0], [86], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_133** (textlines)

Number of words with corpus code 133  - see lns_corp_133  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           60 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          566 `\
<br>**`sum      :`** `       62 394 `\
<br>**`range    :`** `[ 0 ] ... [ 489 ] `\
<br>**`examples :`** ` [22], [22], [110], [15], [65], [22], [0], [15], [12], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_134** (textlines)

Number of words with corpus code 134  - see lns_corp_134  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          126 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          782 `\
<br>**`sum      :`** `      204 068 `\
<br>**`range    :`** `[ 0 ] ... [ 761 ] `\
<br>**`examples :`** ` [119], [250], [264], [202], [41], [180], [180], [206], [264], [180] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_141** (textlines)

Number of words with corpus code 141  - see lns_corp_141  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          107 `\
<br>**`sum      :`** `       14 531 `\
<br>**`range    :`** `[ 0 ] ... [ 187 ] `\
<br>**`examples :`** ` [0], [0], [90], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_142** (textlines)

Number of words with corpus code 142  - see lns_corp_142  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           59 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          562 `\
<br>**`sum      :`** `      168 428 `\
<br>**`range    :`** `[ 0 ] ... [ 1359 ] `\
<br>**`examples :`** ` [13], [0], [0], [55], [55], [0], [0], [0], [0], [274] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_143** (textlines)

Number of words with corpus code 143  - see lns_corp_143  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           18 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          136 `\
<br>**`sum      :`** `       27 235 `\
<br>**`range    :`** `[ 0 ] ... [ 555 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [42], [546], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_144** (textlines)

Number of words with corpus code 144  - see lns_corp_144  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          191 `\
<br>**`sum      :`** `        6 737 `\
<br>**`range    :`** `[ 0 ] ... [ 136 ] `\
<br>**`examples :`** ` [0], [21], [0], [0], [21], [0], [0], [0], [21], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_145** (textlines)

Number of words with corpus code 145  - see lns_corp_145  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           29 `\
<br>**`sum      :`** `       13 301 `\
<br>**`range    :`** `[ 0 ] ... [ 857 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>
## 07 raw corpus codes - 2 special decision procedures



**lns_corp_21** (textlines)

Number of lines with corpus code 21   

 2 Special Decision Procedures other than Regular Law-Making 

 21 constitutional change and amendment

**`class    :`** `      numeric `\
<br>**`unique   :`** `           22 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          387 `\
<br>**`sum      :`** `        3 414 `\
<br>**`range    :`** `[ 0 ] ... [ 35 ] `\
<br>**`examples :`** ` [7], [0], [10], [5], [2], [0], [1], [28], [1], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_22** (textlines)

Number of lines with corpus code 22   

 2 Special Decision Procedures other than Regular Law-Making 

 22 financial laws (money bills) and budgeting 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           48 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          629 `\
<br>**`sum      :`** `       15 358 `\
<br>**`range    :`** `[ 0 ] ... [ 65 ] `\
<br>**`examples :`** ` [45], [13], [13], [15], [5], [10], [41], [0], [16], [13] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_23** (textlines)

Number of lines with corpus code 23   

 2 Special Decision Procedures other than Regular Law-Making 

 23 foreign policy

**`class    :`** `      numeric `\
<br>**`unique   :`** `           16 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          213 `\
<br>**`sum      :`** `        1 765 `\
<br>**`range    :`** `[ 0 ] ... [ 29 ] `\
<br>**`examples :`** ` [0], [3], [0], [0], [0], [0], [2], [9], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_25** (textlines)

Number of lines with corpus code 25   

 2 Special Decision Procedures other than Regular Law-Making 

 25 general rules on elections in parliament (if not coded as election of government (31), or election of specific officials (411; 421; 441; 6211; 6221; 632))

**`class    :`** `      numeric `\
<br>**`unique   :`** `           34 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          515 `\
<br>**`sum      :`** `        8 653 `\
<br>**`range    :`** `[ 0 ] ... [ 80 ] `\
<br>**`examples :`** ` [40], [10], [13], [10], [8], [41], [3], [3], [3], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_26** (textlines)

Number of lines with corpus code 26   

 2 Special Decision Procedures other than Regular Law-Making 

 26 further special decision procedures (leading to a decision, e.g. resolution, or leading to a decree/act/bylaw (not mere debate or question time) but cannot be coded as regular law-making nor special decision procedures (21 - 24) )

**`class    :`** `      numeric `\
<br>**`unique   :`** `           32 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          465 `\
<br>**`sum      :`** `        5 053 `\
<br>**`range    :`** `[ 0 ] ... [ 44 ] `\
<br>**`examples :`** ` [1], [3], [7], [3], [41], [8], [1], [0], [16], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_27** (textlines)

Number of lines with corpus code 27   

 2 Special Decision Procedures other than Regular Law-Making 

 27 procedures concerning laws that are hierarchically situated between regular laws and constitutional laws (above regular laws; e.g. organic laws in Spain)

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          105 `\
<br>**`sum      :`** `          609 `\
<br>**`range    :`** `[ 0 ] ... [ 9 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [5], [5] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_28** (textlines)

Number of lines with corpus code 28   

 2 Special Decision Procedures other than Regular Law-Making 

 28 emergency legislation

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           23 `\
<br>**`sum      :`** `          457 `\
<br>**`range    :`** `[ 0 ] ... [ 32 ] `\
<br>**`examples :`** ` [0], [0], [12], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_29** (textlines)

Number of lines with corpus code 29   

 2 Special Decision Procedures other than Regular Law-Making 

 29 relationship to sub-national level (law-making, rights of participation of sub-national level)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           36 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          259 `\
<br>**`sum      :`** `       18 465 `\
<br>**`range    :`** `[ 0 ] ... [ 245 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [1], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_241** (textlines)

Number of lines with corpus code 241  

 2 Special Decision Procedures other than Regular Law-Making 

 24 EU 

 241 treatment of EU-bills and motions

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          291 `\
<br>**`sum      :`** `        1 446 `\
<br>**`range    :`** `[ 0 ] ... [ 24 ] `\
<br>**`examples :`** ` [1], [0], [0], [0], [2], [0], [18], [0], [1], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_242** (textlines)

Number of lines with corpus code 242  

 2 Special Decision Procedures other than Regular Law-Making 

 24 EU 

 242 EU-committee: election and resignation 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          264 `\
<br>**`sum      :`** `        4 369 `\
<br>**`range    :`** `[ 0 ] ... [ 48 ] `\
<br>**`examples :`** ` [0], [0], [0], [1], [0], [0], [0], [0], [0], [3] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_243** (textlines)

Number of lines with corpus code 243  

 2 Special Decision Procedures other than Regular Law-Making 

 24 EU 

 243 instructions to the government concerning EU decisions

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           67 `\
<br>**`sum      :`** `          102 `\
<br>**`range    :`** `[ 0 ] ... [ 4 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_244** (textlines)

Number of lines with corpus code 244  

 2 Special Decision Procedures other than Regular Law-Making 

 24 EU 

 244 further rights of participation in EU matters (e.g. debates about EU topics not based on EU bills and motions, reaction to violations of subsidiary principle) 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          140 `\
<br>**`sum      :`** `          661 `\
<br>**`range    :`** `[ 0 ] ... [ 29 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_21** (textlines)

Number of words with corpus code 21   - see lns_corp_21   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           54 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          387 `\
<br>**`sum      :`** `      100 101 `\
<br>**`range    :`** `[ 0 ] ... [ 885 ] `\
<br>**`examples :`** ` [31], [131], [0], [51], [279], [0], [258], [744], [279], [279] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_22** (textlines)

Number of words with corpus code 22   - see lns_corp_22   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          155 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          629 `\
<br>**`sum      :`** `      640 813 `\
<br>**`range    :`** `[ 0 ] ... [ 2938 ] `\
<br>**`examples :`** ` [992], [1499], [151], [1494], [281], [1542], [414], [151], [2160], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_23** (textlines)

Number of words with corpus code 23   - see lns_corp_23   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           40 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          213 `\
<br>**`sum      :`** `       74 661 `\
<br>**`range    :`** `[ 0 ] ... [ 777 ] `\
<br>**`examples :`** ` [0], [0], [0], [671], [0], [0], [209], [635], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_25** (textlines)

Number of words with corpus code 25   - see lns_corp_25   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           94 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          515 `\
<br>**`sum      :`** `      290 048 `\
<br>**`range    :`** `[ 0 ] ... [ 1942 ] `\
<br>**`examples :`** ` [219], [0], [1465], [71], [235], [0], [458], [0], [193], [80] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_26** (textlines)

Number of words with corpus code 26   - see lns_corp_26   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           86 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          465 `\
<br>**`sum      :`** `      199 867 `\
<br>**`range    :`** `[ 0 ] ... [ 2217 ] `\
<br>**`examples :`** ` [0], [410], [0], [232], [0], [376], [2216], [0], [0], [98] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_27** (textlines)

Number of words with corpus code 27   - see lns_corp_27   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           15 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          105 `\
<br>**`sum      :`** `       25 278 `\
<br>**`range    :`** `[ 0 ] ... [ 475 ] `\
<br>**`examples :`** ` [0], [0], [0], [190], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_28** (textlines)

Number of words with corpus code 28   - see lns_corp_28   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           23 `\
<br>**`sum      :`** `       12 021 `\
<br>**`range    :`** `[ 0 ] ... [ 775 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_29** (textlines)

Number of words with corpus code 29   - see lns_corp_29   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           70 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          259 `\
<br>**`sum      :`** `      681 590 `\
<br>**`range    :`** `[ 0 ] ... [ 8107 ] `\
<br>**`examples :`** ` [1257], [1576], [0], [0], [0], [0], [0], [0], [958], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_241** (textlines)

Number of words with corpus code 241  - see lns_corp_241  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           42 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          291 `\
<br>**`sum      :`** `       56 096 `\
<br>**`range    :`** `[ 0 ] ... [ 1348 ] `\
<br>**`examples :`** ` [123], [0], [0], [70], [78], [0], [0], [70], [64], [162] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_242** (textlines)

Number of words with corpus code 242  - see lns_corp_242  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           50 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          264 `\
<br>**`sum      :`** `      123 510 `\
<br>**`range    :`** `[ 0 ] ... [ 1310 ] `\
<br>**`examples :`** ` [904], [0], [0], [0], [1233], [1233], [34], [0], [47], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_243** (textlines)

Number of words with corpus code 243  - see lns_corp_243  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           67 `\
<br>**`sum      :`** `        3 733 `\
<br>**`range    :`** `[ 0 ] ... [ 84 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_244** (textlines)

Number of words with corpus code 244  - see lns_corp_244  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           28 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          140 `\
<br>**`sum      :`** `       24 725 `\
<br>**`range    :`** `[ 0 ] ... [ 927 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [42], [0], [42], [0], [0] ... `\
<br>

<p>&nbsp;</p>
## 07 raw corpus codes - 3 relationship to government 



**lns_corp_31** (textlines)

Number of lines with corpus code 31   

 3 Relationship to Government 

 31 election of government / mandatory investiture vote; entry into office

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          197 `\
<br>**`sum      :`** `          690 `\
<br>**`range    :`** `[ 0 ] ... [ 18 ] `\
<br>**`examples :`** ` [0], [0], [1], [1], [1], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_32** (textlines)

Number of lines with corpus code 32   

 3 Relationship to Government 

 32 vote of no confidence / government resignation

**`class    :`** `      numeric `\
<br>**`unique   :`** `           15 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          311 `\
<br>**`sum      :`** `        2 141 `\
<br>**`range    :`** `[ 0 ] ... [ 27 ] `\
<br>**`examples :`** ` [0], [27], [2], [0], [0], [27], [0], [0], [0], [2] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_33** (textlines)

Number of lines with corpus code 33   

 3 Relationship to Government 

 33 vote of confidence

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          153 `\
<br>**`sum      :`** `          789 `\
<br>**`range    :`** `[ 0 ] ... [ 9 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [9], [5], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_34** (textlines)

Number of lines with corpus code 34   

 3 Relationship to Government 

 34 instructions to government, involvement of members of government in parliamentary activities (rights to compel witnesses [usually right of parliament against members of government], right to speak [usually members of government's right], request of information about state of execution of decisions of parliament)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           27 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          713 `\
<br>**`sum      :`** `        4 395 `\
<br>**`range    :`** `[ 0 ] ... [ 37 ] `\
<br>**`examples :`** ` [2], [7], [0], [3], [7], [1], [8], [4], [6], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_31** (textlines)

Number of words with corpus code 31   - see lns_corp_31   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           17 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          197 `\
<br>**`sum      :`** `       17 859 `\
<br>**`range    :`** `[ 0 ] ... [ 426 ] `\
<br>**`examples :`** ` [0], [0], [0], [27], [0], [0], [27], [0], [331], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_32** (textlines)

Number of words with corpus code 32   - see lns_corp_32   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           33 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          311 `\
<br>**`sum      :`** `       70 940 `\
<br>**`range    :`** `[ 0 ] ... [ 861 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [121], [0], [120] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_33** (textlines)

Number of words with corpus code 33   - see lns_corp_33   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           19 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          153 `\
<br>**`sum      :`** `       26 002 `\
<br>**`range    :`** `[ 0 ] ... [ 268 ] `\
<br>**`examples :`** ` [214], [0], [0], [0], [62], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_34** (textlines)

Number of words with corpus code 34   - see lns_corp_34   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          102 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          713 `\
<br>**`sum      :`** `      135 027 `\
<br>**`range    :`** `[ 0 ] ... [ 860 ] `\
<br>**`examples :`** ` [0], [650], [0], [217], [705], [348], [92], [217], [64], [24] ... `\
<br>

<p>&nbsp;</p>
## 07 raw corpus codes - 4 relationship to others



**lns_corp_43** (textlines)

Number of lines with corpus code 43   

 4 Relationship to External Offices/Institutions apart from the Government 

 43 second chamber (if not coded as law-making (142))

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          243 `\
<br>**`sum      :`** `        1 002 `\
<br>**`range    :`** `[ 0 ] ... [ 16 ] `\
<br>**`examples :`** ` [0], [2], [0], [0], [0], [0], [0], [0], [0], [3] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_45** (textlines)

Number of lines with corpus code 45   

 4 Relationship to External Offices/Institutions apart from the Government 

 45 constitutional courts

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           68 `\
<br>**`sum      :`** `          655 `\
<br>**`range    :`** `[ 0 ] ... [ 34 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_411** (textlines)

Number of lines with corpus code 411  

 4 Relationship to External Offices/Institutions apart from the Government 

 41 parliamentary support bodies (e.g. general accounting office, ombudsman, ...) 

 411 election and resignation

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          177 `\
<br>**`sum      :`** `        1 392 `\
<br>**`range    :`** `[ 0 ] ... [ 46 ] `\
<br>**`examples :`** ` [0], [0], [6], [0], [0], [0], [11], [14], [46], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_412** (textlines)

Number of lines with corpus code 412  

 4 Relationship to External Offices/Institutions apart from the Government 

 41 parliamentary support bodies (e.g. general accounting office, ombudsman, ...) 

 412 competences and resources of external offices/institutions; relations to parliament (e.g. reports, questions, ...)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          352 `\
<br>**`sum      :`** `        1 921 `\
<br>**`range    :`** `[ 0 ] ... [ 22 ] `\
<br>**`examples :`** ` [7], [0], [6], [0], [0], [13], [5], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_421** (textlines)

Number of lines with corpus code 421  

 4 Relationship to External Offices/Institutions apart from the Government 

 42 head of state 

 421 election and resignation

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          129 `\
<br>**`sum      :`** `          292 `\
<br>**`range    :`** `[ 0 ] ... [ 15 ] `\
<br>**`examples :`** ` [0], [1], [0], [0], [0], [0], [0], [1], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_422** (textlines)

Number of lines with corpus code 422  

 4 Relationship to External Offices/Institutions apart from the Government 

 42 head of state 

 422 relation to parliament (if not coded as law-making (141, 144))

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           41 `\
<br>**`sum      :`** `          132 `\
<br>**`range    :`** `[ 0 ] ... [ 6 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_441** (textlines)

Number of lines with corpus code 441  

 4 Relationship to External Offices/Institutions apart from the Government 

 44 constitutional courts 

 441 election and resignation

**`class    :`** `      numeric `\
<br>**`unique   :`** `            3 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           26 `\
<br>**`sum      :`** `           66 `\
<br>**`range    :`** `[ 0 ] ... [ 4 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_442** (textlines)

Number of lines with corpus code 442  

 4 Relationship to External Offices/Institutions apart from the Government 

 44 constitutional courts 

 442 relation to parliament (if not coded as law-making (145))

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           71 `\
<br>**`sum      :`** `          198 `\
<br>**`range    :`** `[ 0 ] ... [ 5 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [5], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_43** (textlines)

Number of words with corpus code 43   - see lns_corp_43   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           25 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          243 `\
<br>**`sum      :`** `       28 427 `\
<br>**`range    :`** `[ 0 ] ... [ 335 ] `\
<br>**`examples :`** ` [0], [164], [34], [101], [0], [0], [0], [17], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_45** (textlines)

Number of words with corpus code 45   - see lns_corp_45   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           68 `\
<br>**`sum      :`** `       22 655 `\
<br>**`range    :`** `[ 0 ] ... [ 1001 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_411** (textlines)

Number of words with corpus code 411  - see lns_corp_411  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           27 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          177 `\
<br>**`sum      :`** `       40 622 `\
<br>**`range    :`** `[ 0 ] ... [ 1435 ] `\
<br>**`examples :`** ` [0], [0], [0], [390], [0], [0], [158], [0], [177], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_412** (textlines)

Number of words with corpus code 412  - see lns_corp_412  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           42 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          352 `\
<br>**`sum      :`** `       57 401 `\
<br>**`range    :`** `[ 0 ] ... [ 629 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [207], [242], [0], [171], [0], [238] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_421** (textlines)

Number of words with corpus code 421  - see lns_corp_421  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          129 `\
<br>**`sum      :`** `       11 032 `\
<br>**`range    :`** `[ 0 ] ... [ 391 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [233], [33], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_422** (textlines)

Number of words with corpus code 422  - see lns_corp_422  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           41 `\
<br>**`sum      :`** `        3 193 `\
<br>**`range    :`** `[ 0 ] ... [ 170 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_441** (textlines)

Number of words with corpus code 441  - see lns_corp_441  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           26 `\
<br>**`sum      :`** `        1 695 `\
<br>**`range    :`** `[ 0 ] ... [ 99 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_442** (textlines)

Number of words with corpus code 442  - see lns_corp_442  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           71 `\
<br>**`sum      :`** `        6 028 `\
<br>**`range    :`** `[ 0 ] ... [ 142 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [52], [0] ... `\
<br>

<p>&nbsp;</p>
## 07 raw corpus codes - 5 publicity



**lns_corp_51** (textlines)

Number of lines with corpus code 51   

 5 Generating Publicity 

 51 general rules regarding debate (e.g. time allotted for speaking, proportional representation of parties during debate, closure of debate) 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           64 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          723 `\
<br>**`sum      :`** `       15 446 `\
<br>**`range    :`** `[ 0 ] ... [ 111 ] `\
<br>**`examples :`** ` [99], [17], [9], [14], [1], [0], [14], [9], [14], [9] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_52** (textlines)

Number of lines with corpus code 52   

 5 Generating Publicity 

 52 debates outside of law-making (e.g. topical hours ...)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           19 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          318 `\
<br>**`sum      :`** `        1 873 `\
<br>**`range    :`** `[ 0 ] ... [ 32 ] `\
<br>**`examples :`** ` [3], [2], [0], [2], [0], [0], [0], [0], [0], [2] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_53** (textlines)

Number of lines with corpus code 53   

 5 Generating Publicity 

 53 question rights

**`class    :`** `      numeric `\
<br>**`unique   :`** `           55 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          769 `\
<br>**`sum      :`** `       17 319 `\
<br>**`range    :`** `[ 0 ] ... [ 89 ] `\
<br>**`examples :`** ` [7], [22], [26], [24], [40], [21], [70], [18], [80], [24] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_54** (textlines)

Number of lines with corpus code 54   

 5 Generating Publicity 

 54 petitions and petition committee

**`class    :`** `      numeric `\
<br>**`unique   :`** `           25 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          503 `\
<br>**`sum      :`** `        5 073 `\
<br>**`range    :`** `[ 0 ] ... [ 49 ] `\
<br>**`examples :`** ` [5], [0], [11], [19], [0], [10], [12], [0], [13], [9] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_55** (textlines)

Number of lines with corpus code 55   

 5 Generating Publicity 

 55 relationship to media and citizens (e.g. parliamentary TV, accreditation of journalists, publicity of meetings, admissibility of visitors); regulation of matters of confidentiality 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           31 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          753 `\
<br>**`sum      :`** `        8 446 `\
<br>**`range    :`** `[ 0 ] ... [ 67 ] `\
<br>**`examples :`** ` [4], [8], [5], [19], [7], [3], [65], [8], [6], [4] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_56** (textlines)

Number of lines with corpus code 56   

 5 Generating Publicity 

 56 protocols and parliamentary documents; forwarding of documents and decisions to other bodies 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           36 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          776 `\
<br>**`sum      :`** `       10 109 `\
<br>**`range    :`** `[ 0 ] ... [ 61 ] `\
<br>**`examples :`** ` [13], [8], [5], [11], [5], [27], [9], [16], [22], [10] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_51** (textlines)

Number of words with corpus code 51   - see lns_corp_51   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          171 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          723 `\
<br>**`sum      :`** `      486 967 `\
<br>**`range    :`** `[ 0 ] ... [ 1649 ] `\
<br>**`examples :`** ` [500], [839], [1299], [518], [659], [701], [398], [504], [891], [769] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_52** (textlines)

Number of words with corpus code 52   - see lns_corp_52   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           43 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          318 `\
<br>**`sum      :`** `       77 501 `\
<br>**`range    :`** `[ 0 ] ... [ 1025 ] `\
<br>**`examples :`** ` [295], [0], [295], [0], [0], [321], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_53** (textlines)

Number of words with corpus code 53   - see lns_corp_53   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          189 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          769 `\
<br>**`sum      :`** `      620 154 `\
<br>**`range    :`** `[ 0 ] ... [ 2691 ] `\
<br>**`examples :`** ` [496], [821], [663], [856], [473], [924], [622], [797], [579], [873] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_54** (textlines)

Number of words with corpus code 54   - see lns_corp_54   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           74 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          503 `\
<br>**`sum      :`** `      179 259 `\
<br>**`range    :`** `[ 0 ] ... [ 1106 ] `\
<br>**`examples :`** ` [457], [0], [0], [0], [0], [0], [630], [0], [349], [473] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_55** (textlines)

Number of words with corpus code 55   - see lns_corp_55   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          128 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          753 `\
<br>**`sum      :`** `      273 739 `\
<br>**`range    :`** `[ 0 ] ... [ 1851 ] `\
<br>**`examples :`** ` [171], [846], [309], [78], [697], [246], [1851], [57], [210], [846] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_56** (textlines)

Number of words with corpus code 56   - see lns_corp_56   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          147 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          776 `\
<br>**`sum      :`** `      336 558 `\
<br>**`range    :`** `[ 0 ] ... [ 1340 ] `\
<br>**`examples :`** ` [278], [276], [207], [259], [534], [278], [465], [0], [712], [628] ... `\
<br>

<p>&nbsp;</p>
## 07 raw corpus codes - 6 committees



**lns_corp_66** (textlines)

Number of lines with corpus code 66   

 6 Internal Organization of Parliament 

 66 opposition

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           89 `\
<br>**`sum      :`** `           89 `\
<br>**`range    :`** `[ 0 ] ... [ 1 ] `\
<br>**`examples :`** ` [0], [1], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_67** (textlines)

Number of lines with corpus code 67   

 6 Internal Organization of Parliament 

 67 special bodies for emergency situations

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          108 `\
<br>**`sum      :`** `          639 `\
<br>**`range    :`** `[ 0 ] ... [ 7 ] `\
<br>**`examples :`** ` [0], [6], [0], [0], [1], [0], [0], [0], [0], [6] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_68** (textlines)

Number of lines with corpus code 68   

 6 Internal Organization of Parliament 

 68 parliamentary administration

**`class    :`** `      numeric `\
<br>**`unique   :`** `           26 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          600 `\
<br>**`sum      :`** `        6 090 `\
<br>**`range    :`** `[ 0 ] ... [ 47 ] `\
<br>**`examples :`** ` [7], [1], [2], [5], [3], [38], [4], [21], [5], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_611** (textlines)

Number of lines with corpus code 611  

 6 Internal Organization of Parliament 

 61 plenary 

 611 agenda setting and removal of items from the agenda (general rules which are not specifically regulated under 114)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           73 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          722 `\
<br>**`sum      :`** `       22 831 `\
<br>**`range    :`** `[ 0 ] ... [ 200 ] `\
<br>**`examples :`** ` [77], [5], [0], [97], [18], [51], [0], [79], [6], [3] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_612** (textlines)

Number of lines with corpus code 612  

 6 Internal Organization of Parliament 

 61 plenary 

 612 chairing of meetings and measures to uphold order

**`class    :`** `      numeric `\
<br>**`unique   :`** `           32 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          748 `\
<br>**`sum      :`** `       10 960 `\
<br>**`range    :`** `[ 0 ] ... [ 60 ] `\
<br>**`examples :`** ` [2], [41], [12], [10], [4], [16], [16], [24], [4], [6] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_613** (textlines)

Number of lines with corpus code 613  

 6 Internal Organization of Parliament 

 61 plenary 

 613 sitting times

**`class    :`** `      numeric `\
<br>**`unique   :`** `           21 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          731 `\
<br>**`sum      :`** `        5 285 `\
<br>**`range    :`** `[ 0 ] ... [ 32 ] `\
<br>**`examples :`** ` [21], [6], [5], [2], [11], [2], [5], [4], [2], [2] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_631** (textlines)

Number of lines with corpus code 631  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 631 general regulations regarding types of committees

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          459 `\
<br>**`sum      :`** `        1 706 `\
<br>**`range    :`** `[ 0 ] ... [ 13 ] `\
<br>**`examples :`** ` [0], [0], [4], [2], [0], [0], [0], [3], [2], [1] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_632** (textlines)

Number of lines with corpus code 632  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 632 membership and committee jurisdiction (area of influence-control .g. finance, economy, agriculture...)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           56 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          773 `\
<br>**`sum      :`** `       21 232 `\
<br>**`range    :`** `[ 0 ] ... [ 164 ] `\
<br>**`examples :`** ` [7], [6], [7], [31], [164], [164], [41], [38], [8], [25] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_633** (textlines)

Number of lines with corpus code 633  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 633 formal organizational units of committee (e.g. chair of committee, sub-committees, staff)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           17 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          771 `\
<br>**`sum      :`** `        3 276 `\
<br>**`range    :`** `[ 0 ] ... [ 24 ] `\
<br>**`examples :`** ` [2], [1], [2], [2], [5], [6], [1], [1], [2], [5] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_634** (textlines)

Number of lines with corpus code 634  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 634 agenda and procedures (details on how decisions are taken) within committees (if not coded as law-making (13))

**`class    :`** `      numeric `\
<br>**`unique   :`** `           30 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          751 `\
<br>**`sum      :`** `        9 442 `\
<br>**`range    :`** `[ 0 ] ... [ 39 ] `\
<br>**`examples :`** ` [6], [6], [7], [35], [18], [7], [7], [7], [12], [20] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_636** (textlines)

Number of lines with corpus code 636  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 636 investigative competencies of regular committees (NOT committees of inquiry (637))

**`class    :`** `      numeric `\
<br>**`unique   :`** `           18 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          612 `\
<br>**`sum      :`** `        3 343 `\
<br>**`range    :`** `[ 0 ] ... [ 21 ] `\
<br>**`examples :`** ` [0], [6], [12], [8], [0], [6], [5], [2], [6], [5] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_637** (textlines)

Number of lines with corpus code 637  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 637 committee of inquiry 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           25 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          275 `\
<br>**`sum      :`** `        4 258 `\
<br>**`range    :`** `[ 0 ] ... [ 78 ] `\
<br>**`examples :`** ` [5], [15], [0], [0], [13], [5], [5], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_638** (textlines)

Number of lines with corpus code 638  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 638 enquete commission

**`class    :`** `      numeric `\
<br>**`unique   :`** `           11 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          135 `\
<br>**`sum      :`** `          782 `\
<br>**`range    :`** `[ 0 ] ... [ 20 ] `\
<br>**`examples :`** ` [0], [5], [0], [0], [0], [0], [0], [1], [4], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_639** (textlines)

Number of lines with corpus code 639  

 6 Internal Organization of Parliament 

 63 committees (if not coded as more specific category (e.g. 13; 24; 54; 55; 72)) 

 639 other special committees which are not explicitly referenced in this coding manual  (e.g. oversight committees in Switzerland)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           79 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          691 `\
<br>**`sum      :`** `       22 088 `\
<br>**`range    :`** `[ 0 ] ... [ 211 ] `\
<br>**`examples :`** ` [0], [10], [0], [10], [126], [11], [68], [5], [11], [5] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_641** (textlines)

Number of lines with corpus code 641  

 6 Internal Organization of Parliament 

 64 parliamentary party groups 

 641 formation of parliamentary party groups

**`class    :`** `      numeric `\
<br>**`unique   :`** `           11 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          419 `\
<br>**`sum      :`** `        1 964 `\
<br>**`range    :`** `[ 0 ] ... [ 12 ] `\
<br>**`examples :`** ` [7], [5], [0], [5], [0], [0], [0], [0], [0], [5] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_642** (textlines)

Number of lines with corpus code 642  

 6 Internal Organization of Parliament 

 64 parliamentary party groups 

 642 rights and obligations of parliamentary party groups (if not coded more specifically as e.g. 112; 51; 52; 53)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          239 `\
<br>**`sum      :`** `          893 `\
<br>**`range    :`** `[ 0 ] ... [ 55 ] `\
<br>**`examples :`** ` [0], [2], [0], [0], [0], [0], [0], [0], [5], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_643** (textlines)

Number of lines with corpus code 643  

 6 Internal Organization of Parliament 

 64 parliamentary party groups 

 643 financial and staff resources

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          207 `\
<br>**`sum      :`** `          513 `\
<br>**`range    :`** `[ 0 ] ... [ 6 ] `\
<br>**`examples :`** ` [0], [6], [0], [2], [1], [6], [1], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_651** (textlines)

Number of lines with corpus code 651  

 6 Internal Organization of Parliament 

 65 individual members of parlaiment 

 651 election, entry into office, resignation, incompatibilities, legal status, immunity, indemnity

**`class    :`** `      numeric `\
<br>**`unique   :`** `           34 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          750 `\
<br>**`sum      :`** `        8 186 `\
<br>**`range    :`** `[ 0 ] ... [ 56 ] `\
<br>**`examples :`** ` [5], [8], [5], [15], [6], [2], [19], [5], [6], [5] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_652** (textlines)

Number of lines with corpus code 652  

 6 Internal Organization of Parliament 

 65 individual members of parlaiment 

 652 rights and obligations of individual members of parliament (if not coded more specifically as e.g. 112; 51; 52; 53)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           29 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          740 `\
<br>**`sum      :`** `        5 837 `\
<br>**`range    :`** `[ 0 ] ... [ 67 ] `\
<br>**`examples :`** ` [5], [3], [6], [2], [9], [5], [7], [3], [3], [1] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_653** (textlines)

Number of lines with corpus code 653  

 6 Internal Organization of Parliament 

 65 individual members of parlaiment 

 653 salary, financial and staff resources

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          209 `\
<br>**`sum      :`** `          414 `\
<br>**`range    :`** `[ 0 ] ... [ 7 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [3], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_6211** (textlines)

Number of lines with corpus code 6211 

 6 Internal Organization of Parliament 

 62 parliamentary presiding bodies 

 621 president of parliament, vice presidents, secretaries and clerks 

 6211 election, resignation and internal decision rules

**`class    :`** `      numeric `\
<br>**`unique   :`** `           26 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          748 `\
<br>**`sum      :`** `        7 375 `\
<br>**`range    :`** `[ 0 ] ... [ 36 ] `\
<br>**`examples :`** ` [4], [7], [16], [4], [8], [7], [4], [4], [22], [6] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_6212** (textlines)

Number of lines with corpus code 6212 

 6 Internal Organization of Parliament 

 62 parliamentary presiding bodies 

 621 president of parliament, vice presidents, secretaries and clerks 

 6212 responsibilities (if not coded as more specific category  (e.g. 612))

**`class    :`** `      numeric `\
<br>**`unique   :`** `           24 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          730 `\
<br>**`sum      :`** `        5 448 `\
<br>**`range    :`** `[ 0 ] ... [ 72 ] `\
<br>**`examples :`** ` [7], [1], [2], [14], [4], [5], [8], [3], [12], [4] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_6221** (textlines)

Number of lines with corpus code 6221 

 6 Internal Organization of Parliament 

 62 parliamentary presiding bodies 

 622 council of elders or similar coordination body 

 6221 composition, election, resignation, internal decision rules

**`class    :`** `      numeric `\
<br>**`unique   :`** `           12 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          548 `\
<br>**`sum      :`** `        1 928 `\
<br>**`range    :`** `[ 0 ] ... [ 13 ] `\
<br>**`examples :`** ` [0], [1], [2], [3], [12], [1], [0], [3], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_6222** (textlines)

Number of lines with corpus code 6222 

 6 Internal Organization of Parliament 

 62 parliamentary presiding bodies 

 622 council of elders or similar coordination body 

 6222 responsibilities (if not coded as more specific category (e.g. 612))

**`class    :`** `      numeric `\
<br>**`unique   :`** `           16 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          479 `\
<br>**`sum      :`** `        2 529 `\
<br>**`range    :`** `[ 0 ] ... [ 16 ] `\
<br>**`examples :`** ` [0], [0], [3], [0], [4], [2], [15], [0], [6], [4] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_6351** (textlines)

Number of lines with corpus code 6351 

 6 Internal Organization of Parliament 

 63 committees 

 relations to other bodies 

 6351 relation to plenary (if not coded as 124; 134; 34)

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          144 `\
<br>**`sum      :`** `          214 `\
<br>**`range    :`** `[ 0 ] ... [ 6 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [1], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_6352** (textlines)

Number of lines with corpus code 6352 

 6 Internal Organization of Parliament 

 63 committees 

 relations to other bodies 

 6352 relation to other committees

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          459 `\
<br>**`sum      :`** `        1 225 `\
<br>**`range    :`** `[ 0 ] ... [ 7 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [2], [2], [3], [0], [6], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_66** (textlines)

Number of words with corpus code 66   - see lns_corp_66   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `           89 `\
<br>**`sum      :`** `        3 649 `\
<br>**`range    :`** `[ 0 ] ... [ 41 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [41], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_67** (textlines)

Number of words with corpus code 67   - see lns_corp_67   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          108 `\
<br>**`sum      :`** `       13 213 `\
<br>**`range    :`** `[ 0 ] ... [ 137 ] `\
<br>**`examples :`** ` [0], [0], [119], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_68** (textlines)

Number of words with corpus code 68   - see lns_corp_68   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           77 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          600 `\
<br>**`sum      :`** `      148 597 `\
<br>**`range    :`** `[ 0 ] ... [ 1093 ] `\
<br>**`examples :`** ` [72], [1032], [904], [149], [338], [33], [906], [126], [313], [242] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_611** (textlines)

Number of words with corpus code 611  - see lns_corp_611  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          157 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          722 `\
<br>**`sum      :`** `      899 117 `\
<br>**`range    :`** `[ 0 ] ... [ 6791 ] `\
<br>**`examples :`** ` [4122], [109], [414], [375], [359], [3598], [0], [1369], [3490], [755] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_612** (textlines)

Number of words with corpus code 612  - see lns_corp_612  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           94 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          748 `\
<br>**`sum      :`** `      409 479 `\
<br>**`range    :`** `[ 0 ] ... [ 2221 ] `\
<br>**`examples :`** ` [0], [107], [123], [143], [533], [777], [88], [247], [574], [88] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_613** (textlines)

Number of words with corpus code 613  - see lns_corp_613  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           96 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          731 `\
<br>**`sum      :`** `      177 924 `\
<br>**`range    :`** `[ 0 ] ... [ 842 ] `\
<br>**`examples :`** ` [26], [0], [196], [347], [96], [307], [202], [84], [56], [214] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_631** (textlines)

Number of words with corpus code 631  - see lns_corp_631  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           56 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          459 `\
<br>**`sum      :`** `       56 342 `\
<br>**`range    :`** `[ 0 ] ... [ 518 ] `\
<br>**`examples :`** ` [23], [16], [81], [14], [17], [17], [81], [17], [0], [340] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_632** (textlines)

Number of words with corpus code 632  - see lns_corp_632  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          243 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          773 `\
<br>**`sum      :`** `      443 925 `\
<br>**`range    :`** `[ 0 ] ... [ 1313 ] `\
<br>**`examples :`** ` [292], [262], [44], [746], [385], [800], [85], [1140], [1169], [210] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_633** (textlines)

Number of words with corpus code 633  - see lns_corp_633  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           94 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          771 `\
<br>**`sum      :`** `      105 561 `\
<br>**`range    :`** `[ 0 ] ... [ 790 ] `\
<br>**`examples :`** ` [55], [56], [56], [244], [13], [26], [232], [68], [161], [80] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_634** (textlines)

Number of words with corpus code 634  - see lns_corp_634  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          129 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          751 `\
<br>**`sum      :`** `      305 110 `\
<br>**`range    :`** `[ 0 ] ... [ 1288 ] `\
<br>**`examples :`** ` [628], [271], [1133], [267], [122], [303], [326], [217], [286], [134] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_636** (textlines)

Number of words with corpus code 636  - see lns_corp_636  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           84 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          612 `\
<br>**`sum      :`** `      120 418 `\
<br>**`range    :`** `[ 0 ] ... [ 878 ] `\
<br>**`examples :`** ` [580], [389], [124], [0], [173], [0], [31], [124], [0], [202] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_637** (textlines)

Number of words with corpus code 637  - see lns_corp_637  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           55 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          275 `\
<br>**`sum      :`** `      136 383 `\
<br>**`range    :`** `[ 0 ] ... [ 2444 ] `\
<br>**`examples :`** ` [177], [0], [0], [0], [0], [485], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_638** (textlines)

Number of words with corpus code 638  - see lns_corp_638  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           20 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          135 `\
<br>**`sum      :`** `       24 497 `\
<br>**`range    :`** `[ 0 ] ... [ 649 ] `\
<br>**`examples :`** ` [0], [0], [0], [132], [0], [0], [0], [0], [0], [132] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_639** (textlines)

Number of words with corpus code 639  - see lns_corp_639  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          207 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          691 `\
<br>**`sum      :`** `      673 166 `\
<br>**`range    :`** `[ 0 ] ... [ 6014 ] `\
<br>**`examples :`** ` [158], [209], [812], [0], [0], [158], [795], [283], [320], [158] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_641** (textlines)

Number of words with corpus code 641  - see lns_corp_641  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           45 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          419 `\
<br>**`sum      :`** `       63 180 `\
<br>**`range    :`** `[ 0 ] ... [ 439 ] `\
<br>**`examples :`** ` [78], [0], [137], [292], [0], [198], [115], [182], [224], [78] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_642** (textlines)

Number of words with corpus code 642  - see lns_corp_642  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           32 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          239 `\
<br>**`sum      :`** `       26 096 `\
<br>**`range    :`** `[ 0 ] ... [ 643 ] `\
<br>**`examples :`** ` [0], [74], [0], [0], [0], [127], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_643** (textlines)

Number of words with corpus code 643  - see lns_corp_643  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           22 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          207 `\
<br>**`sum      :`** `       20 175 `\
<br>**`range    :`** `[ 0 ] ... [ 202 ] `\
<br>**`examples :`** ` [0], [154], [138], [0], [0], [28], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_651** (textlines)

Number of words with corpus code 651  - see lns_corp_651  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          121 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          750 `\
<br>**`sum      :`** `      317 168 `\
<br>**`range    :`** `[ 0 ] ... [ 2439 ] `\
<br>**`examples :`** ` [78], [78], [274], [227], [0], [78], [274], [318], [201], [274] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_652** (textlines)

Number of words with corpus code 652  - see lns_corp_652  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          113 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          740 `\
<br>**`sum      :`** `      190 488 `\
<br>**`range    :`** `[ 0 ] ... [ 2080 ] `\
<br>**`examples :`** ` [178], [0], [235], [123], [2080], [130], [0], [108], [133], [75] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_653** (textlines)

Number of words with corpus code 653  - see lns_corp_653  for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          209 `\
<br>**`sum      :`** `       16 638 `\
<br>**`range    :`** `[ 0 ] ... [ 328 ] `\
<br>**`examples :`** ` [148], [0], [201], [0], [0], [0], [0], [0], [25], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_6211** (textlines)

Number of words with corpus code 6211 - see lns_corp_6211 for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           96 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          748 `\
<br>**`sum      :`** `      260 408 `\
<br>**`range    :`** `[ 0 ] ... [ 1308 ] `\
<br>**`examples :`** ` [385], [1308], [382], [189], [382], [145], [610], [153], [189], [127] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_6212** (textlines)

Number of words with corpus code 6212 - see lns_corp_6212 for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          106 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          730 `\
<br>**`sum      :`** `      180 361 `\
<br>**`range    :`** `[ 0 ] ... [ 1060 ] `\
<br>**`examples :`** ` [394], [295], [25], [417], [229], [233], [438], [81], [417], [102] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_6221** (textlines)

Number of words with corpus code 6221 - see lns_corp_6221 for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           63 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          548 `\
<br>**`sum      :`** `       58 845 `\
<br>**`range    :`** `[ 0 ] ... [ 312 ] `\
<br>**`examples :`** ` [0], [50], [0], [136], [41], [120], [0], [120], [131], [110] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_6222** (textlines)

Number of words with corpus code 6222 - see lns_corp_6222 for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           61 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          479 `\
<br>**`sum      :`** `       88 290 `\
<br>**`range    :`** `[ 0 ] ... [ 598 ] `\
<br>**`examples :`** ` [149], [77], [0], [0], [156], [0], [125], [242], [0], [156] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_6351** (textlines)

Number of words with corpus code 6351 - see lns_corp_6351 for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           22 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          144 `\
<br>**`sum      :`** `        8 169 `\
<br>**`range    :`** `[ 0 ] ... [ 179 ] `\
<br>**`examples :`** ` [43], [46], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_6352** (textlines)

Number of words with corpus code 6352 - see lns_corp_6352 for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           42 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          459 `\
<br>**`sum      :`** `       41 600 `\
<br>**`range    :`** `[ 0 ] ... [ 323 ] `\
<br>**`examples :`** ` [0], [0], [14], [84], [234], [17], [101], [0], [83], [21] ... `\
<br>

<p>&nbsp;</p>
## 07 raw corpus codes - 7 to 999



**lns_corp_8** (textlines)

Number of lines with corpus code 8    

 8   General Rules Regarding Formation and Legislative Session; Discontinuity

**`class    :`** `      numeric `\
<br>**`unique   :`** `           17 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          594 `\
<br>**`sum      :`** `        4 044 `\
<br>**`range    :`** `[ 0 ] ... [ 22 ] `\
<br>**`examples :`** ` [11], [0], [0], [2], [7], [5], [1], [1], [9], [9] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_9** (textlines)

Number of lines with corpus code 9    

 9   Final Provisions

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          261 `\
<br>**`sum      :`** `          918 `\
<br>**`range    :`** `[ 0 ] ... [ 12 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [4], [0], [0], [1], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_10** (textlines)

Number of lines with corpus code 10   

 10  Miscellaneous (cannot be coded otherwise)

**`class    :`** `      numeric `\
<br>**`unique   :`** `           48 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          767 `\
<br>**`sum      :`** `       11 775 `\
<br>**`range    :`** `[ 0 ] ... [ 164 ] `\
<br>**`examples :`** ` [13], [5], [139], [7], [14], [6], [24], [12], [19], [3] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_71** (textlines)

Number of lines with corpus code 71   

 7 Change and Interpretation of the Standing Orders 

 71 rules regarding changing the standing orders

**`class    :`** `      numeric `\
<br>**`unique   :`** `           12 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          291 `\
<br>**`sum      :`** `        1 112 `\
<br>**`range    :`** `[ 0 ] ... [ 25 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [1], [2], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_72** (textlines)

Number of lines with corpus code 72   

 7 Change and Interpretation of the Standing Orders 

 72 rules regarding interpretation of and deviation from standing orders

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          218 `\
<br>**`sum      :`** `          485 `\
<br>**`range    :`** `[ 0 ] ... [ 6 ] `\
<br>**`examples :`** ` [0], [0], [6], [1], [1], [0], [6], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_73** (textlines)

Number of lines with corpus code 73   

 7 Change and Interpretation of the Standing Orders 

 73 debate about standing orders and motions regarding the standing orders

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          145 `\
<br>**`sum      :`** `          695 `\
<br>**`range    :`** `[ 0 ] ... [ 20 ] `\
<br>**`examples :`** ` [0], [2], [0], [0], [0], [0], [17], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_999** (textlines)

Number of lines with corpus code 999  

 999 Footnotes and Titles Without Relevant Content

**`class    :`** `      integer `\
<br>**`unique   :`** `          265 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      162 568 `\
<br>**`range    :`** `[ 29 ] ... [ 1728 ] `\
<br>**`examples :`** ` [274], [317], [747], [163], [386], [287], [44], [258], [423], [29] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_8** (textlines)

Number of words with corpus code 8    - see lns_corp_8    for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           89 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          594 `\
<br>**`sum      :`** `      140 723 `\
<br>**`range    :`** `[ 0 ] ... [ 729 ] `\
<br>**`examples :`** ` [0], [290], [296], [184], [382], [93], [290], [128], [187], [271] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_9** (textlines)

Number of words with corpus code 9    - see lns_corp_9    for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           45 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          261 `\
<br>**`sum      :`** `       27 408 `\
<br>**`range    :`** `[ 0 ] ... [ 633 ] `\
<br>**`examples :`** ` [0], [13], [181], [152], [0], [0], [0], [0], [13], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_10** (textlines)

Number of words with corpus code 10   - see lns_corp_10   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          162 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          767 `\
<br>**`sum      :`** `      339 747 `\
<br>**`range    :`** `[ 0 ] ... [ 3571 ] `\
<br>**`examples :`** ` [95], [219], [523], [103], [226], [301], [398], [193], [194], [14] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_71** (textlines)

Number of words with corpus code 71   - see lns_corp_71   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           43 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          291 `\
<br>**`sum      :`** `       36 495 `\
<br>**`range    :`** `[ 0 ] ... [ 588 ] `\
<br>**`examples :`** ` [185], [388], [242], [0], [112], [0], [87], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_72** (textlines)

Number of words with corpus code 72   - see lns_corp_72   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          218 `\
<br>**`sum      :`** `       16 556 `\
<br>**`range    :`** `[ 0 ] ... [ 148 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_73** (textlines)

Number of words with corpus code 73   - see lns_corp_73   for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           18 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          145 `\
<br>**`sum      :`** `       14 599 `\
<br>**`range    :`** `[ 0 ] ... [ 296 ] `\
<br>**`examples :`** ` [0], [94], [0], [0], [0], [0], [0], [0], [91], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_999** (textlines)

Number of words with corpus code 999  - see lns_corp_999  for more information.

**`class    :`** `      integer `\
<br>**`unique   :`** `          333 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      453 248 `\
<br>**`range    :`** `[ 38 ] ... [ 30211 ] `\
<br>**`examples :`** ` [1500], [215], [646], [145], [1561], [1013], [87], [126], [189], [957] ... `\
<br>

<p>&nbsp;</p>
## 08 aggregated corpus codes - topics



**lns_corp_top_1** (textlines)

Number of lines with aggregated corpus code 1  - lawmaking               

 codes: 111, 112, 113, 114, 121, 122, 123, 124, 125, 131, 132, 133, 134, 141, 142, 143, 144, 145 

**`class    :`** `      numeric `\
<br>**`unique   :`** `          114 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `       65 567 `\
<br>**`range    :`** `[ 9 ] ... [ 192 ] `\
<br>**`examples :`** ` [104], [130], [132], [59], [65], [52], [87], [110], [104], [69] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_top_2** (textlines)

Number of lines with aggregated corpus code 2  - special decission rules 

 codes: 21, 22, 23, 241, 242, 243, 244, 26, 27, 28, 29, 67, 71, 72, 73

**`class    :`** `      numeric `\
<br>**`unique   :`** `          130 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          771 `\
<br>**`sum      :`** `       54 630 `\
<br>**`range    :`** `[ 0 ] ... [ 342 ] `\
<br>**`examples :`** ` [74], [32], [43], [54], [321], [10], [43], [63], [115], [10] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_top_3** (textlines)

Number of lines with aggregated corpus code 3  - elections               

 codes: 25, 31, 32, 33, 411, 421, 441 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           45 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          538 `\
<br>**`sum      :`** `       14 023 `\
<br>**`range    :`** `[ 0 ] ... [ 98 ] `\
<br>**`examples :`** ` [60], [13], [16], [50], [50], [50], [52], [16], [10], [16] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_top_4** (textlines)

Number of lines with aggregated corpus code 4  - government control      

 codes: 412, 53, 54, 636, 637, 66 

**`class    :`** `      numeric `\
<br>**`unique   :`** `           83 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `       32 003 `\
<br>**`range    :`** `[ 1 ] ... [ 164 ] `\
<br>**`examples :`** ` [29], [33], [30], [21], [60], [62], [22], [71], [3], [29] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_top_5** (textlines)

Number of lines with aggregated corpus code 5  - puplicity               

 codes: 121, 51, 52, 53, 55, 56, 611, 612, 613 

**`class    :`** `      numeric `\
<br>**`unique   :`** `          160 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `       97 367 `\
<br>**`range    :`** `[ 9 ] ... [ 314 ] `\
<br>**`examples :`** ` [102], [129], [272], [122], [166], [73], [107], [94], [16], [19] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_top_66** (textlines)

Number of lines with aggregated corpus code 66 - not used for aggregation

 codes: 34, 422, 43, 442, 45, 6211, 6212, 6221, 6222, 631, 632, 633, 634, 6351, 6352, 638, 639, 641, 642, 643, 651, 652, 653, 68, 8, 9, 10, 999

**`class    :`** `      numeric `\
<br>**`unique   :`** `          205 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      124 261 `\
<br>**`range    :`** `[ 21 ] ... [ 464 ] `\
<br>**`examples :`** ` [205], [99], [136], [171], [84], [70], [105], [131], [210], [299] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_top_77** (textlines)

Number of lines with aggregated corpus code 77 - not relevant 

 codes: 999

**`class    :`** `      numeric `\
<br>**`unique   :`** `          265 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      162 568 `\
<br>**`range    :`** `[ 29 ] ... [ 1728 ] `\
<br>**`examples :`** ` [29], [116], [204], [179], [499], [166], [51], [108], [192], [216] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_top_1** (textlines)

Number of words with aggregated corpus code 1 - lawmaking               

 codes: 111, 112, 113, 114, 121, 122, 123, 124, 125, 131, 132, 133, 134, 141, 142, 143, 144, 145 

**`class    :`** `      numeric `\
<br>**`unique   :`** `          334 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `    2 362 812 `\
<br>**`range    :`** `[ 638 ] ... [ 7885 ] `\
<br>**`examples :`** ` [2113], [2121], [1650], [2971], [2324], [3742], [5292], [2158], [3148], [1735] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_top_2** (textlines)

Number of words with aggregated corpus code 2 - special decission rules 

 codes: 21, 22, 23, 241, 242, 243, 244, 26, 27, 28, 29, 67, 71, 72, 73

**`class    :`** `      numeric `\
<br>**`unique   :`** `          325 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          771 `\
<br>**`sum      :`** `    2 023 258 `\
<br>**`range    :`** `[ 0 ] ... [ 11364 ] `\
<br>**`examples :`** ` [2876], [1313], [7149], [549], [1931], [831], [807], [1098], [348], [2585] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_top_3** (textlines)

Number of words with aggregated corpus code 3 - elections               

 codes: 25, 31, 32, 33, 411, 421, 441 

**`class    :`** `      numeric `\
<br>**`unique   :`** `          128 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          538 `\
<br>**`sum      :`** `      458 198 `\
<br>**`range    :`** `[ 0 ] ... [ 2478 ] `\
<br>**`examples :`** ` [457], [0], [557], [495], [715], [2381], [1746], [260], [0], [1734] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_top_4** (textlines)

Number of words with aggregated corpus code 4 - government control      

 codes: 412, 53, 54, 636, 637, 66 

**`class    :`** `      numeric `\
<br>**`unique   :`** `          271 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `    1 117 264 `\
<br>**`range    :`** `[ 16 ] ... [ 5511 ] `\
<br>**`examples :`** ` [1328], [940], [2294], [1235], [1409], [2430], [1067], [526], [1411], [925] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_top_5** (textlines)

Number of words with aggregated corpus code 5 - puplicity               

 codes: 121, 51, 52, 53, 55, 56, 611, 612, 613 

**`class    :`** `      numeric `\
<br>**`unique   :`** `          420 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `    3 461 645 `\
<br>**`range    :`** `[ 270 ] ... [ 11338 ] `\
<br>**`examples :`** ` [6259], [2227], [7531], [2081], [327], [1827], [3387], [2107], [372], [8321] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_top_66** (textlines)

Number of words with aggregated corpus code 66 - not used for aggregation

 codes: 34, 422, 43, 442, 45, 6211, 6212, 6221, 6222, 631, 632, 633, 634, 6351, 6352, 638, 639, 641, 642, 643, 651, 652, 653, 68, 8, 9, 10

**`class    :`** `      numeric `\
<br>**`unique   :`** `          560 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `    3 731 824 `\
<br>**`range    :`** `[ 1010 ] ... [ 13975 ] `\
<br>**`examples :`** ` [7043], [3033], [4186], [5130], [3455], [3104], [3262], [6594], [4217], [11722] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_top_77** (textlines)

Number of words with aggregated corpus code 77 - not relevant 

 codes: 999

**`class    :`** `      numeric `\
<br>**`unique   :`** `          333 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      453 248 `\
<br>**`range    :`** `[ 38 ] ... [ 30211 ] `\
<br>**`examples :`** ` [957], [2220], [197], [1128], [2162], [317], [151], [137], [138], [506] ... `\
<br>

<p>&nbsp;</p>
## 09 aggregated corpus codes - actors



**lns_corp_act_1** (textlines)

Number of lines with aggregated corpus code 1  - MPs             

 codes: 111,651,652,653

**`class    :`** `      numeric `\
<br>**`unique   :`** `           65 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          783 `\
<br>**`sum      :`** `       17 732 `\
<br>**`range    :`** `[ 0 ] ... [ 128 ] `\
<br>**`examples :`** ` [11], [11], [16], [16], [11], [8], [18], [17], [36], [18] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_act_2** (textlines)

Number of lines with aggregated corpus code 2  - PPGs            

 codes: 641,642,643

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          450 `\
<br>**`sum      :`** `        3 370 `\
<br>**`range    :`** `[ 0 ] ... [ 61 ] `\
<br>**`examples :`** ` [0], [5], [10], [1], [0], [6], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_act_3** (textlines)

Number of lines with aggregated corpus code 3  - committees      

 codes: 125, 131, 132, 133, 134, 242, 54, 631, 632, 633, 634, 6351, 6352, 636, 637, 638, 639

**`class    :`** `      numeric `\
<br>**`unique   :`** `          168 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `       93 034 `\
<br>**`range    :`** `[ 5 ] ... [ 404 ] `\
<br>**`examples :`** ` [5], [125], [139], [199], [25], [186], [66], [89], [88], [89] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_act_4** (textlines)

Number of lines with aggregated corpus code 4  - governing body  

 codes: 612, 6211, 6212, 6221, 6222

**`class    :`** `      numeric `\
<br>**`unique   :`** `           64 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          776 `\
<br>**`sum      :`** `       28 240 `\
<br>**`range    :`** `[ 0 ] ... [ 126 ] `\
<br>**`examples :`** ` [71], [22], [42], [14], [30], [36], [29], [73], [77], [3] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_act_66** (textlines)

Number of lines with aggregated corpus code 66 - not used for aggregation

 codes: 112, 123, 22, 55, 8, 56, 34, 113, 611, 121, 122, 51, 73, 21, 142, 32, 26, 71, 25, 53, 143, 23, 10, 9, 68, 412, 52, 411, 145, 43, 241, 243, 244, 72, 114, 613, 29, 124, 33, 31, 27, 28, 141, 442, 66, 441, 45, 422, 421, 144

**`class    :`** `      numeric `\
<br>**`unique   :`** `          284 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      223 058 `\
<br>**`range    :`** `[ 31 ] ... [ 738 ] `\
<br>**`examples :`** ` [160], [155], [697], [268], [134], [261], [285], [214], [364], [194] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_act_77** (textlines)

Number of lines with aggregated corpus code 77 - not relevant 

 codes: 999

**`class    :`** `      numeric `\
<br>**`unique   :`** `          265 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      162 568 `\
<br>**`range    :`** `[ 29 ] ... [ 1728 ] `\
<br>**`examples :`** ` [39], [203], [49], [48], [139], [103], [39], [93], [97], [393] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_act_1** (textlines)

Number of words with aggregated corpus code 1  - MPs             

 codes: 111,651,652,653

**`class    :`** `      numeric `\
<br>**`unique   :`** `          202 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          783 `\
<br>**`sum      :`** `      602 402 `\
<br>**`range    :`** `[ 0 ] ... [ 4779 ] `\
<br>**`examples :`** ` [261], [626], [472], [540], [562], [1993], [492], [868], [626], [1411] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_act_2** (textlines)

Number of words with aggregated corpus code 2  - PPGs            

 codes: 641,642,643

**`class    :`** `      numeric `\
<br>**`unique   :`** `           67 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          450 `\
<br>**`sum      :`** `      109 451 `\
<br>**`range    :`** `[ 0 ] ... [ 841 ] `\
<br>**`examples :`** ` [237], [0], [232], [0], [30], [220], [0], [0], [195], [530] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_act_3** (textlines)

Number of words with aggregated corpus code 3  - committees      

 codes: 125, 131, 132, 133, 134, 242, 54, 631, 632, 633, 634, 6351, 6352, 636, 637, 638, 639

**`class    :`** `      numeric `\
<br>**`unique   :`** `          476 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `    2 864 288 `\
<br>**`range    :`** `[ 264 ] ... [ 12091 ] `\
<br>**`examples :`** ` [1363], [3321], [2429], [3357], [1592], [5422], [3548], [6861], [2444], [7574] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_act_4** (textlines)

Number of words with aggregated corpus code 4  - governing body  

 codes: 612, 6211, 6212, 6221, 6222

**`class    :`** `      numeric `\
<br>**`unique   :`** `          201 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          776 `\
<br>**`sum      :`** `      997 383 `\
<br>**`range    :`** `[ 0 ] ... [ 3291 ] `\
<br>**`examples :`** ` [3141], [2079], [554], [653], [29], [733], [1793], [217], [803], [753] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_act_66** (textlines)

Number of words with aggregated corpus code 66 - not used for aggregation

 codes: 112, 123, 22, 55, 8, 56, 34, 113, 611, 121, 122, 51, 73, 21, 142, 32, 26, 71, 25, 53, 143, 23, 10, 9, 68, 412, 52, 411, 145, 43, 241, 243, 244, 72, 114, 613, 29, 124, 33, 31, 27, 28, 141, 442, 66, 441, 45, 422, 421, 144

**`class    :`** `      numeric `\
<br>**`unique   :`** `          623 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `    7 781 117 `\
<br>**`range    :`** `[ 1810 ] ... [ 25564 ] `\
<br>**`examples :`** ` [13688], [25303], [4435], [3692], [6960], [4182], [8779], [10542], [13260], [349 ... `\
<br>

<p>&nbsp;</p>

**wds_corp_act_77** (textlines)

Number of words with aggregated corpus code 77 - not relevant 

 codes: 999

**`class    :`** `      numeric `\
<br>**`unique   :`** `          333 `\
<br>**`NAs      :`** `            0 `\
<br>**`not-NA   :`** `          786 `\
<br>**`not-0-NA :`** `          786 `\
<br>**`sum      :`** `      453 248 `\
<br>**`range    :`** `[ 38 ] ... [ 30211 ] `\
<br>**`examples :`** ` [110], [324], [524], [194], [183], [281], [420], [190], [646], [626] ... `\
<br>

<p>&nbsp;</p>
## 10 corpus code changes



**wds_corp_mdf_8** (textlines, linelinkage)

Number of words with corpus code 8    which have changed from last version to this - see lns_corp_8    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           49 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           63 `\
<br>**`sum      :`** `        4 087 `\
<br>**`range    :`** `[ 0 ] ... [ 544 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_9** (textlines, linelinkage)

Number of words with corpus code 9    which have changed from last version to this - see lns_corp_9    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            7 `\
<br>**`sum      :`** `          151 `\
<br>**`range    :`** `[ 0 ] ... [ 112 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_10** (textlines, linelinkage)

Number of words with corpus code 10   which have changed from last version to this - see lns_corp_10   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           64 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          102 `\
<br>**`sum      :`** `        6 498 `\
<br>**`range    :`** `[ 0 ] ... [ 467 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [72], [0], [0], [71] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_21** (textlines, linelinkage)

Number of words with corpus code 21   which have changed from last version to this - see lns_corp_21   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           32 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           35 `\
<br>**`sum      :`** `        2 856 `\
<br>**`range    :`** `[ 0 ] ... [ 437 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [101], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_22** (textlines, linelinkage)

Number of words with corpus code 22   which have changed from last version to this - see lns_corp_22   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           92 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          127 `\
<br>**`sum      :`** `       20 098 `\
<br>**`range    :`** `[ 0 ] ... [ 4427 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [296], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_23** (textlines, linelinkage)

Number of words with corpus code 23   which have changed from last version to this - see lns_corp_23   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           26 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           26 `\
<br>**`sum      :`** `        1 694 `\
<br>**`range    :`** `[ 0 ] ... [ 276 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_25** (textlines, linelinkage)

Number of words with corpus code 25   which have changed from last version to this - see lns_corp_25   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           49 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           61 `\
<br>**`sum      :`** `        6 262 `\
<br>**`range    :`** `[ 0 ] ... [ 1819 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_26** (textlines, linelinkage)

Number of words with corpus code 26   which have changed from last version to this - see lns_corp_26   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           44 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           60 `\
<br>**`sum      :`** `        5 154 `\
<br>**`range    :`** `[ 0 ] ... [ 1081 ] `\
<br>**`examples :`** ` [0], [99], [0], [0], [117], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_27** (textlines, linelinkage)

Number of words with corpus code 27   which have changed from last version to this - see lns_corp_27   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            8 `\
<br>**`sum      :`** `          284 `\
<br>**`range    :`** `[ 0 ] ... [ 105 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_28** (textlines, linelinkage)

Number of words with corpus code 28   which have changed from last version to this - see lns_corp_28   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            6 `\
<br>**`sum      :`** `          350 `\
<br>**`range    :`** `[ 0 ] ... [ 205 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [NA], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_29** (textlines, linelinkage)

Number of words with corpus code 29   which have changed from last version to this - see lns_corp_29   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           41 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           50 `\
<br>**`sum      :`** `        3 658 `\
<br>**`range    :`** `[ 0 ] ... [ 533 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_31** (textlines, linelinkage)

Number of words with corpus code 31   which have changed from last version to this - see lns_corp_31   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           11 `\
<br>**`sum      :`** `          381 `\
<br>**`range    :`** `[ 0 ] ... [ 186 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_32** (textlines, linelinkage)

Number of words with corpus code 32   which have changed from last version to this - see lns_corp_32   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           19 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           21 `\
<br>**`sum      :`** `        1 533 `\
<br>**`range    :`** `[ 0 ] ... [ 691 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_33** (textlines, linelinkage)

Number of words with corpus code 33   which have changed from last version to this - see lns_corp_33   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           13 `\
<br>**`sum      :`** `          621 `\
<br>**`range    :`** `[ 0 ] ... [ 284 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_34** (textlines, linelinkage)

Number of words with corpus code 34   which have changed from last version to this - see lns_corp_34   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           45 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           69 `\
<br>**`sum      :`** `        3 338 `\
<br>**`range    :`** `[ 0 ] ... [ 298 ] `\
<br>**`examples :`** ` [0], [0], [0], [7], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_43** (textlines, linelinkage)

Number of words with corpus code 43   which have changed from last version to this - see lns_corp_43   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           11 `\
<br>**`sum      :`** `          428 `\
<br>**`range    :`** `[ 0 ] ... [ 142 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_45** (textlines, linelinkage)

Number of words with corpus code 45   which have changed from last version to this - see lns_corp_45   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            7 `\
<br>**`sum      :`** `          341 `\
<br>**`range    :`** `[ 0 ] ... [ 143 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_51** (textlines, linelinkage)

Number of words with corpus code 51   which have changed from last version to this - see lns_corp_51   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           90 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          128 `\
<br>**`sum      :`** `       16 869 `\
<br>**`range    :`** `[ 0 ] ... [ 2587 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_52** (textlines, linelinkage)

Number of words with corpus code 52   which have changed from last version to this - see lns_corp_52   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           28 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           27 `\
<br>**`sum      :`** `        2 081 `\
<br>**`range    :`** `[ 0 ] ... [ 322 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [71], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_53** (textlines, linelinkage)

Number of words with corpus code 53   which have changed from last version to this - see lns_corp_53   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          116 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          151 `\
<br>**`sum      :`** `       22 290 `\
<br>**`range    :`** `[ 0 ] ... [ 1149 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [4], [0], [0], [0], [27] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_54** (textlines, linelinkage)

Number of words with corpus code 54   which have changed from last version to this - see lns_corp_54   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           44 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           56 `\
<br>**`sum      :`** `        4 287 `\
<br>**`range    :`** `[ 0 ] ... [ 602 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [NA], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_55** (textlines, linelinkage)

Number of words with corpus code 55   which have changed from last version to this - see lns_corp_55   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           62 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           89 `\
<br>**`sum      :`** `        6 329 `\
<br>**`range    :`** `[ 0 ] ... [ 586 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [17], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_56** (textlines, linelinkage)

Number of words with corpus code 56   which have changed from last version to this - see lns_corp_56   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           76 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          108 `\
<br>**`sum      :`** `        7 379 `\
<br>**`range    :`** `[ 0 ] ... [ 469 ] `\
<br>**`examples :`** ` [0], [201], [0], [0], [0], [304], [116], [0], [0], [26] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_66** (textlines, linelinkage)

Number of words with corpus code 66   which have changed from last version to this - see lns_corp_66   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_67** (textlines, linelinkage)

Number of words with corpus code 67   which have changed from last version to this - see lns_corp_67   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            5 `\
<br>**`sum      :`** `          274 `\
<br>**`range    :`** `[ 0 ] ... [ 140 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [NA], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_68** (textlines, linelinkage)

Number of words with corpus code 68   which have changed from last version to this - see lns_corp_68   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           39 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           55 `\
<br>**`sum      :`** `        2 903 `\
<br>**`range    :`** `[ 0 ] ... [ 346 ] `\
<br>**`examples :`** ` [0], [0], [0], [7], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_71** (textlines, linelinkage)

Number of words with corpus code 71   which have changed from last version to this - see lns_corp_71   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           30 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           33 `\
<br>**`sum      :`** `        1 569 `\
<br>**`range    :`** `[ 0 ] ... [ 322 ] `\
<br>**`examples :`** ` [0], [0], [62], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_72** (textlines, linelinkage)

Number of words with corpus code 72   which have changed from last version to this - see lns_corp_72   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           15 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           15 `\
<br>**`sum      :`** `          492 `\
<br>**`range    :`** `[ 0 ] ... [ 158 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_73** (textlines, linelinkage)

Number of words with corpus code 73   which have changed from last version to this - see lns_corp_73   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           11 `\
<br>**`sum      :`** `          595 `\
<br>**`range    :`** `[ 0 ] ... [ 282 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [NA], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_111** (textlines, linelinkage)

Number of words with corpus code 111  which have changed from last version to this - see lns_corp_111  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           35 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           41 `\
<br>**`sum      :`** `        1 739 `\
<br>**`range    :`** `[ 0 ] ... [ 192 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [157], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_112** (textlines, linelinkage)

Number of words with corpus code 112  which have changed from last version to this - see lns_corp_112  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           45 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           59 `\
<br>**`sum      :`** `        3 021 `\
<br>**`range    :`** `[ 0 ] ... [ 450 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_113** (textlines, linelinkage)

Number of words with corpus code 113  which have changed from last version to this - see lns_corp_113  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           54 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           82 `\
<br>**`sum      :`** `        6 009 `\
<br>**`range    :`** `[ 0 ] ... [ 592 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [NA], [169], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_114** (textlines, linelinkage)

Number of words with corpus code 114  which have changed from last version to this - see lns_corp_114  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           16 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           16 `\
<br>**`sum      :`** `        1 645 `\
<br>**`range    :`** `[ 0 ] ... [ 524 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_121** (textlines, linelinkage)

Number of words with corpus code 121  which have changed from last version to this - see lns_corp_121  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           57 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           71 `\
<br>**`sum      :`** `        5 700 `\
<br>**`range    :`** `[ 0 ] ... [ 545 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [8], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_122** (textlines, linelinkage)

Number of words with corpus code 122  which have changed from last version to this - see lns_corp_122  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           46 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           63 `\
<br>**`sum      :`** `        3 458 `\
<br>**`range    :`** `[ 0 ] ... [ 290 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [8], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_123** (textlines, linelinkage)

Number of words with corpus code 123  which have changed from last version to this - see lns_corp_123  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           89 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          130 `\
<br>**`sum      :`** `       14 288 `\
<br>**`range    :`** `[ 0 ] ... [ 1177 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_124** (textlines, linelinkage)

Number of words with corpus code 124  which have changed from last version to this - see lns_corp_124  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           16 `\
<br>**`sum      :`** `          358 `\
<br>**`range    :`** `[ 0 ] ... [ 176 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [NA], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_125** (textlines, linelinkage)

Number of words with corpus code 125  which have changed from last version to this - see lns_corp_125  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           57 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           77 `\
<br>**`sum      :`** `        4 681 `\
<br>**`range    :`** `[ 0 ] ... [ 355 ] `\
<br>**`examples :`** ` [0], [0], [12], [NA], [2], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_131** (textlines, linelinkage)

Number of words with corpus code 131  which have changed from last version to this - see lns_corp_131  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           36 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           42 `\
<br>**`sum      :`** `        1 999 `\
<br>**`range    :`** `[ 0 ] ... [ 311 ] `\
<br>**`examples :`** ` [0], [0], [0], [67], [0], [46], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_132** (textlines, linelinkage)

Number of words with corpus code 132  which have changed from last version to this - see lns_corp_132  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           20 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           22 `\
<br>**`sum      :`** `          730 `\
<br>**`range    :`** `[ 0 ] ... [ 143 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_133** (textlines, linelinkage)

Number of words with corpus code 133  which have changed from last version to this - see lns_corp_133  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           31 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           42 `\
<br>**`sum      :`** `        1 254 `\
<br>**`range    :`** `[ 0 ] ... [ 148 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_134** (textlines, linelinkage)

Number of words with corpus code 134  which have changed from last version to this - see lns_corp_134  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           65 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          101 `\
<br>**`sum      :`** `        6 142 `\
<br>**`range    :`** `[ 0 ] ... [ 269 ] `\
<br>**`examples :`** ` [0], [0], [0], [269], [0], [0], [0], [0], [0], [196] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_141** (textlines, linelinkage)

Number of words with corpus code 141  which have changed from last version to this - see lns_corp_141  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            7 `\
<br>**`sum      :`** `          189 `\
<br>**`range    :`** `[ 0 ] ... [ 69 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_142** (textlines, linelinkage)

Number of words with corpus code 142  which have changed from last version to this - see lns_corp_142  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           31 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           37 `\
<br>**`sum      :`** `        2 166 `\
<br>**`range    :`** `[ 0 ] ... [ 591 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_143** (textlines, linelinkage)

Number of words with corpus code 143  which have changed from last version to this - see lns_corp_143  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           12 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           14 `\
<br>**`sum      :`** `          459 `\
<br>**`range    :`** `[ 0 ] ... [ 153 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_144** (textlines, linelinkage)

Number of words with corpus code 144  which have changed from last version to this - see lns_corp_144  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            5 `\
<br>**`sum      :`** `           76 `\
<br>**`range    :`** `[ 0 ] ... [ 52 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_145** (textlines, linelinkage)

Number of words with corpus code 145  which have changed from last version to this - see lns_corp_145  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            4 `\
<br>**`sum      :`** `          113 `\
<br>**`range    :`** `[ 0 ] ... [ 45 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_241** (textlines, linelinkage)

Number of words with corpus code 241  which have changed from last version to this - see lns_corp_241  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           24 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           23 `\
<br>**`sum      :`** `        1 339 `\
<br>**`range    :`** `[ 0 ] ... [ 289 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_242** (textlines, linelinkage)

Number of words with corpus code 242  which have changed from last version to this - see lns_corp_242  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           27 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           33 `\
<br>**`sum      :`** `        2 539 `\
<br>**`range    :`** `[ 0 ] ... [ 1096 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [12], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_243** (textlines, linelinkage)

Number of words with corpus code 243  which have changed from last version to this - see lns_corp_243  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            3 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            1 `\
<br>**`sum      :`** `          115 `\
<br>**`range    :`** `[ 0 ] ... [ 115 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_244** (textlines, linelinkage)

Number of words with corpus code 244  which have changed from last version to this - see lns_corp_244  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           11 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           10 `\
<br>**`sum      :`** `          318 `\
<br>**`range    :`** `[ 0 ] ... [ 85 ] `\
<br>**`examples :`** ` [12], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_411** (textlines, linelinkage)

Number of words with corpus code 411  which have changed from last version to this - see lns_corp_411  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           20 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           18 `\
<br>**`sum      :`** `        1 997 `\
<br>**`range    :`** `[ 0 ] ... [ 535 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_412** (textlines, linelinkage)

Number of words with corpus code 412  which have changed from last version to this - see lns_corp_412  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           27 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           33 `\
<br>**`sum      :`** `        1 299 `\
<br>**`range    :`** `[ 0 ] ... [ 133 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_421** (textlines, linelinkage)

Number of words with corpus code 421  which have changed from last version to this - see lns_corp_421  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            9 `\
<br>**`sum      :`** `          290 `\
<br>**`range    :`** `[ 0 ] ... [ 136 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_422** (textlines, linelinkage)

Number of words with corpus code 422  which have changed from last version to this - see lns_corp_422  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            8 `\
<br>**`sum      :`** `          210 `\
<br>**`range    :`** `[ 0 ] ... [ 72 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [NA], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_441** (textlines, linelinkage)

Number of words with corpus code 441  which have changed from last version to this - see lns_corp_441  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [NA], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_442** (textlines, linelinkage)

Number of words with corpus code 442  which have changed from last version to this - see lns_corp_442  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            5 `\
<br>**`sum      :`** `           65 `\
<br>**`range    :`** `[ 0 ] ... [ 23 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_611** (textlines, linelinkage)

Number of words with corpus code 611  which have changed from last version to this - see lns_corp_611  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           95 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          139 `\
<br>**`sum      :`** `       12 499 `\
<br>**`range    :`** `[ 0 ] ... [ 476 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_612** (textlines, linelinkage)

Number of words with corpus code 612  which have changed from last version to this - see lns_corp_612  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           48 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           66 `\
<br>**`sum      :`** `        5 686 `\
<br>**`range    :`** `[ 0 ] ... [ 789 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [NA] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_613** (textlines, linelinkage)

Number of words with corpus code 613  which have changed from last version to this - see lns_corp_613  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           62 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           86 `\
<br>**`sum      :`** `        5 285 `\
<br>**`range    :`** `[ 0 ] ... [ 327 ] `\
<br>**`examples :`** ` [68], [0], [0], [0], [51], [73], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_631** (textlines, linelinkage)

Number of words with corpus code 631  which have changed from last version to this - see lns_corp_631  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           26 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           32 `\
<br>**`sum      :`** `        1 413 `\
<br>**`range    :`** `[ 0 ] ... [ 218 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_632** (textlines, linelinkage)

Number of words with corpus code 632  which have changed from last version to this - see lns_corp_632  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `          110 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          219 `\
<br>**`sum      :`** `       23 580 `\
<br>**`range    :`** `[ 0 ] ... [ 4856 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [20], [0], [23], [0], [0], [NA] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_633** (textlines, linelinkage)

Number of words with corpus code 633  which have changed from last version to this - see lns_corp_633  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           50 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           79 `\
<br>**`sum      :`** `        3 022 `\
<br>**`range    :`** `[ 0 ] ... [ 184 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_634** (textlines, linelinkage)

Number of words with corpus code 634  which have changed from last version to this - see lns_corp_634  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           60 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           97 `\
<br>**`sum      :`** `        4 524 `\
<br>**`range    :`** `[ 0 ] ... [ 337 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [51], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_636** (textlines, linelinkage)

Number of words with corpus code 636  which have changed from last version to this - see lns_corp_636  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           38 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           45 `\
<br>**`sum      :`** `        2 050 `\
<br>**`range    :`** `[ 0 ] ... [ 217 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_637** (textlines, linelinkage)

Number of words with corpus code 637  which have changed from last version to this - see lns_corp_637  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           34 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           35 `\
<br>**`sum      :`** `        2 696 `\
<br>**`range    :`** `[ 0 ] ... [ 538 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_638** (textlines, linelinkage)

Number of words with corpus code 638  which have changed from last version to this - see lns_corp_638  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          410 `\
<br>**`range    :`** `[ 0 ] ... [ 358 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_639** (textlines, linelinkage)

Number of words with corpus code 639  which have changed from last version to this - see lns_corp_639  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           78 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          135 `\
<br>**`sum      :`** `       10 934 `\
<br>**`range    :`** `[ 0 ] ... [ 1063 ] `\
<br>**`examples :`** ` [31], [0], [7], [0], [NA], [0], [0], [3], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_641** (textlines, linelinkage)

Number of words with corpus code 641  which have changed from last version to this - see lns_corp_641  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           25 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           28 `\
<br>**`sum      :`** `        1 106 `\
<br>**`range    :`** `[ 0 ] ... [ 267 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_642** (textlines, linelinkage)

Number of words with corpus code 642  which have changed from last version to this - see lns_corp_642  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           21 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           21 `\
<br>**`sum      :`** `          975 `\
<br>**`range    :`** `[ 0 ] ... [ 163 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_643** (textlines, linelinkage)

Number of words with corpus code 643  which have changed from last version to this - see lns_corp_643  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           10 `\
<br>**`sum      :`** `          502 `\
<br>**`range    :`** `[ 0 ] ... [ 154 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_651** (textlines, linelinkage)

Number of words with corpus code 651  which have changed from last version to this - see lns_corp_651  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           60 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           87 `\
<br>**`sum      :`** `        6 631 `\
<br>**`range    :`** `[ 0 ] ... [ 598 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_652** (textlines, linelinkage)

Number of words with corpus code 652  which have changed from last version to this - see lns_corp_652  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           60 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           78 `\
<br>**`sum      :`** `        6 415 `\
<br>**`range    :`** `[ 0 ] ... [ 971 ] `\
<br>**`examples :`** ` [0], [44], [NA], [0], [0], [0], [0], [0], [0], [301] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_653** (textlines, linelinkage)

Number of words with corpus code 653  which have changed from last version to this - see lns_corp_653  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            8 `\
<br>**`sum      :`** `          575 `\
<br>**`range    :`** `[ 0 ] ... [ 231 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_999** (textlines, linelinkage)

Number of words with corpus code 999  which have changed from last version to this - see lns_corp_999  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_6211** (textlines, linelinkage)

Number of words with corpus code 6211 which have changed from last version to this - see lns_corp_6211 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           56 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           69 `\
<br>**`sum      :`** `        4 530 `\
<br>**`range    :`** `[ 0 ] ... [ 477 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [31], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_6212** (textlines, linelinkage)

Number of words with corpus code 6212 which have changed from last version to this - see lns_corp_6212 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           51 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           61 `\
<br>**`sum      :`** `        5 387 `\
<br>**`range    :`** `[ 0 ] ... [ 1069 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_6221** (textlines, linelinkage)

Number of words with corpus code 6221 which have changed from last version to this - see lns_corp_6221 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           37 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           47 `\
<br>**`sum      :`** `        1 552 `\
<br>**`range    :`** `[ 0 ] ... [ 261 ] `\
<br>**`examples :`** ` [0], [21], [0], [14], [0], [0], [0], [0], [10], [30] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_6222** (textlines, linelinkage)

Number of words with corpus code 6222 which have changed from last version to this - see lns_corp_6222 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           33 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           40 `\
<br>**`sum      :`** `        1 571 `\
<br>**`range    :`** `[ 0 ] ... [ 234 ] `\
<br>**`examples :`** ` [0], [0], [0], [32], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_6351** (textlines, linelinkage)

Number of words with corpus code 6351 which have changed from last version to this - see lns_corp_6351 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           14 `\
<br>**`sum      :`** `          233 `\
<br>**`range    :`** `[ 0 ] ... [ 101 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_mdf_6352** (textlines, linelinkage)

Number of words with corpus code 6352 which have changed from last version to this - see lns_corp_6352 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           19 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           21 `\
<br>**`sum      :`** `          641 `\
<br>**`range    :`** `[ 0 ] ... [ 124 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [NA], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_8** (textlines, linelinkage)

Number of words with corpus code 8    which have changed from last version to this - see lns_corp_8    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           24 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           22 `\
<br>**`sum      :`** `        2 271 `\
<br>**`range    :`** `[ 0 ] ... [ 708 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_9** (textlines, linelinkage)

Number of words with corpus code 9    which have changed from last version to this - see lns_corp_9    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           30 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           33 `\
<br>**`sum      :`** `        2 480 `\
<br>**`range    :`** `[ 0 ] ... [ 633 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_10** (textlines, linelinkage)

Number of words with corpus code 10   which have changed from last version to this - see lns_corp_10   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           64 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           73 `\
<br>**`sum      :`** `       11 162 `\
<br>**`range    :`** `[ 0 ] ... [ 2330 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_21** (textlines, linelinkage)

Number of words with corpus code 21   which have changed from last version to this - see lns_corp_21   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           29 `\
<br>**`sum      :`** `        2 794 `\
<br>**`range    :`** `[ 0 ] ... [ 784 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_22** (textlines, linelinkage)

Number of words with corpus code 22   which have changed from last version to this - see lns_corp_22   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           73 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           80 `\
<br>**`sum      :`** `       14 195 `\
<br>**`range    :`** `[ 0 ] ... [ 1879 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [135], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_23** (textlines, linelinkage)

Number of words with corpus code 23   which have changed from last version to this - see lns_corp_23   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           19 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           17 `\
<br>**`sum      :`** `        2 253 `\
<br>**`range    :`** `[ 0 ] ... [ 547 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_25** (textlines, linelinkage)

Number of words with corpus code 25   which have changed from last version to this - see lns_corp_25   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           30 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           28 `\
<br>**`sum      :`** `        4 373 `\
<br>**`range    :`** `[ 0 ] ... [ 832 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [NA], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_26** (textlines, linelinkage)

Number of words with corpus code 26   which have changed from last version to this - see lns_corp_26   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           28 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           30 `\
<br>**`sum      :`** `        5 668 `\
<br>**`range    :`** `[ 0 ] ... [ 911 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [53], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_27** (textlines, linelinkage)

Number of words with corpus code 27   which have changed from last version to this - see lns_corp_27   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          529 `\
<br>**`range    :`** `[ 0 ] ... [ 484 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_28** (textlines, linelinkage)

Number of words with corpus code 28   which have changed from last version to this - see lns_corp_28   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          864 `\
<br>**`range    :`** `[ 0 ] ... [ 441 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_29** (textlines, linelinkage)

Number of words with corpus code 29   which have changed from last version to this - see lns_corp_29   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           35 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           33 `\
<br>**`sum      :`** `       13 308 `\
<br>**`range    :`** `[ 0 ] ... [ 2350 ] `\
<br>**`examples :`** ` [NA], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_31** (textlines, linelinkage)

Number of words with corpus code 31   which have changed from last version to this - see lns_corp_31   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            6 `\
<br>**`sum      :`** `          852 `\
<br>**`range    :`** `[ 0 ] ... [ 387 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_32** (textlines, linelinkage)

Number of words with corpus code 32   which have changed from last version to this - see lns_corp_32   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           11 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            9 `\
<br>**`sum      :`** `        1 793 `\
<br>**`range    :`** `[ 0 ] ... [ 779 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_33** (textlines, linelinkage)

Number of words with corpus code 33   which have changed from last version to this - see lns_corp_33   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            4 `\
<br>**`sum      :`** `          482 `\
<br>**`range    :`** `[ 0 ] ... [ 244 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_34** (textlines, linelinkage)

Number of words with corpus code 34   which have changed from last version to this - see lns_corp_34   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           48 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           55 `\
<br>**`sum      :`** `        4 430 `\
<br>**`range    :`** `[ 0 ] ... [ 479 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_43** (textlines, linelinkage)

Number of words with corpus code 43   which have changed from last version to this - see lns_corp_43   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           11 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           10 `\
<br>**`sum      :`** `          573 `\
<br>**`range    :`** `[ 0 ] ... [ 171 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_45** (textlines, linelinkage)

Number of words with corpus code 45   which have changed from last version to this - see lns_corp_45   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            4 `\
<br>**`sum      :`** `        1 177 `\
<br>**`range    :`** `[ 0 ] ... [ 554 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_51** (textlines, linelinkage)

Number of words with corpus code 51   which have changed from last version to this - see lns_corp_51   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           65 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           72 `\
<br>**`sum      :`** `        7 981 `\
<br>**`range    :`** `[ 0 ] ... [ 493 ] `\
<br>**`examples :`** ` [70], [0], [0], [0], [0], [101], [0], [403], [174], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_52** (textlines, linelinkage)

Number of words with corpus code 52   which have changed from last version to this - see lns_corp_52   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           21 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           20 `\
<br>**`sum      :`** `        4 041 `\
<br>**`range    :`** `[ 0 ] ... [ 586 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_53** (textlines, linelinkage)

Number of words with corpus code 53   which have changed from last version to this - see lns_corp_53   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           85 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           95 `\
<br>**`sum      :`** `       14 976 `\
<br>**`range    :`** `[ 0 ] ... [ 674 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_54** (textlines, linelinkage)

Number of words with corpus code 54   which have changed from last version to this - see lns_corp_54   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           25 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           25 `\
<br>**`sum      :`** `        4 580 `\
<br>**`range    :`** `[ 0 ] ... [ 845 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [170], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_55** (textlines, linelinkage)

Number of words with corpus code 55   which have changed from last version to this - see lns_corp_55   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           53 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           61 `\
<br>**`sum      :`** `        6 727 `\
<br>**`range    :`** `[ 0 ] ... [ 1260 ] `\
<br>**`examples :`** ` [0], [104], [0], [0], [0], [40], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_56** (textlines, linelinkage)

Number of words with corpus code 56   which have changed from last version to this - see lns_corp_56   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           53 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           64 `\
<br>**`sum      :`** `        6 594 `\
<br>**`range    :`** `[ 0 ] ... [ 547 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [33], [0], [NA], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_66** (textlines, linelinkage)

Number of words with corpus code 66   which have changed from last version to this - see lns_corp_66   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            3 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `           82 `\
<br>**`range    :`** `[ 0 ] ... [ 41 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_67** (textlines, linelinkage)

Number of words with corpus code 67   which have changed from last version to this - see lns_corp_67   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `          184 `\
<br>**`range    :`** `[ 0 ] ... [ 107 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_68** (textlines, linelinkage)

Number of words with corpus code 68   which have changed from last version to this - see lns_corp_68   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           28 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           32 `\
<br>**`sum      :`** `        3 365 `\
<br>**`range    :`** `[ 0 ] ... [ 545 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [NA], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_71** (textlines, linelinkage)

Number of words with corpus code 71   which have changed from last version to this - see lns_corp_71   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           12 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           11 `\
<br>**`sum      :`** `        1 090 `\
<br>**`range    :`** `[ 0 ] ... [ 469 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_72** (textlines, linelinkage)

Number of words with corpus code 72   which have changed from last version to this - see lns_corp_72   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            6 `\
<br>**`sum      :`** `          194 `\
<br>**`range    :`** `[ 0 ] ... [ 58 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [26], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_73** (textlines, linelinkage)

Number of words with corpus code 73   which have changed from last version to this - see lns_corp_73   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            6 `\
<br>**`sum      :`** `          563 `\
<br>**`range    :`** `[ 0 ] ... [ 235 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_111** (textlines, linelinkage)

Number of words with corpus code 111  which have changed from last version to this - see lns_corp_111  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           30 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           31 `\
<br>**`sum      :`** `        2 112 `\
<br>**`range    :`** `[ 0 ] ... [ 319 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [21], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_112** (textlines, linelinkage)

Number of words with corpus code 112  which have changed from last version to this - see lns_corp_112  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           32 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           31 `\
<br>**`sum      :`** `        2 324 `\
<br>**`range    :`** `[ 0 ] ... [ 212 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_113** (textlines, linelinkage)

Number of words with corpus code 113  which have changed from last version to this - see lns_corp_113  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           35 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           35 `\
<br>**`sum      :`** `        3 340 `\
<br>**`range    :`** `[ 0 ] ... [ 422 ] `\
<br>**`examples :`** ` [0], [0], [0], [40], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_114** (textlines, linelinkage)

Number of words with corpus code 114  which have changed from last version to this - see lns_corp_114  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           15 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           13 `\
<br>**`sum      :`** `        1 054 `\
<br>**`range    :`** `[ 0 ] ... [ 173 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_121** (textlines, linelinkage)

Number of words with corpus code 121  which have changed from last version to this - see lns_corp_121  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           41 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           44 `\
<br>**`sum      :`** `        4 654 `\
<br>**`range    :`** `[ 0 ] ... [ 618 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [52], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_122** (textlines, linelinkage)

Number of words with corpus code 122  which have changed from last version to this - see lns_corp_122  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           37 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           37 `\
<br>**`sum      :`** `        3 270 `\
<br>**`range    :`** `[ 0 ] ... [ 693 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_123** (textlines, linelinkage)

Number of words with corpus code 123  which have changed from last version to this - see lns_corp_123  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           70 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           82 `\
<br>**`sum      :`** `        8 981 `\
<br>**`range    :`** `[ 0 ] ... [ 697 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_124** (textlines, linelinkage)

Number of words with corpus code 124  which have changed from last version to this - see lns_corp_124  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          381 `\
<br>**`range    :`** `[ 0 ] ... [ 231 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_125** (textlines, linelinkage)

Number of words with corpus code 125  which have changed from last version to this - see lns_corp_125  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           37 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           38 `\
<br>**`sum      :`** `        2 973 `\
<br>**`range    :`** `[ 0 ] ... [ 352 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_131** (textlines, linelinkage)

Number of words with corpus code 131  which have changed from last version to this - see lns_corp_131  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           20 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           20 `\
<br>**`sum      :`** `        1 480 `\
<br>**`range    :`** `[ 0 ] ... [ 271 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_132** (textlines, linelinkage)

Number of words with corpus code 132  which have changed from last version to this - see lns_corp_132  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           18 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           17 `\
<br>**`sum      :`** `        1 115 `\
<br>**`range    :`** `[ 0 ] ... [ 262 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_133** (textlines, linelinkage)

Number of words with corpus code 133  which have changed from last version to this - see lns_corp_133  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           19 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           20 `\
<br>**`sum      :`** `        1 709 `\
<br>**`range    :`** `[ 0 ] ... [ 371 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_134** (textlines, linelinkage)

Number of words with corpus code 134  which have changed from last version to this - see lns_corp_134  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           52 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           58 `\
<br>**`sum      :`** `        4 267 `\
<br>**`range    :`** `[ 0 ] ... [ 316 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [28], [135] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_141** (textlines, linelinkage)

Number of words with corpus code 141  which have changed from last version to this - see lns_corp_141  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          227 `\
<br>**`range    :`** `[ 0 ] ... [ 107 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [NA], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_142** (textlines, linelinkage)

Number of words with corpus code 142  which have changed from last version to this - see lns_corp_142  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           23 `\
<br>**`sum      :`** `        2 095 `\
<br>**`range    :`** `[ 0 ] ... [ 312 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [NA] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_143** (textlines, linelinkage)

Number of words with corpus code 143  which have changed from last version to this - see lns_corp_143  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `          186 `\
<br>**`range    :`** `[ 0 ] ... [ 137 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_144** (textlines, linelinkage)

Number of words with corpus code 144  which have changed from last version to this - see lns_corp_144  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            3 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            1 `\
<br>**`sum      :`** `           73 `\
<br>**`range    :`** `[ 0 ] ... [ 73 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_145** (textlines, linelinkage)

Number of words with corpus code 145  which have changed from last version to this - see lns_corp_145  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          913 `\
<br>**`range    :`** `[ 0 ] ... [ 629 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_241** (textlines, linelinkage)

Number of words with corpus code 241  which have changed from last version to this - see lns_corp_241  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           24 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           23 `\
<br>**`sum      :`** `        5 010 `\
<br>**`range    :`** `[ 0 ] ... [ 801 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [NA] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_242** (textlines, linelinkage)

Number of words with corpus code 242  which have changed from last version to this - see lns_corp_242  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           22 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           21 `\
<br>**`sum      :`** `        3 618 `\
<br>**`range    :`** `[ 0 ] ... [ 491 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_243** (textlines, linelinkage)

Number of words with corpus code 243  which have changed from last version to this - see lns_corp_243  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            4 `\
<br>**`sum      :`** `          160 `\
<br>**`range    :`** `[ 0 ] ... [ 70 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_244** (textlines, linelinkage)

Number of words with corpus code 244  which have changed from last version to this - see lns_corp_244  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           21 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           20 `\
<br>**`sum      :`** `        3 921 `\
<br>**`range    :`** `[ 0 ] ... [ 764 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_411** (textlines, linelinkage)

Number of words with corpus code 411  which have changed from last version to this - see lns_corp_411  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            7 `\
<br>**`sum      :`** `        1 358 `\
<br>**`range    :`** `[ 0 ] ... [ 801 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_412** (textlines, linelinkage)

Number of words with corpus code 412  which have changed from last version to this - see lns_corp_412  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           21 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           19 `\
<br>**`sum      :`** `        2 072 `\
<br>**`range    :`** `[ 0 ] ... [ 371 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [186], [0], [0], [NA], [82] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_421** (textlines, linelinkage)

Number of words with corpus code 421  which have changed from last version to this - see lns_corp_421  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `           55 `\
<br>**`range    :`** `[ 0 ] ... [ 34 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_422** (textlines, linelinkage)

Number of words with corpus code 422  which have changed from last version to this - see lns_corp_422  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `           64 `\
<br>**`range    :`** `[ 0 ] ... [ 34 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_441** (textlines, linelinkage)

Number of words with corpus code 441  which have changed from last version to this - see lns_corp_441  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `          156 `\
<br>**`range    :`** `[ 0 ] ... [ 100 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_442** (textlines, linelinkage)

Number of words with corpus code 442  which have changed from last version to this - see lns_corp_442  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `          199 `\
<br>**`range    :`** `[ 0 ] ... [ 146 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_611** (textlines, linelinkage)

Number of words with corpus code 611  which have changed from last version to this - see lns_corp_611  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           57 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           74 `\
<br>**`sum      :`** `       12 292 `\
<br>**`range    :`** `[ 0 ] ... [ 2713 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_612** (textlines, linelinkage)

Number of words with corpus code 612  which have changed from last version to this - see lns_corp_612  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           28 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           27 `\
<br>**`sum      :`** `        3 187 `\
<br>**`range    :`** `[ 0 ] ... [ 1561 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_613** (textlines, linelinkage)

Number of words with corpus code 613  which have changed from last version to this - see lns_corp_613  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           35 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           36 `\
<br>**`sum      :`** `        2 623 `\
<br>**`range    :`** `[ 0 ] ... [ 239 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_631** (textlines, linelinkage)

Number of words with corpus code 631  which have changed from last version to this - see lns_corp_631  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           13 `\
<br>**`sum      :`** `        1 305 `\
<br>**`range    :`** `[ 0 ] ... [ 516 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_632** (textlines, linelinkage)

Number of words with corpus code 632  which have changed from last version to this - see lns_corp_632  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           80 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          107 `\
<br>**`sum      :`** `        7 434 `\
<br>**`range    :`** `[ 0 ] ... [ 524 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [59], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_633** (textlines, linelinkage)

Number of words with corpus code 633  which have changed from last version to this - see lns_corp_633  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           32 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           33 `\
<br>**`sum      :`** `        1 976 `\
<br>**`range    :`** `[ 0 ] ... [ 196 ] `\
<br>**`examples :`** ` [0], [0], [0], [87], [17], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_634** (textlines, linelinkage)

Number of words with corpus code 634  which have changed from last version to this - see lns_corp_634  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           51 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           59 `\
<br>**`sum      :`** `        4 563 `\
<br>**`range    :`** `[ 0 ] ... [ 460 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [299], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_636** (textlines, linelinkage)

Number of words with corpus code 636  which have changed from last version to this - see lns_corp_636  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           30 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           36 `\
<br>**`sum      :`** `        3 334 `\
<br>**`range    :`** `[ 0 ] ... [ 388 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_637** (textlines, linelinkage)

Number of words with corpus code 637  which have changed from last version to this - see lns_corp_637  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           24 `\
<br>**`sum      :`** `        6 629 `\
<br>**`range    :`** `[ 0 ] ... [ 2303 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_638** (textlines, linelinkage)

Number of words with corpus code 638  which have changed from last version to this - see lns_corp_638  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            8 `\
<br>**`sum      :`** `          472 `\
<br>**`range    :`** `[ 0 ] ... [ 173 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_639** (textlines, linelinkage)

Number of words with corpus code 639  which have changed from last version to this - see lns_corp_639  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           84 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `          100 `\
<br>**`sum      :`** `       17 168 `\
<br>**`range    :`** `[ 0 ] ... [ 1150 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [15], [138], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_641** (textlines, linelinkage)

Number of words with corpus code 641  which have changed from last version to this - see lns_corp_641  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           20 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           20 `\
<br>**`sum      :`** `        1 970 `\
<br>**`range    :`** `[ 0 ] ... [ 332 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [73], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_642** (textlines, linelinkage)

Number of words with corpus code 642  which have changed from last version to this - see lns_corp_642  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           22 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           23 `\
<br>**`sum      :`** `        1 770 `\
<br>**`range    :`** `[ 0 ] ... [ 330 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_643** (textlines, linelinkage)

Number of words with corpus code 643  which have changed from last version to this - see lns_corp_643  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            8 `\
<br>**`sum      :`** `          513 `\
<br>**`range    :`** `[ 0 ] ... [ 137 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_651** (textlines, linelinkage)

Number of words with corpus code 651  which have changed from last version to this - see lns_corp_651  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           43 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           44 `\
<br>**`sum      :`** `        8 949 `\
<br>**`range    :`** `[ 0 ] ... [ 2061 ] `\
<br>**`examples :`** ` [162], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_652** (textlines, linelinkage)

Number of words with corpus code 652  which have changed from last version to this - see lns_corp_652  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           41 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           45 `\
<br>**`sum      :`** `        3 828 `\
<br>**`range    :`** `[ 0 ] ... [ 470 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_653** (textlines, linelinkage)

Number of words with corpus code 653  which have changed from last version to this - see lns_corp_653  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          108 `\
<br>**`range    :`** `[ 0 ] ... [ 41 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_999** (textlines, linelinkage)

Number of words with corpus code 999  which have changed from last version to this - see lns_corp_999  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_6211** (textlines, linelinkage)

Number of words with corpus code 6211 which have changed from last version to this - see lns_corp_6211 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           27 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           29 `\
<br>**`sum      :`** `        3 046 `\
<br>**`range    :`** `[ 0 ] ... [ 975 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_6212** (textlines, linelinkage)

Number of words with corpus code 6212 which have changed from last version to this - see lns_corp_6212 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           31 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           35 `\
<br>**`sum      :`** `        2 132 `\
<br>**`range    :`** `[ 0 ] ... [ 263 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_6221** (textlines, linelinkage)

Number of words with corpus code 6221 which have changed from last version to this - see lns_corp_6221 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           22 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           21 `\
<br>**`sum      :`** `          938 `\
<br>**`range    :`** `[ 0 ] ... [ 95 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [45], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_6222** (textlines, linelinkage)

Number of words with corpus code 6222 which have changed from last version to this - see lns_corp_6222 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           25 `\
<br>**`sum      :`** `        1 432 `\
<br>**`range    :`** `[ 0 ] ... [ 304 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_6351** (textlines, linelinkage)

Number of words with corpus code 6351 which have changed from last version to this - see lns_corp_6351 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            5 `\
<br>**`sum      :`** `          235 `\
<br>**`range    :`** `[ 0 ] ... [ 85 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_ins_6352** (textlines, linelinkage)

Number of words with corpus code 6352 which have changed from last version to this - see lns_corp_6352 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           19 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           17 `\
<br>**`sum      :`** `          986 `\
<br>**`range    :`** `[ 0 ] ... [ 202 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_8** (textlines, linelinkage)

Number of words with corpus code 8    which have changed from last version to this - see lns_corp_8    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           19 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           18 `\
<br>**`sum      :`** `        1 315 `\
<br>**`range    :`** `[ 0 ] ... [ 462 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_9** (textlines, linelinkage)

Number of words with corpus code 9    which have changed from last version to this - see lns_corp_9    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           11 `\
<br>**`sum      :`** `          510 `\
<br>**`range    :`** `[ 0 ] ... [ 147 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_10** (textlines, linelinkage)

Number of words with corpus code 10   which have changed from last version to this - see lns_corp_10   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           36 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           35 `\
<br>**`sum      :`** `        2 931 `\
<br>**`range    :`** `[ 0 ] ... [ 413 ] `\
<br>**`examples :`** ` [0], [0], [13], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_21** (textlines, linelinkage)

Number of words with corpus code 21   which have changed from last version to this - see lns_corp_21   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           11 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           13 `\
<br>**`sum      :`** `        1 913 `\
<br>**`range    :`** `[ 0 ] ... [ 879 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_22** (textlines, linelinkage)

Number of words with corpus code 22   which have changed from last version to this - see lns_corp_22   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           42 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           44 `\
<br>**`sum      :`** `        7 490 `\
<br>**`range    :`** `[ 0 ] ... [ 1032 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_23** (textlines, linelinkage)

Number of words with corpus code 23   which have changed from last version to this - see lns_corp_23   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           10 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            8 `\
<br>**`sum      :`** `          535 `\
<br>**`range    :`** `[ 0 ] ... [ 188 ] `\
<br>**`examples :`** ` [NA], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_25** (textlines, linelinkage)

Number of words with corpus code 25   which have changed from last version to this - see lns_corp_25   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           17 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           17 `\
<br>**`sum      :`** `        1 692 `\
<br>**`range    :`** `[ 0 ] ... [ 681 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_26** (textlines, linelinkage)

Number of words with corpus code 26   which have changed from last version to this - see lns_corp_26   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           16 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           14 `\
<br>**`sum      :`** `        1 721 `\
<br>**`range    :`** `[ 0 ] ... [ 327 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_27** (textlines, linelinkage)

Number of words with corpus code 27   which have changed from last version to this - see lns_corp_27   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            3 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            1 `\
<br>**`sum      :`** `           17 `\
<br>**`range    :`** `[ 0 ] ... [ 17 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_28** (textlines, linelinkage)

Number of words with corpus code 28   which have changed from last version to this - see lns_corp_28   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          186 `\
<br>**`range    :`** `[ 0 ] ... [ 99 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_29** (textlines, linelinkage)

Number of words with corpus code 29   which have changed from last version to this - see lns_corp_29   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           16 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           14 `\
<br>**`sum      :`** `        2 591 `\
<br>**`range    :`** `[ 0 ] ... [ 991 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_31** (textlines, linelinkage)

Number of words with corpus code 31   which have changed from last version to this - see lns_corp_31   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          132 `\
<br>**`range    :`** `[ 0 ] ... [ 64 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_32** (textlines, linelinkage)

Number of words with corpus code 32   which have changed from last version to this - see lns_corp_32   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `           77 `\
<br>**`range    :`** `[ 0 ] ... [ 40 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [NA], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_33** (textlines, linelinkage)

Number of words with corpus code 33   which have changed from last version to this - see lns_corp_33   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `          143 `\
<br>**`range    :`** `[ 0 ] ... [ 119 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_34** (textlines, linelinkage)

Number of words with corpus code 34   which have changed from last version to this - see lns_corp_34   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           17 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           18 `\
<br>**`sum      :`** `        1 162 `\
<br>**`range    :`** `[ 0 ] ... [ 242 ] `\
<br>**`examples :`** ` [0], [55], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_43** (textlines, linelinkage)

Number of words with corpus code 43   which have changed from last version to this - see lns_corp_43   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            7 `\
<br>**`sum      :`** `          282 `\
<br>**`range    :`** `[ 0 ] ... [ 63 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_45** (textlines, linelinkage)

Number of words with corpus code 45   which have changed from last version to this - see lns_corp_45   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `          227 `\
<br>**`range    :`** `[ 0 ] ... [ 203 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_51** (textlines, linelinkage)

Number of words with corpus code 51   which have changed from last version to this - see lns_corp_51   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           41 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           46 `\
<br>**`sum      :`** `        3 018 `\
<br>**`range    :`** `[ 0 ] ... [ 294 ] `\
<br>**`examples :`** ` [0], [38], [12], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_52** (textlines, linelinkage)

Number of words with corpus code 52   which have changed from last version to this - see lns_corp_52   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           15 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           13 `\
<br>**`sum      :`** `        1 143 `\
<br>**`range    :`** `[ 0 ] ... [ 267 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_53** (textlines, linelinkage)

Number of words with corpus code 53   which have changed from last version to this - see lns_corp_53   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           45 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           56 `\
<br>**`sum      :`** `        6 111 `\
<br>**`range    :`** `[ 0 ] ... [ 918 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [25], [177], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_54** (textlines, linelinkage)

Number of words with corpus code 54   which have changed from last version to this - see lns_corp_54   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           22 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           20 `\
<br>**`sum      :`** `        3 110 `\
<br>**`range    :`** `[ 0 ] ... [ 670 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_55** (textlines, linelinkage)

Number of words with corpus code 55   which have changed from last version to this - see lns_corp_55   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           24 `\
<br>**`sum      :`** `        2 539 `\
<br>**`range    :`** `[ 0 ] ... [ 485 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_56** (textlines, linelinkage)

Number of words with corpus code 56   which have changed from last version to this - see lns_corp_56   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           37 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           38 `\
<br>**`sum      :`** `        4 583 `\
<br>**`range    :`** `[ 0 ] ... [ 997 ] `\
<br>**`examples :`** ` [20], [0], [0], [0], [171], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_66** (textlines, linelinkage)

Number of words with corpus code 66   which have changed from last version to this - see lns_corp_66   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_67** (textlines, linelinkage)

Number of words with corpus code 67   which have changed from last version to this - see lns_corp_67   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_68** (textlines, linelinkage)

Number of words with corpus code 68   which have changed from last version to this - see lns_corp_68   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           27 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           26 `\
<br>**`sum      :`** `        1 749 `\
<br>**`range    :`** `[ 0 ] ... [ 232 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_71** (textlines, linelinkage)

Number of words with corpus code 71   which have changed from last version to this - see lns_corp_71   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            6 `\
<br>**`sum      :`** `          766 `\
<br>**`range    :`** `[ 0 ] ... [ 481 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_72** (textlines, linelinkage)

Number of words with corpus code 72   which have changed from last version to this - see lns_corp_72   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `           73 `\
<br>**`range    :`** `[ 0 ] ... [ 58 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [58], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_73** (textlines, linelinkage)

Number of words with corpus code 73   which have changed from last version to this - see lns_corp_73   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          324 `\
<br>**`range    :`** `[ 0 ] ... [ 207 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_111** (textlines, linelinkage)

Number of words with corpus code 111  which have changed from last version to this - see lns_corp_111  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           12 `\
<br>**`sum      :`** `          833 `\
<br>**`range    :`** `[ 0 ] ... [ 260 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [27] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_112** (textlines, linelinkage)

Number of words with corpus code 112  which have changed from last version to this - see lns_corp_112  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           12 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           16 `\
<br>**`sum      :`** `          560 `\
<br>**`range    :`** `[ 0 ] ... [ 94 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_113** (textlines, linelinkage)

Number of words with corpus code 113  which have changed from last version to this - see lns_corp_113  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           17 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           17 `\
<br>**`sum      :`** `        1 298 `\
<br>**`range    :`** `[ 0 ] ... [ 169 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_114** (textlines, linelinkage)

Number of words with corpus code 114  which have changed from last version to this - see lns_corp_114  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            5 `\
<br>**`sum      :`** `          352 `\
<br>**`range    :`** `[ 0 ] ... [ 167 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_121** (textlines, linelinkage)

Number of words with corpus code 121  which have changed from last version to this - see lns_corp_121  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           30 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           29 `\
<br>**`sum      :`** `        2 917 `\
<br>**`range    :`** `[ 0 ] ... [ 545 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [204], [0], [0], [0], [0], [29] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_122** (textlines, linelinkage)

Number of words with corpus code 122  which have changed from last version to this - see lns_corp_122  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           22 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           22 `\
<br>**`sum      :`** `        1 920 `\
<br>**`range    :`** `[ 0 ] ... [ 377 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_123** (textlines, linelinkage)

Number of words with corpus code 123  which have changed from last version to this - see lns_corp_123  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           37 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           39 `\
<br>**`sum      :`** `        3 774 `\
<br>**`range    :`** `[ 0 ] ... [ 300 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [61], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_124** (textlines, linelinkage)

Number of words with corpus code 124  which have changed from last version to this - see lns_corp_124  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `          473 `\
<br>**`range    :`** `[ 0 ] ... [ 376 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_125** (textlines, linelinkage)

Number of words with corpus code 125  which have changed from last version to this - see lns_corp_125  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           17 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           19 `\
<br>**`sum      :`** `        1 267 `\
<br>**`range    :`** `[ 0 ] ... [ 198 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_131** (textlines, linelinkage)

Number of words with corpus code 131  which have changed from last version to this - see lns_corp_131  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            6 `\
<br>**`sum      :`** `          834 `\
<br>**`range    :`** `[ 0 ] ... [ 385 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_132** (textlines, linelinkage)

Number of words with corpus code 132  which have changed from last version to this - see lns_corp_132  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           13 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           11 `\
<br>**`sum      :`** `          649 `\
<br>**`range    :`** `[ 0 ] ... [ 170 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [33], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_133** (textlines, linelinkage)

Number of words with corpus code 133  which have changed from last version to this - see lns_corp_133  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            7 `\
<br>**`sum      :`** `          454 `\
<br>**`range    :`** `[ 0 ] ... [ 229 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_134** (textlines, linelinkage)

Number of words with corpus code 134  which have changed from last version to this - see lns_corp_134  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           31 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           31 `\
<br>**`sum      :`** `        2 640 `\
<br>**`range    :`** `[ 0 ] ... [ 511 ] `\
<br>**`examples :`** ` [0], [0], [NA], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_141** (textlines, linelinkage)

Number of words with corpus code 141  which have changed from last version to this - see lns_corp_141  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            3 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            1 `\
<br>**`sum      :`** `           30 `\
<br>**`range    :`** `[ 0 ] ... [ 30 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_142** (textlines, linelinkage)

Number of words with corpus code 142  which have changed from last version to this - see lns_corp_142  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           12 `\
<br>**`sum      :`** `        1 397 `\
<br>**`range    :`** `[ 0 ] ... [ 410 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_143** (textlines, linelinkage)

Number of words with corpus code 143  which have changed from last version to this - see lns_corp_143  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          126 `\
<br>**`range    :`** `[ 0 ] ... [ 44 ] `\
<br>**`examples :`** ` [0], [0], [NA], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_144** (textlines, linelinkage)

Number of words with corpus code 144  which have changed from last version to this - see lns_corp_144  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `          106 `\
<br>**`range    :`** `[ 0 ] ... [ 84 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_145** (textlines, linelinkage)

Number of words with corpus code 145  which have changed from last version to this - see lns_corp_145  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_241** (textlines, linelinkage)

Number of words with corpus code 241  which have changed from last version to this - see lns_corp_241  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            6 `\
<br>**`sum      :`** `          868 `\
<br>**`range    :`** `[ 0 ] ... [ 324 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_242** (textlines, linelinkage)

Number of words with corpus code 242  which have changed from last version to this - see lns_corp_242  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           12 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           11 `\
<br>**`sum      :`** `          738 `\
<br>**`range    :`** `[ 0 ] ... [ 376 ] `\
<br>**`examples :`** ` [NA], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_243** (textlines, linelinkage)

Number of words with corpus code 243  which have changed from last version to this - see lns_corp_243  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            3 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            1 `\
<br>**`sum      :`** `           43 `\
<br>**`range    :`** `[ 0 ] ... [ 43 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_244** (textlines, linelinkage)

Number of words with corpus code 244  which have changed from last version to this - see lns_corp_244  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `           76 `\
<br>**`range    :`** `[ 0 ] ... [ 57 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [NA], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_411** (textlines, linelinkage)

Number of words with corpus code 411  which have changed from last version to this - see lns_corp_411  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            9 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            7 `\
<br>**`sum      :`** `          210 `\
<br>**`range    :`** `[ 0 ] ... [ 66 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_412** (textlines, linelinkage)

Number of words with corpus code 412  which have changed from last version to this - see lns_corp_412  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            4 `\
<br>**`sum      :`** `          113 `\
<br>**`range    :`** `[ 0 ] ... [ 38 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_421** (textlines, linelinkage)

Number of words with corpus code 421  which have changed from last version to this - see lns_corp_421  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            6 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            4 `\
<br>**`sum      :`** `          393 `\
<br>**`range    :`** `[ 0 ] ... [ 187 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_422** (textlines, linelinkage)

Number of words with corpus code 422  which have changed from last version to this - see lns_corp_422  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `           58 `\
<br>**`range    :`** `[ 0 ] ... [ 35 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_441** (textlines, linelinkage)

Number of words with corpus code 441  which have changed from last version to this - see lns_corp_441  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `          150 `\
<br>**`range    :`** `[ 0 ] ... [ 100 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_442** (textlines, linelinkage)

Number of words with corpus code 442  which have changed from last version to this - see lns_corp_442  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_611** (textlines, linelinkage)

Number of words with corpus code 611  which have changed from last version to this - see lns_corp_611  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           39 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           43 `\
<br>**`sum      :`** `        6 347 `\
<br>**`range    :`** `[ 0 ] ... [ 817 ] `\
<br>**`examples :`** ` [90], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_612** (textlines, linelinkage)

Number of words with corpus code 612  which have changed from last version to this - see lns_corp_612  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           18 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           18 `\
<br>**`sum      :`** `          907 `\
<br>**`range    :`** `[ 0 ] ... [ 95 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_613** (textlines, linelinkage)

Number of words with corpus code 613  which have changed from last version to this - see lns_corp_613  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           23 `\
<br>**`sum      :`** `        1 702 `\
<br>**`range    :`** `[ 0 ] ... [ 295 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_631** (textlines, linelinkage)

Number of words with corpus code 631  which have changed from last version to this - see lns_corp_631  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           11 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           10 `\
<br>**`sum      :`** `          788 `\
<br>**`range    :`** `[ 0 ] ... [ 276 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_632** (textlines, linelinkage)

Number of words with corpus code 632  which have changed from last version to this - see lns_corp_632  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           55 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           72 `\
<br>**`sum      :`** `        5 172 `\
<br>**`range    :`** `[ 0 ] ... [ 590 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [26] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_633** (textlines, linelinkage)

Number of words with corpus code 633  which have changed from last version to this - see lns_corp_633  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           18 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           19 `\
<br>**`sum      :`** `        1 412 `\
<br>**`range    :`** `[ 0 ] ... [ 647 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_634** (textlines, linelinkage)

Number of words with corpus code 634  which have changed from last version to this - see lns_corp_634  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           20 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           25 `\
<br>**`sum      :`** `        1 917 `\
<br>**`range    :`** `[ 0 ] ... [ 622 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_636** (textlines, linelinkage)

Number of words with corpus code 636  which have changed from last version to this - see lns_corp_636  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           12 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           11 `\
<br>**`sum      :`** `          845 `\
<br>**`range    :`** `[ 0 ] ... [ 219 ] `\
<br>**`examples :`** ` [0], [0], [NA], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_637** (textlines, linelinkage)

Number of words with corpus code 637  which have changed from last version to this - see lns_corp_637  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           14 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           12 `\
<br>**`sum      :`** `        1 667 `\
<br>**`range    :`** `[ 0 ] ... [ 587 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_638** (textlines, linelinkage)

Number of words with corpus code 638  which have changed from last version to this - see lns_corp_638  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          292 `\
<br>**`range    :`** `[ 0 ] ... [ 134 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_639** (textlines, linelinkage)

Number of words with corpus code 639  which have changed from last version to this - see lns_corp_639  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           39 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           39 `\
<br>**`sum      :`** `        6 246 `\
<br>**`range    :`** `[ 0 ] ... [ 840 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [732], [0], [564], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_641** (textlines, linelinkage)

Number of words with corpus code 641  which have changed from last version to this - see lns_corp_641  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            7 `\
<br>**`sum      :`** `          350 `\
<br>**`range    :`** `[ 0 ] ... [ 145 ] `\
<br>**`examples :`** ` [NA], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_642** (textlines, linelinkage)

Number of words with corpus code 642  which have changed from last version to this - see lns_corp_642  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           12 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           11 `\
<br>**`sum      :`** `          615 `\
<br>**`range    :`** `[ 0 ] ... [ 131 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_643** (textlines, linelinkage)

Number of words with corpus code 643  which have changed from last version to this - see lns_corp_643  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `           56 `\
<br>**`range    :`** `[ 0 ] ... [ 47 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_651** (textlines, linelinkage)

Number of words with corpus code 651  which have changed from last version to this - see lns_corp_651  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           20 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           19 `\
<br>**`sum      :`** `        4 413 `\
<br>**`range    :`** `[ 0 ] ... [ 1457 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_652** (textlines, linelinkage)

Number of words with corpus code 652  which have changed from last version to this - see lns_corp_652  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           23 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           25 `\
<br>**`sum      :`** `        1 738 `\
<br>**`range    :`** `[ 0 ] ... [ 640 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_653** (textlines, linelinkage)

Number of words with corpus code 653  which have changed from last version to this - see lns_corp_653  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `          102 `\
<br>**`range    :`** `[ 0 ] ... [ 76 ] `\
<br>**`examples :`** ` [0], [76], [0], [0], [NA], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_999** (textlines, linelinkage)

Number of words with corpus code 999  which have changed from last version to this - see lns_corp_999  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            4 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            2 `\
<br>**`sum      :`** `            4 `\
<br>**`range    :`** `[ 0 ] ... [ 3 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_6211** (textlines, linelinkage)

Number of words with corpus code 6211 which have changed from last version to this - see lns_corp_6211 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           16 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           14 `\
<br>**`sum      :`** `          706 `\
<br>**`range    :`** `[ 0 ] ... [ 178 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [60], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_6212** (textlines, linelinkage)

Number of words with corpus code 6212 which have changed from last version to this - see lns_corp_6212 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           19 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           19 `\
<br>**`sum      :`** `          987 `\
<br>**`range    :`** `[ 0 ] ... [ 175 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_6221** (textlines, linelinkage)

Number of words with corpus code 6221 which have changed from last version to this - see lns_corp_6221 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            7 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            5 `\
<br>**`sum      :`** `          215 `\
<br>**`range    :`** `[ 0 ] ... [ 101 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_6222** (textlines, linelinkage)

Number of words with corpus code 6222 which have changed from last version to this - see lns_corp_6222 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `           12 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `           12 `\
<br>**`sum      :`** `          615 `\
<br>**`range    :`** `[ 0 ] ... [ 328 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_6351** (textlines, linelinkage)

Number of words with corpus code 6351 which have changed from last version to this - see lns_corp_6351 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            5 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            3 `\
<br>**`sum      :`** `          138 `\
<br>**`range    :`** `[ 0 ] ... [ 79 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**wds_corp_del_6352** (textlines, linelinkage)

Number of words with corpus code 6352 which have changed from last version to this - see lns_corp_6352 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            8 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            6 `\
<br>**`sum      :`** `          210 `\
<br>**`range    :`** `[ 0 ] ... [ 67 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [67] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_8** (textlines, linelinkage)

Number of lines with corpus code 8    which have changed from last version to this - see lns_corp_8    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [NA], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_9** (textlines, linelinkage)

Number of lines with corpus code 9    which have changed from last version to this - see lns_corp_9    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_10** (textlines, linelinkage)

Number of lines with corpus code 10   which have changed from last version to this - see lns_corp_10   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_21** (textlines, linelinkage)

Number of lines with corpus code 21   which have changed from last version to this - see lns_corp_21   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_22** (textlines, linelinkage)

Number of lines with corpus code 22   which have changed from last version to this - see lns_corp_22   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_23** (textlines, linelinkage)

Number of lines with corpus code 23   which have changed from last version to this - see lns_corp_23   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [NA], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_25** (textlines, linelinkage)

Number of lines with corpus code 25   which have changed from last version to this - see lns_corp_25   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_26** (textlines, linelinkage)

Number of lines with corpus code 26   which have changed from last version to this - see lns_corp_26   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_27** (textlines, linelinkage)

Number of lines with corpus code 27   which have changed from last version to this - see lns_corp_27   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_28** (textlines, linelinkage)

Number of lines with corpus code 28   which have changed from last version to this - see lns_corp_28   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_29** (textlines, linelinkage)

Number of lines with corpus code 29   which have changed from last version to this - see lns_corp_29   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_31** (textlines, linelinkage)

Number of lines with corpus code 31   which have changed from last version to this - see lns_corp_31   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_32** (textlines, linelinkage)

Number of lines with corpus code 32   which have changed from last version to this - see lns_corp_32   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_33** (textlines, linelinkage)

Number of lines with corpus code 33   which have changed from last version to this - see lns_corp_33   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_34** (textlines, linelinkage)

Number of lines with corpus code 34   which have changed from last version to this - see lns_corp_34   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_43** (textlines, linelinkage)

Number of lines with corpus code 43   which have changed from last version to this - see lns_corp_43   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_45** (textlines, linelinkage)

Number of lines with corpus code 45   which have changed from last version to this - see lns_corp_45   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [NA], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_51** (textlines, linelinkage)

Number of lines with corpus code 51   which have changed from last version to this - see lns_corp_51   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_52** (textlines, linelinkage)

Number of lines with corpus code 52   which have changed from last version to this - see lns_corp_52   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_53** (textlines, linelinkage)

Number of lines with corpus code 53   which have changed from last version to this - see lns_corp_53   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_54** (textlines, linelinkage)

Number of lines with corpus code 54   which have changed from last version to this - see lns_corp_54   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_55** (textlines, linelinkage)

Number of lines with corpus code 55   which have changed from last version to this - see lns_corp_55   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_56** (textlines, linelinkage)

Number of lines with corpus code 56   which have changed from last version to this - see lns_corp_56   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_66** (textlines, linelinkage)

Number of lines with corpus code 66   which have changed from last version to this - see lns_corp_66   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_67** (textlines, linelinkage)

Number of lines with corpus code 67   which have changed from last version to this - see lns_corp_67   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_68** (textlines, linelinkage)

Number of lines with corpus code 68   which have changed from last version to this - see lns_corp_68   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [NA], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_71** (textlines, linelinkage)

Number of lines with corpus code 71   which have changed from last version to this - see lns_corp_71   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_72** (textlines, linelinkage)

Number of lines with corpus code 72   which have changed from last version to this - see lns_corp_72   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_73** (textlines, linelinkage)

Number of lines with corpus code 73   which have changed from last version to this - see lns_corp_73   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_111** (textlines, linelinkage)

Number of lines with corpus code 111  which have changed from last version to this - see lns_corp_111  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_112** (textlines, linelinkage)

Number of lines with corpus code 112  which have changed from last version to this - see lns_corp_112  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_113** (textlines, linelinkage)

Number of lines with corpus code 113  which have changed from last version to this - see lns_corp_113  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_114** (textlines, linelinkage)

Number of lines with corpus code 114  which have changed from last version to this - see lns_corp_114  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_121** (textlines, linelinkage)

Number of lines with corpus code 121  which have changed from last version to this - see lns_corp_121  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_122** (textlines, linelinkage)

Number of lines with corpus code 122  which have changed from last version to this - see lns_corp_122  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_123** (textlines, linelinkage)

Number of lines with corpus code 123  which have changed from last version to this - see lns_corp_123  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_124** (textlines, linelinkage)

Number of lines with corpus code 124  which have changed from last version to this - see lns_corp_124  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_125** (textlines, linelinkage)

Number of lines with corpus code 125  which have changed from last version to this - see lns_corp_125  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_131** (textlines, linelinkage)

Number of lines with corpus code 131  which have changed from last version to this - see lns_corp_131  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_132** (textlines, linelinkage)

Number of lines with corpus code 132  which have changed from last version to this - see lns_corp_132  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [NA], [0], [0], [0], [0], [0], [NA] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_133** (textlines, linelinkage)

Number of lines with corpus code 133  which have changed from last version to this - see lns_corp_133  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_134** (textlines, linelinkage)

Number of lines with corpus code 134  which have changed from last version to this - see lns_corp_134  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_141** (textlines, linelinkage)

Number of lines with corpus code 141  which have changed from last version to this - see lns_corp_141  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [NA], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_142** (textlines, linelinkage)

Number of lines with corpus code 142  which have changed from last version to this - see lns_corp_142  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_143** (textlines, linelinkage)

Number of lines with corpus code 143  which have changed from last version to this - see lns_corp_143  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_144** (textlines, linelinkage)

Number of lines with corpus code 144  which have changed from last version to this - see lns_corp_144  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_145** (textlines, linelinkage)

Number of lines with corpus code 145  which have changed from last version to this - see lns_corp_145  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_241** (textlines, linelinkage)

Number of lines with corpus code 241  which have changed from last version to this - see lns_corp_241  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [NA], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_242** (textlines, linelinkage)

Number of lines with corpus code 242  which have changed from last version to this - see lns_corp_242  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_243** (textlines, linelinkage)

Number of lines with corpus code 243  which have changed from last version to this - see lns_corp_243  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_244** (textlines, linelinkage)

Number of lines with corpus code 244  which have changed from last version to this - see lns_corp_244  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_411** (textlines, linelinkage)

Number of lines with corpus code 411  which have changed from last version to this - see lns_corp_411  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_412** (textlines, linelinkage)

Number of lines with corpus code 412  which have changed from last version to this - see lns_corp_412  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_421** (textlines, linelinkage)

Number of lines with corpus code 421  which have changed from last version to this - see lns_corp_421  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_422** (textlines, linelinkage)

Number of lines with corpus code 422  which have changed from last version to this - see lns_corp_422  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_441** (textlines, linelinkage)

Number of lines with corpus code 441  which have changed from last version to this - see lns_corp_441  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_442** (textlines, linelinkage)

Number of lines with corpus code 442  which have changed from last version to this - see lns_corp_442  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_611** (textlines, linelinkage)

Number of lines with corpus code 611  which have changed from last version to this - see lns_corp_611  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_612** (textlines, linelinkage)

Number of lines with corpus code 612  which have changed from last version to this - see lns_corp_612  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_613** (textlines, linelinkage)

Number of lines with corpus code 613  which have changed from last version to this - see lns_corp_613  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_631** (textlines, linelinkage)

Number of lines with corpus code 631  which have changed from last version to this - see lns_corp_631  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_632** (textlines, linelinkage)

Number of lines with corpus code 632  which have changed from last version to this - see lns_corp_632  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_633** (textlines, linelinkage)

Number of lines with corpus code 633  which have changed from last version to this - see lns_corp_633  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_634** (textlines, linelinkage)

Number of lines with corpus code 634  which have changed from last version to this - see lns_corp_634  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_636** (textlines, linelinkage)

Number of lines with corpus code 636  which have changed from last version to this - see lns_corp_636  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [NA], [NA], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_637** (textlines, linelinkage)

Number of lines with corpus code 637  which have changed from last version to this - see lns_corp_637  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_638** (textlines, linelinkage)

Number of lines with corpus code 638  which have changed from last version to this - see lns_corp_638  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_639** (textlines, linelinkage)

Number of lines with corpus code 639  which have changed from last version to this - see lns_corp_639  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_641** (textlines, linelinkage)

Number of lines with corpus code 641  which have changed from last version to this - see lns_corp_641  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_642** (textlines, linelinkage)

Number of lines with corpus code 642  which have changed from last version to this - see lns_corp_642  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_643** (textlines, linelinkage)

Number of lines with corpus code 643  which have changed from last version to this - see lns_corp_643  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_651** (textlines, linelinkage)

Number of lines with corpus code 651  which have changed from last version to this - see lns_corp_651  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_652** (textlines, linelinkage)

Number of lines with corpus code 652  which have changed from last version to this - see lns_corp_652  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [NA], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_653** (textlines, linelinkage)

Number of lines with corpus code 653  which have changed from last version to this - see lns_corp_653  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [NA], [0], [0], [0], [0], [0], [0], [0], [NA], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_999** (textlines, linelinkage)

Number of lines with corpus code 999  which have changed from last version to this - see lns_corp_999  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_6211** (textlines, linelinkage)

Number of lines with corpus code 6211 which have changed from last version to this - see lns_corp_6211 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_6212** (textlines, linelinkage)

Number of lines with corpus code 6212 which have changed from last version to this - see lns_corp_6212 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_6221** (textlines, linelinkage)

Number of lines with corpus code 6221 which have changed from last version to this - see lns_corp_6221 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_6222** (textlines, linelinkage)

Number of lines with corpus code 6222 which have changed from last version to this - see lns_corp_6222 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_6351** (textlines, linelinkage)

Number of lines with corpus code 6351 which have changed from last version to this - see lns_corp_6351 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_mdf_6352** (textlines, linelinkage)

Number of lines with corpus code 6352 which have changed from last version to this - see lns_corp_6352 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_8** (textlines, linelinkage)

Number of lines with corpus code 8    which have changed from last version to this - see lns_corp_8    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_9** (textlines, linelinkage)

Number of lines with corpus code 9    which have changed from last version to this - see lns_corp_9    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_10** (textlines, linelinkage)

Number of lines with corpus code 10   which have changed from last version to this - see lns_corp_10   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_21** (textlines, linelinkage)

Number of lines with corpus code 21   which have changed from last version to this - see lns_corp_21   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_22** (textlines, linelinkage)

Number of lines with corpus code 22   which have changed from last version to this - see lns_corp_22   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_23** (textlines, linelinkage)

Number of lines with corpus code 23   which have changed from last version to this - see lns_corp_23   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_25** (textlines, linelinkage)

Number of lines with corpus code 25   which have changed from last version to this - see lns_corp_25   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_26** (textlines, linelinkage)

Number of lines with corpus code 26   which have changed from last version to this - see lns_corp_26   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_27** (textlines, linelinkage)

Number of lines with corpus code 27   which have changed from last version to this - see lns_corp_27   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_28** (textlines, linelinkage)

Number of lines with corpus code 28   which have changed from last version to this - see lns_corp_28   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_29** (textlines, linelinkage)

Number of lines with corpus code 29   which have changed from last version to this - see lns_corp_29   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_31** (textlines, linelinkage)

Number of lines with corpus code 31   which have changed from last version to this - see lns_corp_31   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_32** (textlines, linelinkage)

Number of lines with corpus code 32   which have changed from last version to this - see lns_corp_32   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_33** (textlines, linelinkage)

Number of lines with corpus code 33   which have changed from last version to this - see lns_corp_33   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_34** (textlines, linelinkage)

Number of lines with corpus code 34   which have changed from last version to this - see lns_corp_34   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_43** (textlines, linelinkage)

Number of lines with corpus code 43   which have changed from last version to this - see lns_corp_43   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_45** (textlines, linelinkage)

Number of lines with corpus code 45   which have changed from last version to this - see lns_corp_45   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [NA], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_51** (textlines, linelinkage)

Number of lines with corpus code 51   which have changed from last version to this - see lns_corp_51   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_52** (textlines, linelinkage)

Number of lines with corpus code 52   which have changed from last version to this - see lns_corp_52   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_53** (textlines, linelinkage)

Number of lines with corpus code 53   which have changed from last version to this - see lns_corp_53   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_54** (textlines, linelinkage)

Number of lines with corpus code 54   which have changed from last version to this - see lns_corp_54   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_55** (textlines, linelinkage)

Number of lines with corpus code 55   which have changed from last version to this - see lns_corp_55   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [NA], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_56** (textlines, linelinkage)

Number of lines with corpus code 56   which have changed from last version to this - see lns_corp_56   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_66** (textlines, linelinkage)

Number of lines with corpus code 66   which have changed from last version to this - see lns_corp_66   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_67** (textlines, linelinkage)

Number of lines with corpus code 67   which have changed from last version to this - see lns_corp_67   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_68** (textlines, linelinkage)

Number of lines with corpus code 68   which have changed from last version to this - see lns_corp_68   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_71** (textlines, linelinkage)

Number of lines with corpus code 71   which have changed from last version to this - see lns_corp_71   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_72** (textlines, linelinkage)

Number of lines with corpus code 72   which have changed from last version to this - see lns_corp_72   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_73** (textlines, linelinkage)

Number of lines with corpus code 73   which have changed from last version to this - see lns_corp_73   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_111** (textlines, linelinkage)

Number of lines with corpus code 111  which have changed from last version to this - see lns_corp_111  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_112** (textlines, linelinkage)

Number of lines with corpus code 112  which have changed from last version to this - see lns_corp_112  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_113** (textlines, linelinkage)

Number of lines with corpus code 113  which have changed from last version to this - see lns_corp_113  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_114** (textlines, linelinkage)

Number of lines with corpus code 114  which have changed from last version to this - see lns_corp_114  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_121** (textlines, linelinkage)

Number of lines with corpus code 121  which have changed from last version to this - see lns_corp_121  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_122** (textlines, linelinkage)

Number of lines with corpus code 122  which have changed from last version to this - see lns_corp_122  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_123** (textlines, linelinkage)

Number of lines with corpus code 123  which have changed from last version to this - see lns_corp_123  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_124** (textlines, linelinkage)

Number of lines with corpus code 124  which have changed from last version to this - see lns_corp_124  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_125** (textlines, linelinkage)

Number of lines with corpus code 125  which have changed from last version to this - see lns_corp_125  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_131** (textlines, linelinkage)

Number of lines with corpus code 131  which have changed from last version to this - see lns_corp_131  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_132** (textlines, linelinkage)

Number of lines with corpus code 132  which have changed from last version to this - see lns_corp_132  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_133** (textlines, linelinkage)

Number of lines with corpus code 133  which have changed from last version to this - see lns_corp_133  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_134** (textlines, linelinkage)

Number of lines with corpus code 134  which have changed from last version to this - see lns_corp_134  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_141** (textlines, linelinkage)

Number of lines with corpus code 141  which have changed from last version to this - see lns_corp_141  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_142** (textlines, linelinkage)

Number of lines with corpus code 142  which have changed from last version to this - see lns_corp_142  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [NA], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_143** (textlines, linelinkage)

Number of lines with corpus code 143  which have changed from last version to this - see lns_corp_143  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_144** (textlines, linelinkage)

Number of lines with corpus code 144  which have changed from last version to this - see lns_corp_144  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_145** (textlines, linelinkage)

Number of lines with corpus code 145  which have changed from last version to this - see lns_corp_145  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_241** (textlines, linelinkage)

Number of lines with corpus code 241  which have changed from last version to this - see lns_corp_241  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [NA], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_242** (textlines, linelinkage)

Number of lines with corpus code 242  which have changed from last version to this - see lns_corp_242  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_243** (textlines, linelinkage)

Number of lines with corpus code 243  which have changed from last version to this - see lns_corp_243  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_244** (textlines, linelinkage)

Number of lines with corpus code 244  which have changed from last version to this - see lns_corp_244  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [NA], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_411** (textlines, linelinkage)

Number of lines with corpus code 411  which have changed from last version to this - see lns_corp_411  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_412** (textlines, linelinkage)

Number of lines with corpus code 412  which have changed from last version to this - see lns_corp_412  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_421** (textlines, linelinkage)

Number of lines with corpus code 421  which have changed from last version to this - see lns_corp_421  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [NA] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_422** (textlines, linelinkage)

Number of lines with corpus code 422  which have changed from last version to this - see lns_corp_422  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_441** (textlines, linelinkage)

Number of lines with corpus code 441  which have changed from last version to this - see lns_corp_441  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_442** (textlines, linelinkage)

Number of lines with corpus code 442  which have changed from last version to this - see lns_corp_442  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [NA], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_611** (textlines, linelinkage)

Number of lines with corpus code 611  which have changed from last version to this - see lns_corp_611  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_612** (textlines, linelinkage)

Number of lines with corpus code 612  which have changed from last version to this - see lns_corp_612  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_613** (textlines, linelinkage)

Number of lines with corpus code 613  which have changed from last version to this - see lns_corp_613  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_631** (textlines, linelinkage)

Number of lines with corpus code 631  which have changed from last version to this - see lns_corp_631  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_632** (textlines, linelinkage)

Number of lines with corpus code 632  which have changed from last version to this - see lns_corp_632  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_633** (textlines, linelinkage)

Number of lines with corpus code 633  which have changed from last version to this - see lns_corp_633  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_634** (textlines, linelinkage)

Number of lines with corpus code 634  which have changed from last version to this - see lns_corp_634  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_636** (textlines, linelinkage)

Number of lines with corpus code 636  which have changed from last version to this - see lns_corp_636  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_637** (textlines, linelinkage)

Number of lines with corpus code 637  which have changed from last version to this - see lns_corp_637  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_638** (textlines, linelinkage)

Number of lines with corpus code 638  which have changed from last version to this - see lns_corp_638  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_639** (textlines, linelinkage)

Number of lines with corpus code 639  which have changed from last version to this - see lns_corp_639  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_641** (textlines, linelinkage)

Number of lines with corpus code 641  which have changed from last version to this - see lns_corp_641  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_642** (textlines, linelinkage)

Number of lines with corpus code 642  which have changed from last version to this - see lns_corp_642  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_643** (textlines, linelinkage)

Number of lines with corpus code 643  which have changed from last version to this - see lns_corp_643  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_651** (textlines, linelinkage)

Number of lines with corpus code 651  which have changed from last version to this - see lns_corp_651  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_652** (textlines, linelinkage)

Number of lines with corpus code 652  which have changed from last version to this - see lns_corp_652  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_653** (textlines, linelinkage)

Number of lines with corpus code 653  which have changed from last version to this - see lns_corp_653  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [NA], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_999** (textlines, linelinkage)

Number of lines with corpus code 999  which have changed from last version to this - see lns_corp_999  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_6211** (textlines, linelinkage)

Number of lines with corpus code 6211 which have changed from last version to this - see lns_corp_6211 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [NA], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_6212** (textlines, linelinkage)

Number of lines with corpus code 6212 which have changed from last version to this - see lns_corp_6212 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_6221** (textlines, linelinkage)

Number of lines with corpus code 6221 which have changed from last version to this - see lns_corp_6221 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [NA], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_6222** (textlines, linelinkage)

Number of lines with corpus code 6222 which have changed from last version to this - see lns_corp_6222 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_6351** (textlines, linelinkage)

Number of lines with corpus code 6351 which have changed from last version to this - see lns_corp_6351 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_ins_6352** (textlines, linelinkage)

Number of lines with corpus code 6352 which have changed from last version to this - see lns_corp_6352 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [NA], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_8** (textlines, linelinkage)

Number of lines with corpus code 8    which have changed from last version to this - see lns_corp_8    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_9** (textlines, linelinkage)

Number of lines with corpus code 9    which have changed from last version to this - see lns_corp_9    also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_10** (textlines, linelinkage)

Number of lines with corpus code 10   which have changed from last version to this - see lns_corp_10   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_21** (textlines, linelinkage)

Number of lines with corpus code 21   which have changed from last version to this - see lns_corp_21   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_22** (textlines, linelinkage)

Number of lines with corpus code 22   which have changed from last version to this - see lns_corp_22   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_23** (textlines, linelinkage)

Number of lines with corpus code 23   which have changed from last version to this - see lns_corp_23   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_25** (textlines, linelinkage)

Number of lines with corpus code 25   which have changed from last version to this - see lns_corp_25   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_26** (textlines, linelinkage)

Number of lines with corpus code 26   which have changed from last version to this - see lns_corp_26   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_27** (textlines, linelinkage)

Number of lines with corpus code 27   which have changed from last version to this - see lns_corp_27   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_28** (textlines, linelinkage)

Number of lines with corpus code 28   which have changed from last version to this - see lns_corp_28   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_29** (textlines, linelinkage)

Number of lines with corpus code 29   which have changed from last version to this - see lns_corp_29   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_31** (textlines, linelinkage)

Number of lines with corpus code 31   which have changed from last version to this - see lns_corp_31   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_32** (textlines, linelinkage)

Number of lines with corpus code 32   which have changed from last version to this - see lns_corp_32   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_33** (textlines, linelinkage)

Number of lines with corpus code 33   which have changed from last version to this - see lns_corp_33   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_34** (textlines, linelinkage)

Number of lines with corpus code 34   which have changed from last version to this - see lns_corp_34   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_43** (textlines, linelinkage)

Number of lines with corpus code 43   which have changed from last version to this - see lns_corp_43   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_45** (textlines, linelinkage)

Number of lines with corpus code 45   which have changed from last version to this - see lns_corp_45   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_51** (textlines, linelinkage)

Number of lines with corpus code 51   which have changed from last version to this - see lns_corp_51   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_52** (textlines, linelinkage)

Number of lines with corpus code 52   which have changed from last version to this - see lns_corp_52   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_53** (textlines, linelinkage)

Number of lines with corpus code 53   which have changed from last version to this - see lns_corp_53   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_54** (textlines, linelinkage)

Number of lines with corpus code 54   which have changed from last version to this - see lns_corp_54   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_55** (textlines, linelinkage)

Number of lines with corpus code 55   which have changed from last version to this - see lns_corp_55   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_56** (textlines, linelinkage)

Number of lines with corpus code 56   which have changed from last version to this - see lns_corp_56   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_66** (textlines, linelinkage)

Number of lines with corpus code 66   which have changed from last version to this - see lns_corp_66   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_67** (textlines, linelinkage)

Number of lines with corpus code 67   which have changed from last version to this - see lns_corp_67   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_68** (textlines, linelinkage)

Number of lines with corpus code 68   which have changed from last version to this - see lns_corp_68   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_71** (textlines, linelinkage)

Number of lines with corpus code 71   which have changed from last version to this - see lns_corp_71   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_72** (textlines, linelinkage)

Number of lines with corpus code 72   which have changed from last version to this - see lns_corp_72   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [NA], [0], [0], [0], [0], [0], [NA], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_73** (textlines, linelinkage)

Number of lines with corpus code 73   which have changed from last version to this - see lns_corp_73   also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_111** (textlines, linelinkage)

Number of lines with corpus code 111  which have changed from last version to this - see lns_corp_111  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_112** (textlines, linelinkage)

Number of lines with corpus code 112  which have changed from last version to this - see lns_corp_112  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_113** (textlines, linelinkage)

Number of lines with corpus code 113  which have changed from last version to this - see lns_corp_113  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_114** (textlines, linelinkage)

Number of lines with corpus code 114  which have changed from last version to this - see lns_corp_114  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_121** (textlines, linelinkage)

Number of lines with corpus code 121  which have changed from last version to this - see lns_corp_121  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_122** (textlines, linelinkage)

Number of lines with corpus code 122  which have changed from last version to this - see lns_corp_122  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_123** (textlines, linelinkage)

Number of lines with corpus code 123  which have changed from last version to this - see lns_corp_123  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_124** (textlines, linelinkage)

Number of lines with corpus code 124  which have changed from last version to this - see lns_corp_124  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_125** (textlines, linelinkage)

Number of lines with corpus code 125  which have changed from last version to this - see lns_corp_125  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [NA] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_131** (textlines, linelinkage)

Number of lines with corpus code 131  which have changed from last version to this - see lns_corp_131  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [NA], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_132** (textlines, linelinkage)

Number of lines with corpus code 132  which have changed from last version to this - see lns_corp_132  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_133** (textlines, linelinkage)

Number of lines with corpus code 133  which have changed from last version to this - see lns_corp_133  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_134** (textlines, linelinkage)

Number of lines with corpus code 134  which have changed from last version to this - see lns_corp_134  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_141** (textlines, linelinkage)

Number of lines with corpus code 141  which have changed from last version to this - see lns_corp_141  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_142** (textlines, linelinkage)

Number of lines with corpus code 142  which have changed from last version to this - see lns_corp_142  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_143** (textlines, linelinkage)

Number of lines with corpus code 143  which have changed from last version to this - see lns_corp_143  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_144** (textlines, linelinkage)

Number of lines with corpus code 144  which have changed from last version to this - see lns_corp_144  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_145** (textlines, linelinkage)

Number of lines with corpus code 145  which have changed from last version to this - see lns_corp_145  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_241** (textlines, linelinkage)

Number of lines with corpus code 241  which have changed from last version to this - see lns_corp_241  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_242** (textlines, linelinkage)

Number of lines with corpus code 242  which have changed from last version to this - see lns_corp_242  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_243** (textlines, linelinkage)

Number of lines with corpus code 243  which have changed from last version to this - see lns_corp_243  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_244** (textlines, linelinkage)

Number of lines with corpus code 244  which have changed from last version to this - see lns_corp_244  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [NA], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_411** (textlines, linelinkage)

Number of lines with corpus code 411  which have changed from last version to this - see lns_corp_411  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_412** (textlines, linelinkage)

Number of lines with corpus code 412  which have changed from last version to this - see lns_corp_412  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [NA] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_421** (textlines, linelinkage)

Number of lines with corpus code 421  which have changed from last version to this - see lns_corp_421  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_422** (textlines, linelinkage)

Number of lines with corpus code 422  which have changed from last version to this - see lns_corp_422  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_441** (textlines, linelinkage)

Number of lines with corpus code 441  which have changed from last version to this - see lns_corp_441  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_442** (textlines, linelinkage)

Number of lines with corpus code 442  which have changed from last version to this - see lns_corp_442  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [NA], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_611** (textlines, linelinkage)

Number of lines with corpus code 611  which have changed from last version to this - see lns_corp_611  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_612** (textlines, linelinkage)

Number of lines with corpus code 612  which have changed from last version to this - see lns_corp_612  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_613** (textlines, linelinkage)

Number of lines with corpus code 613  which have changed from last version to this - see lns_corp_613  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_631** (textlines, linelinkage)

Number of lines with corpus code 631  which have changed from last version to this - see lns_corp_631  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_632** (textlines, linelinkage)

Number of lines with corpus code 632  which have changed from last version to this - see lns_corp_632  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_633** (textlines, linelinkage)

Number of lines with corpus code 633  which have changed from last version to this - see lns_corp_633  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [NA], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_634** (textlines, linelinkage)

Number of lines with corpus code 634  which have changed from last version to this - see lns_corp_634  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_636** (textlines, linelinkage)

Number of lines with corpus code 636  which have changed from last version to this - see lns_corp_636  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_637** (textlines, linelinkage)

Number of lines with corpus code 637  which have changed from last version to this - see lns_corp_637  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_638** (textlines, linelinkage)

Number of lines with corpus code 638  which have changed from last version to this - see lns_corp_638  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_639** (textlines, linelinkage)

Number of lines with corpus code 639  which have changed from last version to this - see lns_corp_639  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_641** (textlines, linelinkage)

Number of lines with corpus code 641  which have changed from last version to this - see lns_corp_641  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_642** (textlines, linelinkage)

Number of lines with corpus code 642  which have changed from last version to this - see lns_corp_642  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_643** (textlines, linelinkage)

Number of lines with corpus code 643  which have changed from last version to this - see lns_corp_643  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_651** (textlines, linelinkage)

Number of lines with corpus code 651  which have changed from last version to this - see lns_corp_651  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_652** (textlines, linelinkage)

Number of lines with corpus code 652  which have changed from last version to this - see lns_corp_652  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [NA], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_653** (textlines, linelinkage)

Number of lines with corpus code 653  which have changed from last version to this - see lns_corp_653  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_999** (textlines, linelinkage)

Number of lines with corpus code 999  which have changed from last version to this - see lns_corp_999  also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_6211** (textlines, linelinkage)

Number of lines with corpus code 6211 which have changed from last version to this - see lns_corp_6211 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_6212** (textlines, linelinkage)

Number of lines with corpus code 6212 which have changed from last version to this - see lns_corp_6212 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_6221** (textlines, linelinkage)

Number of lines with corpus code 6221 which have changed from last version to this - see lns_corp_6221 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_6222** (textlines, linelinkage)

Number of lines with corpus code 6222 which have changed from last version to this - see lns_corp_6222 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_6351** (textlines, linelinkage)

Number of lines with corpus code 6351 which have changed from last version to this - see lns_corp_6351 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>

**lns_corp_del_6352** (textlines, linelinkage)

Number of lines with corpus code 6352 which have changed from last version to this - see lns_corp_6352 also wds_mdf for more information.

**`class    :`** `      numeric `\
<br>**`unique   :`** `            2 `\
<br>**`NAs      :`** `           16 `\
<br>**`not-NA   :`** `          770 `\
<br>**`not-0-NA :`** `            0 `\
<br>**`sum      :`** `            0 `\
<br>**`range    :`** `[ 0 ] ... [ 0 ] `\
<br>**`examples :`** ` [0], [0], [0], [0], [0], [0], [0], [0], [0], [0] ... `\
<br>

<p>&nbsp;</p>








