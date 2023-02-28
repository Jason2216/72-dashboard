Mapbox_Token= 'pk.eyJ1IjoieWFzaGphaXN3YWwxMSIsImEiOiJja2dnOGN1anowdWh2MzRrZnQ3Z3l5bnNjIn0.gcxg2bwedSPboiuyWQzv5Q'
Sys.setenv("MAPBOX_TOKEN" = Mapbox_Token)

library(shiny)
library(shinydashboard)
library(plotly)
library(dplyr)
library(ggplot2)
library(DT)
library(readxl)
library(shinyjs)
library(sodium)
library(shinyWidgets)
library(magrittr)
library(maps)
library(tidyr)
library(data.table)
library(readr)
library(reshape2)

df1<-read.csv("Film fb.csv")
df1<- as.data.frame(df1)
df2<-read.csv("Film Insta.csv")
df2<- as.data.frame(df2)
df3<-read.csv("Media.csv")
df3<- as.data.frame(df3)
df4<-read.csv("Cannes.csv")
df4<- as.data.frame(df4)
df5<-read.csv("Health fb.csv")
df5<- as.data.frame(df5)
df6<-read.csv("Health Insta.csv")
df6<- as.data.frame(df6)
df7<-read_excel("followers72Dragons.xlsx")
df8<- read_excel("Followers_target_cannes_2022.xlsx")
df8<- as.data.frame(df8)
df9<- read_excel("Commentary.xlsx")
df9<- as.data.frame(df9)
df10<- read_excel("Instagram_post_72.dragons.health_2022-05-25_13_36_44.xlsx")
df11<- read_excel("Instagram_post_72.dragons_2022-05-25_13_36_44.xlsx")
df12<- read_excel("72dragonsmediaarticle20_05.xlsx")
df12<- as.data.frame(df12)
df13<- read_excel("72dragonsmediavideo20_05.xlsx")
df13<- as.data.frame(df13)
df14<- read.csv("Clean_Buyers_New.csv")
df14<- as.data.frame(df14)
df15<- read.csv("Buyers.csv")
df15<- as.data.frame(df15)

b64 <- base64enc::dataURI(file="b64.png", mime="image/png")

pen1 <-png::readPNG("H1.png")
pen2 <-png::readPNG("H2.png")
pen3 <- png::readPNG("H3.png")
pen4 <- png::readPNG("H4.png")
pen5 <- png::readPNG("H5.png")
pen6 <-png::readPNG("T1.png")
pen7 <-png::readPNG("T2.png")
pen8 <- png::readPNG("T3.png")
pen9 <- png::readPNG("T4.png")
pen10 <- png::readPNG("T5.png")


credentials = data.frame(
  username_id = c("myuser", "myuser1","myuser2","myuser3","myuser4","myuser6","myuser7","myuser8","myuser9"),
  passod   = sapply(c("mypass", "mypass1","mypass2","mypass3","mypass4","mypass5","mypass6","mypass7","mypass8"),password_store),
  permission  = c("advanced","Shenzhen","Art Galleries","Art Schools","Art Museums","Interior Designers","Artists","Designers","Collectors"), 
  stringsAsFactors = F
)



