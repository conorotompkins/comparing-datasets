Comparing Datasets in R
-----------------------

To use this, you'll need to install R (<https://cran.r-project.org/>) and RStudio (<https://www.rstudio.com/products/rstudio/download/>) Use the standard installation options

Open RStudio.

The top left area is the "Source" panel. This is where you enter and edit code. THe bottom left area is the "Console" panel. This is where the output from your code goes. The top right area is the "Environment/History" panel. This is where you can see your data objects The bottom right area is the "Files/Plots/etc." panel. We won't be using this for now, but that's where your graphs and help queries show up.

In R, enter this code in the Source panel. Select the code and hit CTRL+Enter to run the code and install the package we'll need for this tutorial

``` r
install.packages("tidyverse")
```

Create a folder somewhere called "datasets" Download the roster\_1516.csv and roster\_1617 files to that folder

Set your working directory to that folder

Top menu bar -&gt; Session -&gt; Set Working Directory -&gt; Choose Directory

That tells R where to look for the files, and where to save any files you create in R Confirm this using

``` r
getwd()
```

    ## [1] "C:/Users/conor/githubfolder/comparing-datasets"

Read the CSVs into R

``` r
roster_1516 <- read.csv("roster_1516.csv")
roster_1617 <- read.csv("roster_1617.csv")
```

Then run this to confirm R has them.Also check the Environment panel.

``` r
ls()
```

    ## [1] "roster_1516" "roster_1617"

This lists all the data objects in your environment

THe format of data in R is very important First, check the classes of the columns of roster\_1516

``` r
str(roster_1516) #roster_1$Player is a factor (fct). It needs to be a character (chr)
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

``` r
roster_1516$Player <- as.character(roster_1516$Player)
is.character(roster_1516$Player)
```

    ## [1] TRUE

Check classes of roster\_2
==========================

str(roster\_1617)\#roster\_2*P**l**a**y**e**r**i**s**a**f**a**c**t**o**r*(*f**c**t*).*I**t**n**e**e**d**s**t**o**b**e**a**c**h**a**r**a**c**t**e**r*(*c**h**r*)*r**o**s**t**e**r*<sub>1617</sub>Player &lt;- as.character(roster\_1617*P**l**a**y**e**r*)*i**s*.*c**h**a**r**a**c**t**e**r*(*r**o**s**t**e**r*<sub>1617</sub>Player)

Which players from 1516 are in the roster for 1617?
===================================================

roster\_1516\[which(roster\_1516*P**l**a**y**e**r*Player), \]

Which players from 1516 are NOT (!) in the roster for 1617?
===========================================================

roster\_1516\[which(!(roster\_1516*P**l**a**y**e**r*Player)), \]

But what about Matt Murray?
===========================

roster\_1516\[grep("Murray", roster\_1516$Player), \] roster\_1617\[grep("Murray", roster\_1617$Player), \]

"Matt Murray" == "Matthew Murray"

Adding a check column to a dataframe
====================================

roster\_1516 &lt;- roster\_1516 %&gt;% \#Make changes to roster\_1516 and assign it back to roster\_1516 mutate(check = Player %in% roster\_1617$Player) \#Create a new column that checks if the rows in Player column from roster\_1516 match the rows in roster\_1617

Create a new dataframe with just the matches
============================================

new\_dataframe &lt;- roster\_1516 %&gt;% \#Make changes to roster\_1516 and assign it to a new object, new\_dataframe filter(check == TRUE) \#Filter only the rows where the check column is TRUE

View the first 10 rows of new\_dataframe
========================================

head(new\_dataframe)

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
