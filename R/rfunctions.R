#' Runs the PTMoreR Shiny web application.
#' @export
PTMoreR_app <- function() {
  shiny::runApp(system.file('PTMoreRapp', package='PTMoreR'),
                host=getOption("0.0.0.0"), port =getOption("8989"))
}