ui = fluidPage(tags$head(tags$style(HTML('body { font-family: "Robo to";background-image: linear-gradient(to bottom right, #000000, #96031a); } '))),
               tags$style(HTML("
                    .container-fluid {
    padding: 0 !important;
}

.navbar-brand {
    margin: 0 10px !important; 
}

[role='main'] {
    width: 100% !important;
    text-align: center;
}

.row>div {
    text-align: center !important;
    letter-spacing: 2px;
}

.shiny-split-layout {
    position: relative;
    left: 0px;
    display: grid;
    justify-items: center;
}
.first-row {
    grid-template-columns: 50% 50%;
}
.forth-row {
    grid-template-columns: 49% 2% 49%;
}
.second-row {
    grid-template-columns: 25% 25% 50%;
}

.third-row {
    grid-template-columns: 50% 50%;
}
.fifth-row {
    grid-template-columns: 100%;
}
}
.sixth-row {
    grid-template-columns: 100%;
}

.shiny-split-layout>div {
    max-width: 100%;
}

.shiny-split-layout>div>div>div>div {
    margin: auto !important;
}

                    .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_info, .dataTables_wrapper .dataTables_processing,.dataTables_wrapper .dataTables_paginate .paginate_button, .dataTables_wrapper .dataTables_paginate .paginate_button.disabled {
            color: #AD9440 !important;
                    }
### ADD THIS HERE ###
                    .dataTables_wrapper .dataTables_paginate .paginate_button{box-sizing:border-box;display:inline-block;min-width:1.5em;padding:0.5em 1em;margin-left:2px;text-align:center;text-decoration:none !important;cursor:pointer;*cursor:hand;color:#AD9440 !important;border:1px solid transparent;border-radius:2px}

###To change text and background color of the `Select` box ###
                    .dataTables_length select {
                           color: #AD9440;
                           background-color: #96031a
                           }

###To change text and background color of the `Search` box ###
                    .dataTables_filter input {
                            color: #AD9440;
                            background-color: #96031a
                           }

                    thead {
                    color: #AD9440;
                    }

                     tbody {
                    color: #AD9440;
                    }

                   "


               )),
               tags$head(tags$style(HTML(".nav a:hover{background-color:#AD9440;}
                                         .navbar-default{background-image: linear-gradient(to bottom right, #000000, #96031a) !important; "))),
               tags$head(tags$style(HTML("
               .js-plotly-plot {
    margin-bottom: 10px !important;
}
.container-fluid {
    padding: 0 !important;
}

.navbar-brand {
    margin: 0 10px !important; 
}

[role='main'] {
    width: 100% !important;
    text-align: center;
}

.row>div {
    text-align: center !important;
    letter-spacing: 2px;
}

.shiny-split-layout.first-row {
    position: relative;
    left: 0px;
    display: grid;
    grid-template-columns: calc(100% / 3) calc(100% / 3) calc(100% / 3);
    justify-items: center;
}

.shiny-split-layout>div {
    max-width: 100%;
}
}")),
                         uiOutput("nav1")                         
                         )
)

               
               
server<- function(input,output,session){
 
 
 perm<- reactive({
   a<- credentials[,"permission"][which(credentials$username_id==input$userName)]
 })
 
 login = FALSE
 USER <- reactiveValues(login = login)
 
 output$uiLogin<- renderUI({
   if (USER$login==FALSE){
     wellPanel(
       style="position:fixed;margin-left:32vw;background-color: #96031A;color:#AD9440; border: #482b5d;",
       tags$h2("LOG IN", class = "text-center", style = "padding-top: 0;color:#AD9440; font-weight:600;"),
       textInput("userName", placeholder="Username", label = tagList(icon("user"), shiny::HTML("<p><span style='color: #AD9440'> Username </span></p>"))),
       passwordInput("passwd", placeholder="Password", label = tagList(icon("unlock-alt"), shiny::HTML("<p><span style='color: #AD9440'> Password </span></p>"))),
       br(),
       div(
         style = "text-align: center;",
         actionButton("login", "SIGN IN", style = "color: #AD9440; background-color:#000000;padding: 10px 15px; width: 150px; cursor: pointer;font-size: 18px; font-weight: 600;"),
         shinyjs::useShinyjs(),
         shinyjs::hidden(
           div(id = "nomatch",
               tags$p("Oops! Incorrect username or password!",
                      style = "color: red; font-weight: 600; padding-top: 5px;font-size:16px;", 
                      class = "text-center"))),
         br(),
         br(),
         tags$code("Username: myuser  Password: mypass"),
         br(),
         tags$code("Username: myuser1  Password: mypass1")))
   }
 })
 
 observe({ 
   if (USER$login == FALSE) {
     if (!is.null(input$login)) {
       if (input$login > 0) {
         Username <- isolate(input$userName)
         Password <- isolate(input$passwd)
         print(Username)
         print(Password)
         if(length(which(credentials$username_id==Username))==1) { 
           pasmatch  <- credentials["passod"][which(credentials$username_id==Username),]
           pasverify <- password_verify(pasmatch, Password)
           print(pasmatch)
           if(pasverify) {
             USER$login <- TRUE
           } else {
             shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade")
             shinyjs::delay(3000, shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade"))
           }
         } else {
           shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade")
           shinyjs::delay(3000, shinyjs::toggle(id = "nomatch", anim = TRUE, time = 1, animType = "fade"))
         }
       } 
     }
   }    
 })
 
 
 output$nav1<- renderUI({
   if (USER$login == FALSE){
     navbarPage(title=shiny::span(title, '72 DRAGONS DASHBORD',style = "color: #AD9440 ;font-size: 18px; font-family: 'Caladea'"),
                
                setBackgroundImage(shinydashboard = F),
                tags$style(HTML(".navbar-default{background-color: transparent;}")),
                div(class = "login1",
                    uiOutput("uiLogin"),
                    tags$head(),
                    tags$style(HTML('.navbar-nav > li > a, .navbar-brand {
              padding-top:4px ; 
              padding-bottom:0 ;
              height: 65px;
              }
             .navbar {min-height:65px;}')),
                    tags$style(".img {
              margin-left:-30px;
              margin-top:-20px;
            }"),
                    tags$div(class="img",imageOutput('image'))
                )
     )
   }
   
   else if(USER$login==TRUE){
     if (perm()=='advanced'){
       
       navbarPage(
         uiOutput("title_45"),
         #title=shiny::span('72 DRAGONS  DASHBOARD',style = "color: #96031A ; font-size: 18px; font-family: 'Caladea';font-weight: bold;"),
         #setBackgroundImage(src =b65, shinydashboard = FALSE),
         #tags$style(HTML(".navbar-default{background-color: transparent;}")),
         tags$head(
           tags$style(HTML(
             # '.navbar-nav > li > a, .navbar-brand {
             #        padding-top:0px !important; 
             #        padding-bottom:0px !important;
             #        height: 25px;
             #        }
             #       .navbar {min-height:25px !important;}'
             '.navbar { min-height:75px; height: 75px; }'
           ))
         ),
         
         tabPanel(title="Home",uiOutput("title_panel_1"),
                  tags$br(),
                  tags$br(),
                  tags$br(),
                  tags$br(),

                  tags$img(src=b64,height= "128px", width="128px",style="position:relative;top:-63px;"),
                  tags$br(),
                  fluidRow(
                    column(width=12,align="right",h4(tags$b(tags$em("Cannes Day 4"))),style = "color:#AD9440;font-size: 50px; font-weight:bold;")
                  ),
                  tags$br(),
                  tags$br(),
                  fluidRow(
                    column(width=12,align="right",h4(tags$b(tags$em("Daily Growth Tracker"))),style = "color:#AD9440  ; font-size: 25px; font-weight:bold;")
                  ),
                  tags$br(),
                  tags$br(),
                  splitLayout(class="first-row",style = "border: 1px solid silver:;position:relative;left: 0px;", cellWidths = c("100%","100%", "100%"), 
                              plotlyOutput("plot1",height = 350,width = "100%"),
                              plotlyOutput("plot5",height = 350,width = "100%"),
                              plotlyOutput("plot3",height = 350,width = "100%"),
                              plotlyOutput("plot2",height = 350,width = "100%"),
                              plotlyOutput("plot6",height = 350,width = "100%"),
                              plotlyOutput("plot4",height = 350,width = "100%")
                  ),
                  
         ),
         tabPanel(title="Map of Buyers",uiOutput("title_panel1"),
                  fluidRow(
                    column(width=12,align="right",h2(tags$b(tags$em("Map of Buyers"))),style = "color:#AD9440  ; font-size: 25px; font-weight:bold;")
                  ),
                  tags$br(),
                  tags$br(),
                  splitLayout(class="fifth-row",style = "border: 1px solid silver:;position:relative;left: 0px;", cellWidths = c("100%","100%", "100%"), 
                              plotlyOutput("plot17",height = 800,width = "100%"),
                              tags$br()
                  ),
                  tags$br(),
                  tags$br(),
                  selectInput("idcountry","Select A Country",choices = df15$Country),
                  tableOutput("BuyerData")
)
       )
     }
   }
 })
 output$plot1<- renderPlotly({
   f1 <- list(
     family = "Arial, sans-serif",
     size = 10,
     color = "black"
   )
   f2 <- list(
     family = "Old Standard TT, serif",
     size = 15,
     color = "black"
   )
   a <- list(
     title = "Number of Followers",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1
   )
   b <- list(
     title = "",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1,
     exponentformat = "E"
   )
   t <- list(
     family = "Arial, sans-serif",
     size = 8,
     color = 'black')
   
   m = list(
     r = 25, 
     t = 25, 
     b = 25, 
     l = 25
   )
   fig <- plot_ly(df1, x = ~Date, y = ~Actual_Follower, type = 'bar', name = 'Actual_Follower',marker = list(color = '#96031a'),text = ~Actual_Follower,textposition = 'outside',width=450,height=300)
   fig <- fig %>% add_trace(y = ~Expected_Follower, name = 'Expected_Follower',marker = list(color = '#AD9440'),text = ~Expected_Follower,textposition = 'outside')
   fig <- fig %>% layout(title = '<b> 72 Dragon Film Facebook Follower Comparison <b>',
                         legend = list(orientation = 'h'),font=t,yaxis = a, xaxis = b,barmode = 'group',margin=m,
                         bargap = 0.15, bargroupgap = 0.1)
 })
 output$plot2<- renderPlotly({
   f1 <- list(
     family = "Arial, sans-serif",
     size = 10,
     color = "black"
   )
   f2 <- list(
     family = "Old Standard TT, serif",
     size = 15,
     color = "black"
   )
   a <- list(
     title = "Number of Followers",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1
   )
   b <- list(
     title = "",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1,
     exponentformat = "E"
   )
   t <- list(
     family = "Arial, sans-serif",
     size = 8,
     color = 'black')
   
   m = list(
     r = 25, 
     t = 25, 
     b = 25, 
     l = 25
   )
   fig <- plot_ly(df2, x = ~Date, y = ~Actual_Follower, type = 'bar', name = 'Actual_Follower',marker = list(color = '#96031a'),text = ~Actual_Follower,textposition = 'outside',width=450,height=300)
   fig <- fig %>% add_trace(y = ~Expected_Follower, name = 'Expected_Follower',marker = list(color = '#AD9440'),text = ~Expected_Follower,textposition = 'outside') 
   fig <- fig %>% layout(title = '<b> 72 Dragon Film Instagram Follower Comparison <b>',
                         legend = list(orientation = 'h'),font=t,yaxis = a, xaxis = b,barmode = 'group',margin=m,
                         bargap = 0.15, bargroupgap = 0.1)
 })
 output$plot3<- renderPlotly({
   f1 <- list(
     family = "Arial, sans-serif",
     size = 10,
     color = "black"
   )
   f2 <- list(
     family = "Old Standard TT, serif",
     size = 15,
     color = "black"
   )
   a <- list(
     title = "Number of Followers",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1
   )
   b <- list(
     title = "",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1,
     exponentformat = "E"
   )
   t <- list(
     family = "Arial, sans-serif",
     size = 8,
     color = 'black')
   
   m = list(
     r = 25, 
     t = 25, 
     b = 25, 
     l = 25
   )
   fig <- plot_ly(df3, x = ~Date, y = ~Actual_Follower, type = 'bar', name = 'Actual_Follower',marker = list(color = '#96031a'),text = ~Actual_Follower,textposition = 'outside',width=450,height=300)
   fig <- fig %>% add_trace(y = ~Expected_Follower, name = 'Expected_Follower',marker = list(color = '#AD9440'),text = ~Expected_Follower,textposition = 'outside')
   #fig <- fig %>% layout(title = '72 Dragons Media Follower comparison',barmode = 'group',
   #yaxis = list(title = 'Followers'), 
   #xaxis = list(title = 'Date') )
   fig <- fig %>% layout(title = '<b> 72 Dragons Media Visitors Comparison <b>',
                         legend = list(orientation = 'h'),font=t,yaxis = a, xaxis = b,barmode = 'group',margin=m,
                         bargap = 0.15, bargroupgap = 0.1)
 })
 output$plot4<- renderPlotly({
   f1 <- list(
     family = "Arial, sans-serif",
     size = 10,
     color = "black"
   )
   f2 <- list(
     family = "Old Standard TT, serif",
     size = 15,
     color = "black"
   )
   a <- list(
     title = "Number of Followers",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1
   )
   b <- list(
     title = "",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1,
     exponentformat = "E"
   )
   t <- list(
     family = "Arial, sans-serif",
     size = 8,
     color = 'black')
   
   m = list(
     r = 25, 
     t = 25, 
     b = 25, 
     l = 25
   )
   fig <- plot_ly(df4, x = ~Date, y = ~Actual_Follower, type = 'bar', name = 'Actual_Follower',marker = list(color = '#96031a'),text = ~Actual_Follower,textposition = 'outside',width=450,height=300)
   fig <- fig %>% add_trace(y = ~Expected_Follower, name = 'Expected_Follower',marker = list(color = '#AD9440'),text = ~Expected_Follower,textposition = 'outside')
   fig <- fig %>% layout(title = '<b> 72 Dragons Cannes Visitors Comparison <b>',
                         legend = list(orientation = 'h'),font=t,yaxis = a, xaxis = b,barmode = 'group',margin=m,
                         bargap = 0.15, bargroupgap = 0.1)
 })
 output$plot5<- renderPlotly({
   f1 <- list(
     family = "Arial, sans-serif",
     size = 10,
     color = "black"
   )
   f2 <- list(
     family = "Old Standard TT, serif",
     size = 15,
     color = "black"
   )
   a <- list(
     title = "Number of Followers",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1
   )
   b <- list(
     title = "",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1,
     exponentformat = "E"
   )
   t <- list(
     family = "Arial, sans-serif",
     size = 8,
     color = 'black')
   
   m = list(
     r = 25, 
     t = 25, 
     b = 25, 
     l = 25
   )
   fig <- plot_ly(df5, x = ~Date, y = ~Actual_Follower, type = 'bar', name = 'Actual_Follower',marker = list(color = '#96031a'),text = ~Actual_Follower,textposition = 'outside',width=450,height=300)
   fig <- fig %>% add_trace(y = ~Expected_Follower, name = 'Expected_Follower',marker = list(color = '#AD9440'),text = ~Expected_Follower,textposition = 'outside')
   
   fig <- fig %>% layout(title = '<b> 72 Dragon Health Facebook Follower Comparison <b>',
                         legend = list(orientation = 'h'),font=t,yaxis = a, xaxis = b,barmode = 'group',margin=m,
                         bargap = 0.15, bargroupgap = 0.1)
 })
 output$plot6<- renderPlotly({
   f1 <- list(
     family = "Arial, sans-serif",
     size = 10,
     color = "black"
   )
   f2 <- list(
     family = "Old Standard TT, serif",
     size = 15,
     color = "black"
   )
   a <- list(
     title = "Number of Followers",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1
   )
   b <- list(
     title = "",
     titlefont = f1,
     showticklabels = TRUE,
     tickangle = 0,
     tickfont = f1,
     exponentformat = "E"
   )
   t <- list(
     family = "Arial, sans-serif",
     size = 8,
     color = 'black')
   
   m = list(
     r = 25, 
     t = 25, 
     b = 25, 
     l = 25
   )
   fig <- plot_ly(df6, x = ~Date, y = ~Actual_Follower, type = 'bar', name = 'Actual_Follower',marker = list(color = '#96031a'),text = ~Actual_Follower,textposition = 'outside',width=450,height=300)
   fig <- fig %>% add_trace(y = ~Expected_Follower, name = 'Expected_Follower',marker = list(color = '#AD9440'),text = ~Expected_Follower,textposition = 'outside')
   
   fig <- fig %>% layout(title = '<b> 72 Dragon Health Instagram Follower Comparison <b>',
                         legend = list(orientation = 'h'),font=t,yaxis = a, xaxis = b,barmode = 'group',margin=m,
                         bargap = 0.15, bargroupgap = 0.1)
 })
 
}





runApp(list(ui = ui, server = server), launch.browser = TRUE)
shinyApp(ui, server)
