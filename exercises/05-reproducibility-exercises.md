Reproducibility Exercises
================

Answers to this assignment will be provided as a separate R Markdown file. Your goal is to create an R Markdown file as similar as possible to the solution .Rmd file.

------------------------------------------------------------------------

**Question 1**: Create a new R Markdown document with *File* &gt; *New File* &gt; *R Markdown*... Before making any changes click the button that says "Knit"" with a little ball of yarn next to it. Verify that the output file is generated.

**Question 2**: Perform the following modifications:

1.  In the first code block, or "chunk", load the tidyverse package
2.  Change the first heading from `## R Markdown` to `## cars Summary`
3.  Copy and paste the description of the `cars` dataset. You can get the description by running `?cars`
4.  Bold the phrase "data were recorded in the 1920s"

**Question 3**: Perform the following modifications:

1.  Change the second heading from `## Including Plots` to `## Speed/Distance Plot`
2.  Change the code chunk to create a ggplot scatterplot of the `cars` dataset showing the relationship between `speed` by `dist` (stopping distance)
3.  Update the description underneath the heading
4.  Update the code chunk name to more accurately reflect its content

**Question 4**: Create a new code chunk and inside place the code `warning("Testing warning suppression")`. This code will create a warning message, but update the chunk options to suppress the warning message and code echo, so there's no trace of this code in your output. You can review how to set chunk options in [27.4.2](http://r4ds.had.co.nz/r-markdown.html#chunk-options).

**Question 5**: Add the `toc` option to your output so a table of contents precedes your report. You can review how to set output options in [29.2](http://r4ds.had.co.nz/r-markdown-formats.html#output-options).
