# Shiny_BaDaAn
A shiny app which uses the BaDaAn package to plot some data from kolada


library(shiny)

devtools::install_github('wountoto/Lab5_AdvR',subdir = 'BaDaAn')

library(BaDaAn)


# Easiest way is to use runGitHub
runGitHub("Shiny_BaDaAn", "rstudio", ref="main")

# Run a tar or zip file directly
runUrl("https://github.com/Johhed15/Shiny_BaDaAn/archive/master.tar.gz")
runUrl("https://github.com/Johhed15/Shiny_BaDaAn/archive/master.zip"
