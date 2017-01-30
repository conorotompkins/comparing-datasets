Comparing Datasets in R
-----------------------

To use this, you'll need to install:

R (<https://cran.r-project.org/>) RStudio (<https://www.rstudio.com/products/rstudio/download/>)

Use the standard installation options

Open RStudio.

The top left area is the "Source" panel. This is where you enter and edit code.

The bottom left area is the "Console" panel. This is where the output from your code goes.

The top right area is the "Environment/History" panel. This is where you can see your data objects.

The bottom right area is the "Files/Plots/etc." panel. We won't be using this for now, but that's where your graphs and help queries show up.

In RStudio, enter this code in the Source panel. Select the code and hit CTRL+Enter to run the code and install the package we'll need for this tutorial

``` r
install.packages("tidyverse")
```

Now load that package into R for this session

``` r
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

Create a folder somewhere called "datasets"

Download the roster\_1516.csv and roster\_1617 files to that folder (from <https://github.com/conorotompkins/comparing-datasets>)

Set your working directory to that folder:

Top menu bar -&gt; Session -&gt; Set Working Directory -&gt; Choose Directory

That tells R where to look for the files, and where to save any files you create in R

Confirm this using

``` r
getwd()
```

    ## [1] "C:/Users/conor/githubfolder/comparing-datasets"

That's my working directory. Yours should be whatever your new folder is.

Read the CSVs into R

``` r
roster_1516 <- read.csv("roster_1516.csv") #This read the the CSV into R and creates a dataframe called "roster_1516"
roster_1617 <- read.csv("roster_1617.csv")
```

Then run this to confirm R has them.

``` r
ls()
```

    ## [1] "roster_1516" "roster_1617"

This lists all the data objects in your environment

Also check the Environment panel

The format of data in R is very important

If the class is not right, your code won't work

First, check the classes of the columns of roster\_1516

``` r
str(roster_1516)
```

    ## 'data.frame':    39 obs. of  11 variables:
    ##  $ No.       : int  45 19 13 2 28 87 7 6 8 9 ...
    ##  $ Player    : Factor w/ 39 levels "Adam Clendening",..: 19 2 27 1 17 36 25 39 5 30 ...
    ##  $ Flag      : Factor w/ 8 levels "ca","cz","de",..: 1 8 8 8 8 1 8 1 8 1 ...
    ##  $ Pos       : Factor w/ 5 levels "C","D","G","LW",..: 5 5 1 2 2 1 1 2 2 5 ...
    ##  $ Age       : int  23 24 27 23 26 28 39 32 24 36 ...
    ##  $ Ht        : Factor w/ 10 levels "5-10","5-11",..: 1 7 6 5 6 2 6 2 9 6 ...
    ##  $ Wt        : int  176 195 196 190 219 200 200 195 207 205 ...
    ##  $ S.C       : Factor w/ 4 levels "-/-","-/L","L/-",..: 4 4 3 4 3 3 3 3 3 3 ...
    ##  $ Exp       : Factor w/ 14 levels "1","10","11",..: 14 7 10 1 9 2 5 3 6 4 ...
    ##  $ Birth.Date: Factor w/ 39 levels "April 20, 1988",..: 34 30 1 33 12 7 29 35 38 4 ...
    ##  $ Summary   : Factor w/ 35 levels "0 G, 0 A, 0 P",..: 1 31 35 2 3 22 13 30 4 17 ...

What does str() do?

``` r
?str
```

Type "?" in front of an R command (without any () at the end) to get help

Then look at the bottom right panel

The Player column (roster\_1516$Player) is a factor (fct). It needs to be a character (chr) so we can work with it

``` r
roster_1516$Player <- as.character(roster_1516$Player)
```

Now check if R thinks roster\_1516$Player is a character class column

``` r
is.character(roster_1516$Player)
```

    ## [1] TRUE

Now, check the classes of the columns of roster\_1617

``` r
str(roster_1617)
```

    ## 'data.frame':    29 obs. of  12 variables:
    ##  $ No.       : int  13 28 1 87 7 6 8 16 29 24 ...
    ##  $ Player    : Factor w/ 29 levels "Brian Dumoulin",..: 20 12 19 25 17 29 1 10 16 3 ...
    ##  $ Flag      : Factor w/ 6 levels "ca","de","fi",..: 6 6 6 1 6 1 6 1 1 1 ...
    ##  $ Pos       : Factor w/ 5 levels "C","D","G","LW",..: 1 2 3 1 1 2 2 1 3 2 ...
    ##  $ Age       : int  28 27 26 29 40 33 25 31 32 26 ...
    ##  $ Ht        : Factor w/ 9 levels "5-11","5-8","5-9",..: 5 5 6 1 5 1 8 8 6 5 ...
    ##  $ Wt        : int  196 219 197 200 200 195 207 212 180 210 ...
    ##  $ S.C       : Factor w/ 4 levels "-/-","-/L","L/-",..: 3 3 1 3 3 3 3 4 2 3 ...
    ##  $ Exp       : Factor w/ 13 levels "1","10","11",..: 11 10 1 3 5 4 7 3 4 6 ...
    ##  $ Birth.Date: Factor w/ 29 levels "April 20, 1988",..: 1 8 4 7 21 25 28 29 22 16 ...
    ##  $ Summary   : Factor w/ 27 levels "0-0-0, 0.00 GAA",..: 25 17 1 16 27 18 5 24 10 4 ...
    ##  $ Salary    : Factor w/ 22 levels "$1,000,000","$1,400,000",..: 5 6 22 3 1 7 19 4 12 13 ...

Do the same for roster\_1617

``` r
roster_1617$Player <- as.character(roster_1617$Player)
is.character(roster_1617$Player)
```

    ## [1] TRUE

Which players from 1516 are in the roster for 1617?

``` r
roster_1516[which(roster_1516$Player %in% roster_1617$Player), ]
```

    ##    No.            Player Flag Pos Age   Ht  Wt S.C Exp         Birth.Date
    ## 3   13       Nick Bonino   us   C  27  6-1 196 L/-   6     April 20, 1988
    ## 5   28          Ian Cole   us   D  26  6-1 219 L/-   5  February 21, 1989
    ## 6   87 Sidney Crosby (C)   ca   C  28 5-11 200 L/-  10     August 7, 1987
    ## 7    7       Matt Cullen   us   C  39  6-1 200 L/-  17   November 2, 1976
    ## 8    6      Trevor Daley   ca   D  32 5-11 195 L/-  11    October 9, 1983
    ## 9    8    Brian Dumoulin   us   D  24  6-4 207 L/-   2  September 6, 1991
    ## 12  16         Eric Fehr   ca   C  30  6-4 212 R/-  10  September 7, 1985
    ## 13  29 Marc-Andre Fleury   ca   G  31  6-2 180 -/L  11  November 28, 1984
    ## 14  62      Carl Hagelin   se  LW  27 5-11 186 L/-   4    August 23, 1988
    ## 15  72  Patric Hornqvist   se  RW  29 5-11 189 R/-   7    January 1, 1987
    ## 16  81       Phil Kessel   us  RW  28  6-0 202 R/-   9    October 2, 1987
    ## 17  34     Tom Kuhnhackl   de  RW  24  6-2 196 L/-   R   January 21, 1992
    ## 18  14      Chris Kunitz   ca  LW  36  6-0 195 L/-  11 September 26, 1979
    ## 19  58       Kris Letang   ca   D  28  6-0 201 R/-   9     April 24, 1987
    ## 21   3       Olli Maatta   fi   D  21  6-2 206 L/-   2    August 22, 1994
    ## 22  71     Evgeni Malkin   su   C  29  6-3 195 L/-   9      July 31, 1986
    ## 28  51   Derrick Pouliot   ca   D  22  6-0 208 L/-   1   January 16, 1994
    ## 29  17        Bryan Rust   us  RW  23 5-11 192 R/-   1       May 11, 1992
    ## 30   4    Justin Schultz   ca   D  25  6-2 193 R/-   3       July 6, 1990
    ## 32  47       Tom Sestito   us  LW  28  6-5 228 L/-   7 September 28, 1987
    ## 33  43      Conor Sheary   us  LW  23  5-8 175 L/-   R       June 8, 1992
    ## 37   5   David Warsofsky   us   D  25  5-9 170 L/-   2       May 30, 1990
    ## 38  23      Scott Wilson   ca  LW  23 5-11 183 L/-   1     April 24, 1992
    ##              Summary
    ## 3    9 G, 20 A, 29 P
    ## 5    0 G, 12 A, 12 P
    ## 6   36 G, 49 A, 85 P
    ## 7   16 G, 16 A, 32 P
    ## 8    6 G, 16 A, 22 P
    ## 9    0 G, 16 A, 16 P
    ## 12    8 G, 6 A, 14 P
    ## 13 35-17-6, 2.29 GAA
    ## 14  10 G, 17 A, 27 P
    ## 15  22 G, 29 A, 51 P
    ## 16  26 G, 33 A, 59 P
    ## 17   5 G, 10 A, 15 P
    ## 18  17 G, 23 A, 40 P
    ## 19  16 G, 51 A, 67 P
    ## 21   6 G, 13 A, 19 P
    ## 22  27 G, 31 A, 58 P
    ## 28     0 G, 7 A, 7 P
    ## 29    4 G, 7 A, 11 P
    ## 30     1 G, 7 A, 8 P
    ## 32     0 G, 1 A, 1 P
    ## 33    7 G, 3 A, 10 P
    ## 37     1 G, 0 A, 1 P
    ## 38     5 G, 1 A, 6 P

Which players from 1516 are NOT (!) in the roster for 1617?

``` r
roster_1516[which(!(roster_1516$Player %in% roster_1617$Player)), ]
```

    ##    No.           Player Flag Pos Age   Ht  Wt S.C Exp        Birth.Date
    ## 1   45   Josh Archibald   ca  RW  23 5-10 176 R/-   R   October 6, 1992
    ## 2   19     Beau Bennett   us  RW  24  6-2 195 R/-   3 November 27, 1991
    ## 4    2  Adam Clendening   us   D  23  6-0 190 R/-   1  October 26, 1992
    ## 10   9    Pascal Dupuis   ca  RW  36  6-1 205 L/-  14     April 7, 1979
    ## 11  24    Bobby Farnham   us  RW  27 5-10 190 L/-   1  January 21, 1989
    ## 20  12      Ben Lovejoy   us   D  31  6-1 206 R/-   7 February 20, 1984
    ## 23  22 Kael Mouillierat   ca  LW  28  6-0 188 L/-   1  December 9, 1987
    ## 24  30      Matt Murray   ca   G  21  6-4 178 -/-   R      May 25, 1994
    ## 25  57     David Perron   ca  LW  27  6-0 200 R/-   8      May 28, 1988
    ## 26  61 Sergei Plotnikov   su  LW  25  6-2 202 L/-   R      June 3, 1990
    ## 27  11     Kevin Porter   us   C  29 5-11 191 L/-   6    March 12, 1986
    ## 31   4      Rob Scuderi   us   D  37  6-1 212 L/-  11 December 30, 1978
    ## 34  49    Dominik Simon   cz   C  21 5-11 176 L/-   R    August 8, 1994
    ## 35  41    Daniel Sprong   nl  RW  18  6-0 180 R/-   R    March 17, 1997
    ## 36  40  Oskar Sundqvist   se   C  21  6-3 209 R/-   R    March 23, 1994
    ## 39  37     Jeff Zatkoff   us   G  28  6-2 179 -/-   2      June 9, 1987
    ##            Summary
    ## 1    0 G, 0 A, 0 P
    ## 2   6 G, 6 A, 12 P
    ## 4    0 G, 1 A, 1 P
    ## 10   2 G, 2 A, 4 P
    ## 11   0 G, 0 A, 0 P
    ## 20  4 G, 6 A, 10 P
    ## 23   0 G, 0 A, 0 P
    ## 24 9-2-1, 2.00 GAA
    ## 25 4 G, 12 A, 16 P
    ## 26   0 G, 2 A, 2 P
    ## 27   0 G, 3 A, 3 P
    ## 31   0 G, 4 A, 4 P
    ## 34   0 G, 1 A, 1 P
    ## 35   2 G, 0 A, 2 P
    ## 36   1 G, 3 A, 4 P
    ## 39 4-7-1, 2.79 GAA

But what about Matt Murray?

"grep" searches the Player column for a string containing "Murray"

``` r
roster_1516[grep("Murray", roster_1516$Player), ]
```

    ##    No.      Player Flag Pos Age  Ht  Wt S.C Exp   Birth.Date
    ## 24  30 Matt Murray   ca   G  21 6-4 178 -/-   R May 25, 1994
    ##            Summary
    ## 24 9-2-1, 2.00 GAA

``` r
roster_1617[grep("Murray", roster_1617$Player), ]
```

    ##    No.         Player Flag Pos Age  Ht  Wt S.C Exp   Birth.Date
    ## 20  30 Matthew Murray   ca   G  22 6-4 178 -/-   1 May 25, 1994
    ##             Summary   Salary
    ## 20 17-6-1, 2.42 GAA $575,000

That's because

``` r
"Matt Murray" == "Matthew Murray"
```

    ## [1] FALSE

Let's add add a "check"" column to roster\_1516

``` r
roster_1516 <- roster_1516 %>% #Make changes to roster_1516 and assign it back to roster_1516
  mutate(check = Player %in% roster_1617$Player) #Create a new column "check" that checks if the rows in Player column from roster_1516 match the rows in roster_1617
```

View this dataframe

``` r
View(roster_1516)
```

R is case-sensetive. view() will not work

Now create a new dataframe with just the matches

``` r
new_dataframe <- roster_1516 %>% #Make changes to roster_1516 and assign it to a new object, new_dataframe
  filter(check == TRUE) #Filter only the rows where the check column is TRUE
```

You should have a new object "new\_dataframe" in your environment

``` r
ls()
```

    ## [1] "new_dataframe" "roster_1516"   "roster_1617"

View the first 10 rows of new\_dataframe

``` r
head(new_dataframe)
```

    ##   No.            Player Flag Pos Age   Ht  Wt S.C Exp        Birth.Date
    ## 1  13       Nick Bonino   us   C  27  6-1 196 L/-   6    April 20, 1988
    ## 2  28          Ian Cole   us   D  26  6-1 219 L/-   5 February 21, 1989
    ## 3  87 Sidney Crosby (C)   ca   C  28 5-11 200 L/-  10    August 7, 1987
    ## 4   7       Matt Cullen   us   C  39  6-1 200 L/-  17  November 2, 1976
    ## 5   6      Trevor Daley   ca   D  32 5-11 195 L/-  11   October 9, 1983
    ## 6   8    Brian Dumoulin   us   D  24  6-4 207 L/-   2 September 6, 1991
    ##            Summary check
    ## 1  9 G, 20 A, 29 P  TRUE
    ## 2  0 G, 12 A, 12 P  TRUE
    ## 3 36 G, 49 A, 85 P  TRUE
    ## 4 16 G, 16 A, 32 P  TRUE
    ## 5  6 G, 16 A, 22 P  TRUE
    ## 6  0 G, 16 A, 16 P  TRUE

Save new\_dataframe as a a new CSV in your working directory

``` r
write.csv(new_dataframe, "new_dataframe.csv")
```
