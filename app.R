# This app demonstrates some of the functionality of this package.
# It will be updated as part of #49 to show more use cases.

# See ?shiny::loadSupport
options(shiny.autoload.r = FALSE)

pkgload::load_all(
  export_all = FALSE,
  helpers = FALSE,
  attach_testthat = FALSE,
  quiet = TRUE
)

# A simple-ish UI that demonstrates cookies functionality.
ui <- shiny::fluidPage(
  title = "cookies package demo",
  shiny::fluidRow(
    shiny::column(
      4,
      shiny::textInput(
        "user_name",
        "What is your name?"
      )
    ),

  ),
  shiny::fluidRow(
    shiny::column(
      4,
      shiny::actionButton(
        "save_cookie",
        "Save Cookie"
      ),
      shiny::actionButton(
        "delete_cookie",
        "Delete Cookie"
      )
    )
  ),
  shiny::fluidRow(
    shiny::column(
      4,
      shiny::br(),
      shiny::textOutput("greeting")
    )
  ),
  shiny::fluidRow(
    shiny::column(
      4,
      shiny::textOutput("cookie_value")
    )
  )
)

# {cookies} makes it easy to add the necessary JavaScript.
ui <- add_cookie_handlers(ui)

server <- function(input, output, session) {
  shiny::observe(
    {
      shiny::req(get_cookie("cookies_demo_name"))
      shiny::updateTextInput(
        session,
        inputId = "user_name",
        value = get_cookie("cookies_demo_name")
      )
    }
  )

  shiny::observeEvent(
    input$save_cookie,
    {
      message("Saving cookie.")
      set_cookie("cookies_demo_name", input$user_name)
    }
  )

  shiny::observeEvent(
    input$delete_cookie,
    {
      message("Deleting cookie.")
      remove_cookie("cookies_demo_name")
    }
  )

  output$greeting <- shiny::renderText({
    shiny::req(input$user_name)
    glue::glue("Hello, {input$user_name}!")
  })
  output$cookie_value <- shiny::renderText({
    if (is.null(get_cookie("cookies_demo_name"))) {
      "The cookie is not set."
    } else {
      glue::glue(
        "The cookie is set to {get_cookie('cookies_demo_name')}.",
        "Reload the page to see that it's retained between sessions."
      )
    }
  })
}

shiny::shinyApp(
  ui = ui,
  server = server
)
