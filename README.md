# Shiny_BaDaAn
A shiny app which uses the BaDaAn package to plot some data from kolada


library(shiny)

devtools::install_github('wountoto/Lab5_AdvR',subdir = 'BaDaAn')

library(BaDaAn)


# Easiest way to run the app
runGitHub("Johhed15/Shiny_BaDaAn", "rstudio", ref="main")

