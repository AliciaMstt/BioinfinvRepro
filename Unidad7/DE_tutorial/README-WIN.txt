###################################
#    Differential Expression      #
#            Workflow             #
#       ***   README  ***         #
#                                 #
#   (c) Ricardo Verdugo, 2011     #
#                                 #
###################################

This is a tutorial designed to demonstrate how to tests for differential expression using
microarray data. The included script performs a simple but instructive example of a
workflow for a differential expression analysis.

This tutorial is a self contained example, i.e. all necessary data is included. However,
in order to successfully run this tutorial, you need to have R V 2.13 installed, which can
be obtained from http://www.r-project.org, as well as the following R packages from
Bioconductor:

  1. org.Mm.eg.db
  2. illuminaMousev2.db
  3. preprocessCore
  4. maanova
  5. limma
  6. topGO

You can find them along with installation instructions at http://www.bioconductor.org. If
you are connected to the internet, you can install all required packages by typing this
command in R within the tutorial's directory:

    > source("install_packages.R", echo=T)
 
Once they are installed, you should be able to run the analysis by reading the
 'Tutorial_DE.R' R script from within R.
 
 There are several ways to accomplish this:
 
 * In Windows:
    1) Click "File/Change dir..."
    2) Browse to the directory containing this README and the YChrom-DE.R script
    3) Click "Source R code..." and Accept
    
 * In any system, once you are in the R command line window, type:
    > setwd('root_path') # Replace root_path for the path to the location of this README
    > source('YChrom-DE.R')

This will run a full data analysis workflow:
    1) Readin raw data
    2) Quality control
    3) Data Normalization
    4) Probe filtering
    4) Testing differential expression
    5) Exporting annotated results
    6) Produce some venn diagram plots
    7) GO enrichment testing
    
Because this is for demonstration only, the analysis is done with the first 5000 probes in
the microarray. The rest were discarded. Similarly, 200 permutations are done when testing
significance of the model although no less than 1000 permutations are recommended in real
applications.  Furthermore, a false discovery rate of 0.2 was accepted, although this
number could be seen too high in most situations. This was done to ensure that a
sufficient number of probes are always selected so that the Venn diagrams can be created.
However, feel free to experiment with these paramaters, but we recommend starting up with
the values that are given.

Take a good look at the Tutorial_DE.R script, modify it, read the help pages for the
functions that are colaled and you are not familiar with and try new parameters adding
other functions.

This example should get you started so that you can start building your own data analysis
workflows!

This tutorial is work in progress. Your feedback is appreciated. Please contact me at
ricardo.verdugo@gmail.org with comments and any problems you may encounter when following
the tutorial.

Good luck coding.

 
