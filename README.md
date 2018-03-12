# Install packages on R
	install.packages("arules")
	install.packages("arulesViz")
	install.packages("knitr")

# Run Knitr in R console
	library(knitr)
	rnw<-file.path("memoria.Rnw")
	knit(rnw)