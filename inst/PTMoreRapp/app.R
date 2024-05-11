library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(shinyBS)
library(openxlsx)
library(gdata)
library(DT)
library(shinyjs)
library(shinyWidgets)
library(R.utils)
library(data.table)
###########
######ui.R
###########
ui <- dashboardPage(
  title = "PTMoreR",
  dashboardHeader(title = span(tags$a(href='#',
                                      tags$img(src='PTMoreRti.png',width='180',height='52')),
                               "PTMoreR"),titleWidth = 230),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "homeui", icon = icon("home")),
      #menuItem("1. 上传数据", tabName = "uploaddata", icon = icon("file")),#th
      menuItem("Assembled Functions", tabName = "tiaojiecanshu", icon = icon("dashboard")),#cog
      menuItem("Help", tabName = "cankaoziliao", icon = icon("info-circle"))
    )
  ),
  dashboardBody(
    useShinyjs(),
    tagList(
      #tags$head(includeHTML(("googleanalytics.html"))),
      #tags$head(includeHTML(("googleanalytics2.html"))),
      tags$head(
        #tags$link(rel="stylesheet", type="text/css",href="busystyle.css"),
        tags$link(rel="stylesheet", type="text/css",href="mainstyle.css")#,
        #tags$script(type="text/javascript", src = "busy.js")
      )
    ),
    #div(class = "busy",
    #    h2(strong("Calculating......")),
    #    img(src="rmd_loader.gif")
    #),
    tabItems(
      tabItem(
        tabName = "homeui",
        div(style="text-align:center;margin-top:10px;font-size:200%;color:darkred",
            HTML("<b>Dear Users, Welcome to PTMoreR</b>")),
        div(style="text-align:center;margin-top: 20px",
            a(href='#',
              img(src='Figure1app.png',height="450"))),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-left:15%;margin-top:15px",
            HTML("<b>PTMoreR</b> is a web-based tool, which possesses the core functions, including:")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:120%;margin-left:16%;margin-top:5px",
            #HTML("<br />"),
            HTML("&nbsp;&nbsp;&nbsp;&nbsp;1. Mapping the PTM sites and protein sequences between any species and Human;")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:120%;margin-left:16%;margin-top:5px",
            #HTML("<br />"),
            HTML("&nbsp;&nbsp;&nbsp;&nbsp;2. Calculating sequence window similarity and allowing filtering thresholds of sequence similarity during the mapping;")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:120%;margin-left:16%;margin-top:5px",
            #HTML("<br />"),
            HTML("&nbsp;&nbsp;&nbsp;&nbsp;3. Performing PTM site-specific enrichment analysis and offering flexible annotations based on kinase-substrate database and network plots;")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:120%;margin-left:16%;margin-top:5px",
            #HTML("<br />"),
            HTML("&nbsp;&nbsp;&nbsp;&nbsp;4. Visualizing the regulation of modification sites on the basis of protein-protein interaction data.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-left:15%;margin-right:15%;margin-top:15px",
            #HTML("<br />"),
            HTML("In addition, this tool supports both online access and local installation. The source codes and installation instructions can be available in the GitHub repository: <a href='https://github.com/wangshisheng/PTMoreR' target='_blank'>https://github.com/wangshisheng/PTMoreR</a> under an MIT license.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;margin-left:15%;margin-right:15%;margin-top:15px;font-size:130%",
            #HTML("<br />"),
            HTML("Finally, PTMoreR is developed by <a href='https://shiny.rstudio.com/' target='_blank'>R shiny (Version 1.6.0)</a>, and is free and open to all users with no login requirement. It can be readily accessed by all popular web browsers including Google Chrome, Mozilla Firefox, Safari and Internet Explorer 10 (or later), and so on. We would highly appreciate that if you could send your feedback about any bug or feature request to Shisheng Wang at <u>shishengwang@wchscu.cn</u>.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;margin-left:15%;margin-top:15px;font-size:120%",
            #HTML("<br />"),
            HTML("<em>Friendly suggestions</em>:")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:110%;margin-left:15%;margin-top:5px",
            #HTML("<br />"),
            HTML("&nbsp;&nbsp;&nbsp;&nbsp;a) Open PTMoreR with Chrome, Mozilla Firefox, Safari or Firefox;")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:110%;margin-left:15%;margin-top:5px",
            #HTML("<br />"),
            HTML("&nbsp;&nbsp;&nbsp;&nbsp;b) The minimum operating system specifications are: RAM 4GB, Hard drive 500 GB;")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:110%;margin-left:15%;margin-top:5px",
            #HTML("<br />"),
            HTML("&nbsp;&nbsp;&nbsp;&nbsp;c) The monitor resolution (>= 1920x1080) is better.")),
        div(style="text-align:center;margin-top:20px;font-size:140%;color:darkgreen",
            HTML("<br />"),
            HTML("^_^ <em>Enjoy yourself in PTMoreR</em> ^_^")),
        tags$hr(style="border-color: grey60;"),
        div(style="text-align:center;margin-top: 20px;font-size:100%",
            HTML(" &copy; 2024 <a href='https://www.yslproteomics.org/' target='_blank'>Yansheng Liu's Group</a> and <a href='http://english.cd120.com/' target='_blank'>Hao Yang's Group</a>. All Rights Reserved.")),
        div(style="text-align:center;margin-bottom: 20px;font-size:100%",
            HTML("&nbsp;&nbsp; Created by Shisheng Wang. E-mail: <u>shishengwang@wchscu.cn</u>."))
        #uiOutput("welcomeui")
      ),
      tabItem(
        tabName = "tiaojiecanshu",
        tagList(
          fluidRow(
            column(
              width = 12,
              box(
                width = 12, title = strong("User Guide"), 
                status = "warning", solidHeader = TRUE, collapsible = TRUE, 
                collapsed = FALSE, closable = FALSE, 
                h4("There are 6 steps to process data in PTMoreR, please do it step by step:"),
                div(style="font-size:110%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 1. Import Sequence Data.</b> In this part, users can upload their own peptide sequences with modification (e.g. phosphorylation). The example data were obtained from Rat and can be found when users click 'Load example data' below.<br />")), 
                div(style="font-size:110%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 2. Pre-alignment.</b> This step aligns those peptide sequences with the background database (protein sequences) and force the modified sites/residues to be central sites, then users can get the standard peptide window sequences (e.g. 15 amino acid length by default).<br />")), 
                #div(style="font-size:110%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 3. Blast to the other species.</b> This step will map the PTM site and protein sequences and identifiers between two species (One is that you chose in Step 1 and the other is that you want to blast to, which can be chosen below.<br />")), 
                div(style="font-size:110%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 3. Blast to Human.</b> This step will map the PTM site and protein sequences and identifiers between two species (One is that you chose in Step 1 and the other is that you want to blast to, which is Human by default.<br />")),
                div(style="font-size:110%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 4. Motif Enrichment and Plot.</b> This step will find overrepresented sequence motifs for uploaded peptides and blasted peptides respectively, then visualize them. Uploaded peptides here means those modified peptides uploaded directly by users. 
                Blasted peptides here means those modified peptides mapped to human after blasting.<br />")),
                div(style="font-size:110%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 5. Annotation and enrichment analysis based on Kinase-Substrate database.</b> This step will offer more flexible annotation based on kinase-substrate databases (e.g. PhosphoSitePlus) and network plots.<br />")),
                div(style="font-size:110%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 6. Interaction Plot.</b> This step will visualize the expression of modification sites on interacting proteins on the basis of protein-protein interaction data."))
              )
            ),
            column(
              width = 12,
              div(style="margin-top:10px;margin-bottom:5px;color:#C70039;font-size:120%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 1. Import Sequence Data.</b>")),
              column(
                width = 5,
                box(width = 12, inputId = "input_card7", 
                    title = strong("Input Parameters"), status = "primary", 
                    solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE, 
                    closable = FALSE,prettyRadioButtons(
                      inputId = "loadseqdatatype",
                      label = "",
                      thick = TRUE,
                      choices = list("Import modified sequences" = 1,"Load example data"=2),
                      animation = "pulse",
                      status = "info",
                      selected = 1,
                      inline = TRUE
                    ),
                    hr(),
                    conditionalPanel(
                      condition = "input.loadseqdatatype==1",
                      radioButtons("uploadpaste",label=NULL,choices = list("A. Upload" = 1,"B. Paste"=2),
                                   selected = 1,inline = TRUE),
                      conditionalPanel(
                        condition = "input.uploadpaste==1",
                        radioButtons(
                          "metabopathfileType_Input",
                          label = h5("1. File format:"),
                          choices = list(".xlsx" = 1,".xls"=2, ".csv/txt" = 3),
                          selected = 1,
                          inline = TRUE
                        ),
                        fileInput('metabopathfile1', h5('1.1. Import your data:'),
                                  accept=c('text/csv','text/plain','.xlsx','.xls'))#,
                        #checkboxInput('metabopathheader', '1.2. Header?', TRUE),
                        #checkboxInput('metabopathfirstcol', '1.3. First column?', FALSE),
                        #conditionalPanel(condition = "input.metabopathfileType_Input==1",
                        #                 numericInput("metabopathxlsxindex",h5("1.4. Sheet index:"),value = 1)),
                        #conditionalPanel(condition = "input.metabopathfileType_Input==2",
                        #                 numericInput("metabopathxlsxindex",h5("1.4. Sheet index:"),value = 1)),
                        #conditionalPanel(condition = "input.metabopathfileType_Input==3",
                        #                 radioButtons('metabopathsep', h5('1.4. Separator:'),
                        #                              c(Comma=',',
                        #                                Semicolon=';',
                        #                                Tab='\t',
                        #                                BlankSpace=' '),
                        #                              ','))
                      ),
                      conditionalPanel(
                        condition = "input.uploadpaste==2",
                        textAreaInput("metabopath_zhantie",label = h5("1. Paste your data here:"),value="",height ="100px")
                      )
                    ),
                    conditionalPanel(
                      condition = "input.loadseqdatatype==2",
                      downloadButton("loadseqdatadownload1","1. Download example data from Rat",style="color: #fff; background-color: #6495ED; border-color: #6495ED")
                    ),
                    #tags$hr(style="border-color: grey;"),
                    selectInput("origidatatype",h5("2. Data type:"),choices = c("Normal","MaxQuant","Spectronaut")),
                    bsTooltip("origidatatype",'The original post-translational modification (PTM) data obtained from which kind of search software. If you have processed the PTM data with standard format (e.g. NPT#Y#GSWFTEK), you should choose the "Normal", otherwise, if your PTM data are obtained from MaxQuant or Spectronaut, you should choose the relative type.',
                              placement = "right",options = list(container = "body")),
                    textInput("centralres",h5("3. Central amino acid:"),value = "ST"),
                    bsTooltip("centralres",'The central residue that users want to analyze, for example, phosphorylation motif analysis, can center on phosphorylated S, T or Y residues. If they want to analyze multi motif sites, here should be "STY".',
                              placement = "right",options = list(container = "body")),
                    div(id="centralresfuhao_div",textInput("centralresfuhao",h5("4. Label of modification:"),value = "#")),
                    bsTooltip("centralresfuhao_div",'The label represents modification, users can use some label they like, such as "#", "@", where "#" is recommended.',
                              placement = "right",options = list(container = "body")),
                    div(id="minseqs_div",numericInput("minseqs",h5("5. Width:"),value = 7)),
                    bsTooltip("minseqs_div",'It is the number of left/right side characters of the central residue. For example, the default is "7", which means every uploaded peptide with different lengths will be aligned into a standard window (i.e. 15 amino acids width here) in the next "Step 2. Pre-alignment".',
                              placement = "right",options = list(container = "body")),
                    #tags$hr(style="border-color: grey;"),
                    conditionalPanel(
                      condition = "input.loadseqdatatype==1",
                      div(id="xuanzebgdatabase_div",radioButtons("xuanzebgdatabase",label=h5("6. Select or upload the protein sequences (.fasta file):"),choices = list("6.1. Select" = 1,"6.2. Upload"=2),
                                                                 selected = 1,inline = TRUE)),
                      bsTooltip("xuanzebgdatabase_div",'Here means you should select or upload the whole protein sequences from which you obtain the uploaded peptide sequences. "Select" means users can directly select one species and this tool has been connected to UniProt via API so that any species is possible without needing to download data; "Upload" means users can upload their own protein sequences, which can be downloaded from some public database, such as UniProt (http://www.uniprot.org).',
                                placement = "right",options = list(container = "body")),
                      conditionalPanel(
                        condition = "input.xuanzebgdatabase==1",
                        #uiOutput("metabopathspecies")
                        selectizeInput('metabopathspeciesselect', h5('Species:'), choices =NULL)
                      ),
                      conditionalPanel(
                        condition = "input.xuanzebgdatabase==2",
                        textInput("wuzhongid",h5("6.2.1. Please type in taxonomic identifier of uploaded species:"),value = "",placeholder="10116"),
                        fileInput('fastafileown', h5('6.2.2. Please upload your fasta file:'),accept=c('.fasta'))
                      )
                    ),
                    conditionalPanel(
                      condition = "input.loadseqdatatype==2",
                      selectizeInput('speciesselectrat', h5('Example species:'), choices ="10116-Rattus norvegicus (Rat)")
                    ))
              ),
              column(
                width = 7,
                box(width = 12, inputId = "report_card1", 
                    title = strong("Results"), status = "success", solidHeader = TRUE, 
                    collapsible = TRUE, collapsed = TRUE, closable = FALSE,
                    h4("Sequence data:"),
                    dataTableOutput("seqrawdata"))
              )
            ),
            column(
              width = 12,
              div(style="margin-top:0px;margin-bottom:5px;color:#C70039;font-size:120%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 2. Pre-alignment.</b>")),
              column(
                width = 5,
                box(width = 12, inputId = "input_card2", 
                    title = strong("Input Parameters"), status = "primary", 
                    solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
                    #div(id="seqalignif_div",checkboxInput('seqalignif', '1. Pre-aligned or not?', TRUE)),
                    #bsTooltip("seqalignif_div","Whether to pre-align your sequences. If your sequences are standard (e.g. 15 length amino acids), you can unselect this parameter. Default is true.",
                    #          placement = "right",options = list(container = "body")),
                    div(id="seqalignhanif_div",checkboxInput('seqalignhanif', '1. Check if containing some regular sequence?', FALSE)),
                    bsTooltip("seqalignhanif_div",'If users want to check whether the aligned peptides contain some specific sequences, for example, you want to find those peptides whose 3th and 5th position are R (arginine), then you can select this parameter and type in a simple regular expression, like "^\\\\w{2}R\\\\w{1}R". Otherwise, you just unselect it.',
                              placement = "right",options = list(container = "body")),
                    conditionalPanel(
                      condition = "input.seqalignhanif==true",
                      textInput("seqalignhan",h5("Regular expression:"),value = "^\\w{2}R\\w{1}R")
                    ),
                    tags$hr(style="border-color: grey;"),
                    actionButton("mcsbtn_seqalign","Calculate",icon("paper-plane"),
                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))
              ),
              column(
                width = 7,
                box(width = 12,inputId = "report_card2", 
                    title = strong("Results"), status = "success", solidHeader = TRUE, 
                    collapsible = TRUE, collapsed = TRUE, closable = FALSE,
                    h4("Pre-alignment table:"),
                    fluidRow(
                      column(
                        2,
                        downloadButton("seqduiqidl","Download")
                      ),
                      column(
                        2,
                        actionButton("mcsbtn_resjieshi","Result description",icon("file-alt"),
                                     style="color: black; background-color: #E6E6FA; border-color: #E6E6FA")
                      )
                    ),
                    #withSpinner(dataTableOutput("seqduiqi")))
                    #div(style = 'overflow-x: scroll',withSpinner(dataTableOutput("seqduiqi"))))
                    hidden(div(id="hiddendiv1",style = 'overflow-x: scroll',withSpinner(dataTableOutput("seqduiqi")))))
              )
            ),
            column(
              width = 12,
              div(style="margin-top:0px;margin-bottom:5px;color:#C70039;font-size:120%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 3. Blast to Human.</b>")),
              column(
                width = 5,
                box(width = 12, inputId = "input_card3", 
                    title = strong("Input Parameters"), status = "primary", 
                    solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
                    #div(id="preblastif_div",checkboxInput("preblastif","1. Using pre-blast results from Human or not?",TRUE)),
                    #bsTooltip("preblastif_div",'By default, the pre-blast results only contain Human data, which means that if true, you will map your data with Human protein sequences. Otherwise, if you want to blast other species, you can unselect this parameter and select/upload the fasta file below. Please Note: This step is a little time-consuming! If true, this tool will retrieve the pre-blast results and it will be faster to finish this step. Otherwise, this tool will blast the uploaded sequences against those protein sequences of the other species, which will take more time, perhaps several hours.',
                    #          placement = "right",options = list(container = "body")),
                    #conditionalPanel(
                    #  condition = "input.preblastif==false",
                    #  div(id="xuanzebgdatabase2_div",radioButtons("xuanzebgdatabase2",label=h5("1.1. Select or upload the protein sequences (.fasta file):"),choices = list("1.1.1 Select" = 1,"1.1.2. Upload"=2),
                    #                                              selected = 1,inline = TRUE)),
                    #  bsTooltip("xuanzebgdatabase2_div",'Here means you should select or upload the whole protein sequences that you want to blast to. "Select" means users can directly select one species whose protein sequences have been built in PTMoreR; "Upload" means users can upload their own protein sequences, which can be downloaded from some public database, such as UniProt (http://www.uniprot.org).',
                    #            placement = "right",options = list(container = "body")),
                    #  conditionalPanel(
                    #    condition = "input.xuanzebgdatabase2==1",
                    #    uiOutput("metabopathspecies2")
                    #  ),
                    #  conditionalPanel(
                    #    condition = "input.xuanzebgdatabase2==2",
                    #    fileInput('fastafileown2', h5('Please upload your fasta file:'),accept=c('.fasta')),
                    #    textInput("wuzhongid2",h5("Taxonomic identifier of uploaded species:"),value = "",placeholder="9606")
                    #  )
                    #),
                    #tags$hr(style="border-color: grey;"),
                    div(id="evalueyuzhi_div",numericInput("evalueyuzhi",h5("1. Expectation value (E) threshold:"),value = 0.00001)),
                    bsTooltip("evalueyuzhi_div",'Expectation value (E) threshold for saving hits.',
                              placement = "bottom",options = list(container = "body")),
                    div(id="blastbesthit_div",selectInput("blastbesthit",h5("2. The criterion for the best BLAST hit:"),choices = c("Percentage"=1,"Longest alignment length"=2))),
                    bsTooltip("blastbesthit_div",'This tool performs a BLAST search between query and subject sequences and returns only the best hit based on the selected criterion. “Percentage” means If e-values are identical then the hit with the largest matching percentage is chosen. “Longest alignment length” means If e-values are identical then the hit with the longest alignment length is chosen.',
                              placement = "right",options = list(container = "body")),
                    #div(id="similaryuzhi_div",numericInput("similaryuzhi",h5("2. Expectation value (E) threshold:"),value = 70)),
                    #bsTooltip("similaryuzhi_div",'Expectation value (E) threshold for saving hits.',
                    #          placement = "bottom",options = list(container = "body"))
                    div(id="centeraamatach_div",selectInput("centeraamatach",h5("3. Central amino acid matching degree:"),choices = c("Fuzzy matching"=1,"All"=2,"Exact matching"=3))),
                    bsTooltip("centeraamatach_div",'The matching degree of central amino acids (CAAs) when the uploaded peptides are blasted to Human protein sequences. 1. Exact matching: The CAAs are same, for example, the CAA is "S" in the uploaded peptides and the CAA is also "S" in the blasted sequence. 2. Fuzzy matching: For example, the CAA is "S" in the uploaded peptides and the CAA could be "S", "T", or "Y" in the blasted sequence. All: Reporting all results.',
                              placement = "right",options = list(container = "body")),
                    checkboxInput("seqmatachsimilarif","4. Whether setting sequence windows similarity (SWS)?",TRUE),
                    conditionalPanel(
                      condition = "input.seqmatachsimilarif==true",
                      div(id="seqmatachsimilar_div",numericInput("seqmatachsimilar",h5("4.1. SWS threshold:"),value = 8)),
                      bsTooltip("seqmatachsimilar_div",'The similarity of sequence windows between the uploaded peptides and the blasted peptides. For example, there are 15 amino acids in one sequence window, 7 here means there are 7 amino acids are exactly same (amino acids names and positions in both windows are all same).',
                                placement = "right",options = list(container = "body"))
                    ),
                    checkboxInput("blosum50yuzhiif","5. Whether setting BLOSUM50 Score?",FALSE),
                    conditionalPanel(
                      condition = "input.blosum50yuzhiif==true",
                      div(id="blosum50_div",numericInput("blosum50yuzhi",h5("5.1. BLOSUM50 Score threshold:"),value = 50)),
                      bsTooltip("blosum50_div",'BLOSUM50 means that the matrix was built using blocks of aligned sequences that had no more than 50% identity, which is used to score alignments between evolutionarily divergent protein sequences.',
                                placement="right",options=list(container="body"))
                    ),
                    tags$hr(style="border-color: grey;"),
                    actionButton("blastbtn_seqalign","Calculate",icon("paper-plane"),
                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))
              ),
              column(
                width = 7,
                box(width = 12, inputId = "report_card3", 
                    title = strong("Results"), status = "success", solidHeader = TRUE, 
                    collapsible = TRUE, collapsed = TRUE, closable = FALSE,
                    h4("Final blasted table:"),
                    fluidRow(
                      column(
                        2,
                        downloadButton("blastresdl","Download")
                      ),
                      column(
                        2,
                        actionButton("mcsbtn_resjieshi2_1","Result description",icon("file-alt"),
                                     style="color: black; background-color: #E6E6FA; border-color: #E6E6FA")
                      )
                    ),
                    #withSpinner(dataTableOutput("blastres")))
                    #div(style = 'overflow-x: scroll',withSpinner(dataTableOutput("blastres"))))
                    hidden(div(id="hiddendiv2",style = 'overflow-x: scroll',withSpinner(dataTableOutput("blastres")))))
              )
            ),
            column(
              width = 12,
              div(style="margin-top:0px;margin-bottom:5px;color:#C70039;font-size:120%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 4. Motif Enrichment and Plot.</b>")),
              column(
                width = 5,
                box(width = 12, inputId = "input_card4",
                    title = strong("Input Parameters"), status = "primary",
                    solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
                    div(id="onlyregularsiteif_div",checkboxInput("onlyregularsiteif","1. Only analyze regular sequences?",FALSE)),
                    bsTooltip("onlyregularsiteif_div",'If selected, this tool will only take the peptides with regular sequences as foreground data, therefore, please make sure that you have select the parameter "Check if containing some regular sequence?" in Step 2.',
                              placement = "right",options = list(container = "body")),
                    div(id="minseqsnum_div",numericInput("minseqsnum",h5("2. Minimum number:"),value = 20)),
                    bsTooltip("minseqsnum_div","This threshold refers to the minimum number of times you wish each of your extracted motifs to occur in the data set.",
                              placement = "right",options = list(container = "body")),
                    div(id="pvalcutoff_div",numericInput("pvalcutoff",h5("3. P-value threshold:"),value = 0.000001,min = 0)),
                    bsTooltip("pvalcutoff_div","The p-value threshold for the binomial probability. This is used for the selection of significant residue/position in the motif.",
                              placement = "right",options = list(container = "body")),
                    div(id='enrichseqnum_div',textInput("enrichseqnum",h5("4. Motif index for plot:"),value = "1-2")),
                    bsTooltip("enrichseqnum_div",'Which motif would be plotted. If users only type in one number, it will plot the relative motif. If users type in "1-10", it will plot the 1th to 10th motifs.',
                              placement = "bottom",options = list(container = "body")),
                    div(id='equalheightif_div',checkboxInput("equalheightif","5. Equal height or not?",TRUE)),
                    bsTooltip("equalheightif_div",'Whether all residues in the figure have equal height. Default is TRUE.',
                              placement = "bottom",options = list(container = "body")),
                    numericInput("motifplot_height",h5("6. Figure height:"),value = 400),
                    tags$hr(style="border-color: grey;"),
                    actionButton("mcsbtn_motifquanbu","Calculate",icon("paper-plane"),
                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))
              ),
              column(
                width = 7,
                box(width = 12, inputId = "report_card4",
                    title = strong("Results"), status = "success", solidHeader = TRUE, 
                    collapsible = TRUE, collapsed = TRUE, closable = FALSE,
                    radioButtons(
                      "motiffujidfxuanze",
                      label = h4(""),
                      choices = list("1. Uploaded peptide motifs results" = 1,"2. Blasted peptide motifs results"=2,"3. Motif similarity"=3),
                      selected = 1,
                      inline = TRUE
                    ),
                    tags$hr(style="border-color: grey;"),
                    conditionalPanel(
                      condition = 'input.motiffujidfxuanze==1',
                      radioButtons(
                        "motifplotxuanze1",
                        label = h4(""),
                        choices = list("1.1 Motif plot" = 1,"1.2 Motif table"=2,"1.3 Motif PWM"=3),
                        selected = 1,
                        inline = TRUE
                      ),
                      hr(),
                      conditionalPanel(
                        condition = "input.motifplotxuanze1==1",
                        downloadButton("motifplotdownload","Download"),
                        #div(style = 'overflow-x:scroll;overflow-y:scroll',withSpinner(plotOutput("motifplot")))
                        hidden(div(id="hiddendiv3",style = 'overflow-x:scroll;overflow-y:scroll',withSpinner(plotOutput("motifplot"))))
                      ),
                      conditionalPanel(
                        condition = "input.motifplotxuanze1==2",
                        fluidRow(
                          column(
                            2,
                            downloadButton("motiffujidl","Download")
                          ),
                          column(
                            2,
                            actionButton("mcsbtn_resjieshi3","Result description",icon("file-alt"),
                                         style="color: black; background-color: #E6E6FA; border-color: #E6E6FA")
                          )
                        ),
                        #withSpinner(dataTableOutput("motiffuji"))
                        #div(style = 'overflow-x: scroll',withSpinner(dataTableOutput('motiffuji')))
                        hidden(div(id="hiddendiv4",style = 'overflow-x: scroll',withSpinner(dataTableOutput('motiffuji'))))
                        #downloadButton("motifplotdownload","Download"),
                        #plotOutput("motifplot")
                      ),
                      conditionalPanel(
                        condition = "input.motifplotxuanze1==3",
                        uiOutput("uploadmotifpwmui"),
                        #h4("The PWM (Position weight matrix) of the selected motif:"),
                        downloadButton("uploadmotifpwmdfdl","Download"),
                        div(style = 'overflow-x: scroll',withSpinner(dataTableOutput('uploadmotifpwmdf')))
                      )
                    ),
                    conditionalPanel(
                      condition = 'input.motiffujidfxuanze==2',
                      radioButtons(
                        "motifplotxuanze2",
                        label = h4(""),
                        choices = list("2.1 Motif plot" = 1,"2.2 Motif table"=2,"2.3 Motif PWM"=3),
                        selected = 1,
                        inline = TRUE
                      ),
                      hr(),
                      conditionalPanel(
                        condition = "input.motifplotxuanze2==1",
                        #h4("1. Blasted peptide motif enrichment results:"),
                        downloadButton("motifblastplotdl","Download"),
                        #div(style = 'overflow-x:scroll;overflow-y:scroll',withSpinner(plotOutput("motifblastplot")))
                        hidden(div(id="hiddendiv5",style = 'overflow-x:scroll;overflow-y:scroll',withSpinner(plotOutput("motifblastplot"))))
                      ),
                      conditionalPanel(
                        condition = "input.motifplotxuanze2==2",
                        fluidRow(
                          column(
                            2,
                            downloadButton("motiffujiblastdl","Download")
                          ),
                          column(
                            2,
                            actionButton("mcsbtn_resjieshi3x","Result description",icon("file-alt"),
                                         style="color: black; background-color: #E6E6FA; border-color: #E6E6FA")
                          )
                        ),
                        #withSpinner(dataTableOutput("motiffujiblast"))
                        #div(style = 'overflow-x: scroll',withSpinner(dataTableOutput('motiffujiblast')))
                        hidden(div(id="hiddendiv6",style = 'overflow-x: scroll',withSpinner(dataTableOutput('motiffujiblast'))))
                      ),
                      conditionalPanel(
                        condition = "input.motifplotxuanze2==3",
                        uiOutput("blastmotifpwmui"),
                        #h4("The PWM (Position weight matrix) of the selected motif:"),
                        downloadButton("blastmotifpwmdfdl","Download"),
                        div(style = 'overflow-x: scroll',withSpinner(dataTableOutput('blastmotifpwmdf')))
                      )
                    ),
                    conditionalPanel(
                      condition = 'input.motiffujidfxuanze==3',
                      h5("Hints: Herein, uers should type in a protein name/uniprot id with a phosphosite (e.g. AKTS1_T246 or Q96B36_T246) below. Then PTMoreR will search the sequences across mammalian species aligned and calculate PWM (named PWM_input). After that, this tool will calculate PWMs for each human kinase in PhosphoSitePlus database (named PWM_PsP). Finally, this tool will evaluate the cosine similarity between PWM_input and PWM_PsP."),
                      hr(),
                      fluidRow(
                        column(
                          8,
                          textInput("prophosite","Please type in a protein with a phosphosite:",value = "",placeholder="AKTS1_T246")
                        ),
                        column(
                          4,
                          actionButton("prophosite_btn","Search",icon("paper-plane"),
                                       style="color:white;background-color:blue;border-color:blue;margin-top:26px")
                        )
                      ),
                      radioButtons(
                        "motifsimilarityxz",
                        label = NULL,
                        choices = list("3.1 Motif plot based on aligned results across 129 mammalian species" = 1,
                                       "3.2 Aligned table" = 2,
                                       "3.3 PWM similarity"=3),
                        selected = 1,
                        inline = TRUE
                      ),
                      conditionalPanel(
                        condition = 'input.motifsimilarityxz==1',
                        downloadButton("phositealignplotdl","Download"),
                        hidden(div(id="hiddendivv1",style = 'overflow-x: scroll',withSpinner(plotOutput('phositealignplot'))))
                      ),
                      conditionalPanel(
                        condition = 'input.motifsimilarityxz==2',
                        downloadButton("phositealigndfdl","Download"),
                        hidden(div(id="hiddendiv7",style = 'overflow-x: scroll',withSpinner(dataTableOutput('phositealigndf'))))
                      ),
                      conditionalPanel(
                        condition = 'input.motifsimilarityxz==3',
                        downloadButton("pwmsimilaritydfdl","Download"),
                        hidden(div(id="hiddendiv8",style = 'overflow-x: scroll',withSpinner(dataTableOutput('pwmsimilaritydf'))))
                      )
                    ))
              )
            ),
            column(
              width = 12,
              div(style="margin-top:0px;margin-bottom:5px;color:#C70039;font-size:120%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 5. Annotation and enrichment analysis based on Kinase-Substrate database.</b>")),
              column(
                width = 5,
                box(width = 12, inputId = "input_card5", 
                    title = strong("Input Parameters"), status = "primary", 
                    solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
                    uiOutput("kinasemotifui"),
                    div(id='genenamesif_div',checkboxInput("genenamesif","Show gene names or not?",TRUE)),
                    bsTooltip("genenamesif_div",'If true, the gene names will be appeared in the network plot, otherwise, the uniprot ids will be shown.',
                              placement = "bottom",options = list(container = "body")),
                    #uiOutput("kinasemotifui"),
                    tags$hr(style="border-color: grey;"),
                    actionButton("mcsbtn_kniase","Calculate",icon("paper-plane"),
                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))
              ),
              column(
                width = 7,
                box(width = 12, inputId = "report_card5", 
                    title = strong("Results"), status = "success", solidHeader = TRUE, 
                    collapsible = TRUE, collapsed = TRUE, closable = FALSE,
                    h4("Annotation tables:"),
                    radioButtons(
                      "annotationxuanze",
                      label = NULL,
                      choices = list("1. Uploaded peptide annotation"=1,"2. Blasted peptide annotation"=2,"3. KS enrichment analysis"=3),
                      selected = 1,
                      inline = TRUE
                    ),
                    conditionalPanel(
                      condition = "input.annotationxuanze==1|input.annotationxuanze==2",
                      fluidRow(
                        column(
                          2,
                          downloadButton("kinasedatadl","Download")
                        ),
                        column(
                          2,
                          actionButton("mcsbtn_resjieshi4","Result description",icon("file-alt"),
                                       style="color: black; background-color: #E6E6FA; border-color: #E6E6FA")
                        )
                      ),
                      #withSpinner(dataTableOutput("kinasedata")),
                      #div(style = 'overflow-x: scroll', withSpinner(dataTableOutput('kinasedata'))),
                      hidden(div(id="hiddendiv9",style = 'overflow-x: scroll', withSpinner(dataTableOutput('kinasedata')))),
                      tags$hr(style="border-color: grey;"),
                      h4("Network Plot"),
                      div(id="cmheatmap_div",checkboxInput("cmheatmap","Change figure size?",FALSE)),
                      conditionalPanel(
                        condition = "input.cmheatmap==true",
                        sliderInput("cmheatmap_height","Figure height:",min = 400,max = 5000,step = 100,value = 400)
                      ),
                      downloadButton("cmheatmappicdl","Download"),
                      #div(style = 'overflow-x:scroll;overflow-y:scroll',withSpinner(plotOutput("cmheatmappic")))
                      hidden(div(id="hiddendiv10",style = 'overflow-x:scroll;overflow-y:scroll',withSpinner(plotOutput("cmheatmappic"))))
                    ),
                    conditionalPanel(
                      condition = "input.annotationxuanze==3",
                      tabPanel(
                        "Enrichment",
                        fluidRow(
                          column(
                            2,
                            downloadButton("kinasedatadlx","Download")
                          ),
                          column(
                            2,
                            actionButton("mcsbtn_resjieshi4x","Result description",icon("file-alt"),
                                         style="color: black; background-color: #E6E6FA; border-color: #E6E6FA")
                          )
                        ),
                        #withSpinner(dataTableOutput("kinasedatax"))
                        #div(style = 'overflow-x: scroll', withSpinner(dataTableOutput('kinasedatax')))
                        hidden(div(id="hiddendiv11",style = 'overflow-x: scroll', withSpinner(dataTableOutput('kinasedatax'))))
                      )
                    ))
              )
            ),
            column(
              width = 12,
              div(style="margin-top:0px;margin-bottom:5px;color:#C70039;font-size:120%",HTML("&nbsp;&nbsp;&nbsp;&nbsp;<b>Step 6. Interaction Plot.</b>")),
              column(
                width = 5,
                box(width = 12, inputId = "input_card6", 
                    title = strong("Input Parameters"), status = "primary", 
                    solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
                    radioButtons(
                      "loaddatatype",
                      label = "",
                      choices = list("Upload experimental data" = 1,"Load example data"=2),
                      selected = 1,
                      inline = TRUE
                    ),
                    tags$hr(style="border-color: grey;"),
                    conditionalPanel(
                      condition = "input.loaddatatype==1",
                      h4("1. Expression data:"),
                      fileInput('file1', h5('1.1 Import your expression data:'),
                                accept=c('.csv')),
                      checkboxInput('header', '1.1.1 First row as column names?', TRUE),
                      checkboxInput('firstcol', '1.1.2 First column as row names?', FALSE),
                      tags$hr(style="border-color: #B2B2B2;"),
                      h4("2. Samples information:"),
                      textInput("grnums",h5("2.1 Group and replicate number:"),value = ""),
                      bsTooltip("grnums",'Type in the group number and replicate number here. Please note, the group number and replicate number are linked with ";", and the replicate number of each group is linked with "-". For example, if you have two groups, each group has three replicates, then you should type in "2;3-3" here. Similarly, if you have 3 groups with 5 replicates in every groups, you should type in "3;5-5-5".',
                                placement = "right",options = list(container = "body")),
                      textInput("grnames",h5("2.2 Group names:"),value = ""),
                      bsTooltip("grnames",'Type in the group names of your samples. Please note, the group names are linked with ";". For example, there are two groups, you can type in "Control;Experiment".',
                                placement = "right",options = list(container = "body")),
                      tags$hr(style="border-color: #B2B2B2;"),
                      h4("3. Interaction data:"),
                      fileInput('Interfile1', h5('3.1 Import interaction data:'),
                                accept=c('.csv')),
                      checkboxInput('Interheader', '3.1.1 First row as column names?', TRUE),
                      checkboxInput('Interfirstcol', '3.1.2 First column as row names?', FALSE)
                    ),
                    conditionalPanel(
                      condition = "input.loaddatatype==2",
                      downloadButton("loaddatadownload1","1. Download example expression data",style="color: #fff; background-color: #6495ED; border-color: #6495ED"),
                      tags$hr(style="border-color: grey;"),
                      #downloadButton("loaddatadownload2","Download example sample group data",style="color: #fff; background-color: #6495ED; border-color: #6495ED")
                      h4("2. Samples information:"),
                      textInput("examgrnums",h5("2.1 Group and replicate number:"),value = "6;2-2-3-3-3-3"),
                      textInput("examgrnames",h5("2.2 Group names:"),value = "0h;2h;4h;8h;12h;24h"),
                      tags$hr(style="border-color: grey;"),
                      downloadButton("interdatadownload1","3. Download example interaction data",style="color: #fff; background-color: #6495ED; border-color: #6495ED")
                    ))
              ),
              column(
                width = 7,
                box(width = 12, inputId = "report_card6",
                    title = strong("Results"), status = "success", solidHeader = TRUE,
                    collapsible = TRUE, collapsed = TRUE, closable = FALSE,
                    radioButtons(
                      "interactionxuanze",
                      label = h4(""),
                      choices = list("1. Original Expression data" = 1,"2. Processed Expression data"=2,"3. Interaction plot"=3),
                      selected = 1,
                      inline = TRUE
                    ),
                    hr(),
                    conditionalPanel(
                      condition = "input.interactionxuanze==1",
                      h4("1.1. Expression Data:"),
                      #dataTableOutput("peaksdata"),
                      div(style = 'overflow-x: scroll', dataTableOutput('peaksdata')),
                      #withSpinner(div(style = 'overflow-x: scroll', dataTableOutput('peaksdata'))),
                      hr(),
                      h4("1.2. Interaction Data:"),
                      dataTableOutput("interactiondata")
                    ),
                    conditionalPanel(
                      condition = "input.interactionxuanze==2",
                      fluidRow(
                        column(
                          3,
                          checkboxInput('mediannormif', '2.1 Median normalization or not?', TRUE),
                          bsTooltip("mediannormif",'If true, the values in expression matrix will be devided by its column median value to make the samples to have the same median. (Please note, StatsPro was not designed to perform sophisticated normalization analysis. Any normalized datasets with NA can be accepted for analysis).',
                                    placement = "right",options = list(container = "body"))
                        ),
                        column(
                          3,
                          checkboxInput('logif', '2.2 Log or not?', TRUE),
                          bsTooltip("logif",'If true, the values in expression matrix will be log-transformed with base 2.',
                                    placement = "right",options = list(container = "body"))
                        )
                      ),
                      hr(),
                      downloadButton("processedEdatadl","Download"),
                      #dataTableOutput("processedEdata")
                      div(style = 'overflow-x: scroll', withSpinner(dataTableOutput('processedEdata')))
                      #hidden(div(style = 'overflow-x: scroll', withSpinner(dataTableOutput('processedEdata'))))
                    ),
                    conditionalPanel(
                      condition = "input.interactionxuanze==3",
                      fluidRow(
                        column(
                          3,
                          textInput("sarscol",h5("3.1 Node color for the protein in the first column of the interaction data:"),value = "red")
                        ),
                        column(
                          3,
                          textInput("humanprocol",h5("3.2 Node color for the protein in the second column of the interaction data:"),value = "grey")
                        ),
                        column(
                          3,
                          textInput("interactvaluecol",h5("3.3 Node color for expression data:"),value = "blue;white;darkred"),
                          bsTooltip("interactvaluecol",'To change the pie node color, which corresponds to the intensity value in the expression data. Users should input three colour names linked with semicolons. The first one is for the lowest intensity value, the second one is for the middle intensity value, and the third one is for the highest intensity value.',
                                    placement = "right",options = list(container = "body"))
                        ),
                        column(
                          3,
                          checkboxInput('zscoreif', '3.4 Scaled expression data (Z-score) or not?', TRUE)
                        )
                      ),
                      hr(),
                      fluidRow(
                        column(
                          3,
                          uiOutput("sarsproteinsui")
                        ),
                        column(
                          3,
                          numericInput("interactfigheight",h5("3.6 Figure Height:"),400)
                        )
                      ),
                      downloadButton("interactplotdl","Download"),
                      div(style = 'overflow-x:scroll;overflow-y:scroll',withSpinner(plotOutput("interactplot")))
                      #hidden(div(style = 'overflow-x:scroll;overflow-y:scroll',withSpinner(plotOutput("interactplot"))))
                    ))
              )
            )
          )
        )
      ),
      tabItem(
        tabName = "cankaoziliao",
        column(
          12,
          box(
            title = "User Manual",
            status = "primary",
            width =  12,
            solidHeader = TRUE,
            collapsible = FALSE,
            h3("A detailed introduction of this software can be found in the Supplementary Notes:"),
            div(style="text-align:left;margin-top:10px;font-size:150%;",
                HTML("&curren;&nbsp;&nbsp;<a style='font-size:130%;font-family: 'SimHei';' href='https://github.com/wangshisheng/PTMoreR/blob/master/SupplementaryNotes.pdf' target='_blank'>https://github.com/wangshisheng/PTMoreR/blob/master/SupplementaryNotes.pdf</a><br />"))
          )
        )
      )
    )
  )
)
###########
######server.R
###########
server <- function(input, output,session) {
  options(shiny.maxRequestSize=100*1024^2)
  usertimenum<-as.numeric(Sys.time())
  #show data
  metabopath_spedf1<-read.csv("metabopath-species.csv",header = T,stringsAsFactors = F)
  metabopath_spedf<<-metabopath_spedf1[,-3]#[-2,]
  metabopath_spedf_paste<-paste(metabopath_spedf$Organism.ID,metabopath_spedf$Organism,sep = "-")
  updateSelectizeInput(session, "metabopathspeciesselect", choices = c("",metabopath_spedf_paste),
                       server = T)
  #output$metabopathspecies<-renderUI({
  #selectizeInput('metabopathspeciesselect', h5('Species:'), choices =metabopath_spedf_paste)#,options = list(maxOptions = 10)
  #})
  output$metabopathspecies2<-renderUI({
    metabopath_spedfx<-read.csv("metabopath-species.csv",header = T,stringsAsFactors = F)
    metabopath_spedf<-metabopath_spedfx[c(2,1,3:nrow(metabopath_spedfx)),]
    metabopath_spedf_paste2<-paste(metabopath_spedf$Organism.ID,metabopath_spedf$Organism,sep = "-")
    selectizeInput('metabopathspeciesselect2', h5('Species:'), choices =metabopath_spedf_paste2)#selected=metabopath_spedf_paste2,,options = list(maxOptions = 6000)
  })
  #######
  exampledataout<-reactive({
    if(input$origidatatype=="MaxQuant"){
      dataread<-read.csv("MaxQuant_Exampledata.csv",stringsAsFactors = F)
    }
    else if(input$origidatatype=="Spectronaut"){
      dataread<-read.csv("Spectronaut_Exampledata.csv",stringsAsFactors = F)
    }
    else{
      dataread<-read.csv("Normal_Exampledata.csv",stringsAsFactors = F)
    }
    dataread
  })
  output$loadseqdatadownload1<-downloadHandler(
    filename = function(){paste("Example_SequenceData_",usertimenum,".csv",sep="")},
    content = function(file){
      write.csv(exampledataout(),file,row.names = FALSE)
    }
  )
  seqrawdataoutxx<-reactive({
    if(input$uploadpaste==1){
      files <- input$metabopathfile1
      if(is.null(files)){
        dataread<-data.frame(Description="PTMoreR detects that you did not upload your data. Please upload the sequence data, or load the example data to check first.")
        dataread
      }else{
        if (input$metabopathfileType_Input == "1"){
          dataread<-read.xlsx(files$datapath,rowNames=FALSE,#input$metabopathfirstcol
                              colNames = TRUE,sheet = 1)#input$metabopathheader input$metabopathxlsxindex
        }
        else if(input$metabopathfileType_Input == "2"){
          #if(sum(input$metabopathfirstcol)==1){
          #  rownametfmetabopath<-1
          #}else{
          #  rownametfmetabopath<-NULL
          #}
          dataread<-read.xls(files$datapath,sheet = 1,header=TRUE,#input$metabopathxlsxindex input$metabopathheader,
                             row.names = NULL, sep="\t",stringsAsFactors = F)#input$metabopathsep
        }
        else{
          #if(sum(input$metabopathfirstcol)==1){
          #  rownametfmetabopath<-1
          #}else{
          #  rownametfmetabopath<-NULL
          #}
          dataread<-read.csv(files$datapath,header=TRUE,#input$metabopathheader input$metabopathsep
                             row.names = NULL, sep="\t",stringsAsFactors = F)#rownametfmetabopath
        }
      }
    }else{
      zhantieidstr<-strsplit(input$metabopath_zhantie,"\n")
      dataread<-data.frame(Input_Seqs=zhantieidstr[[1]])
    }
    dataread
  })
  output$seqrawdata<-renderDataTable({
    if(input$loadseqdatatype==1){
      dataread<-seqrawdataoutxx()
    }else{
      dataread<-exampledataout()
    }
    datatable(dataread, options = list(pageLength = 10))
  })
  
  seqrawdataout<-reactive({
    library(Biostrings)
    library(stringi)
    library(stringr)
    if(input$loadseqdatatype==1){
      dataread<-seqrawdataoutxx()
    }else{
      dataread<-exampledataout()
    }
    datareadx<-dataread
    origidatatypex<-isolate(input$origidatatype)
    Peptides<-vector()
    if(origidatatypex=="MaxQuant"){
      withProgress(message = 'Generating data', style = "notification", detail = "index 1", value = 0,{
        for(i in 1:nrow(datareadx)){
          pep1<-datareadx[[1]][i]
          Peptidesi1<-strsplit(gsub("[^0-9.]", ";", pep1),";")[[1]]
          Peptidesi2<-Peptidesi1[Peptidesi1!=""]
          for(ii in 1:length(Peptidesi2)){
            if(as.numeric(Peptidesi2[ii])>=0.75){
              pep1<-gsub(paste0("\\(",Peptidesi2[ii],"\\)"),input$centralresfuhao,pep1)#"#"
            }else{
              pep1<-gsub(paste0("\\(",Peptidesi2[ii],"\\)"),"",pep1)
            }
          }
          Peptides[i]<-pep1
          
          incProgress(1/nrow(datareadx), detail = paste("index", i))
        }
      })
      dataconvert<-data.frame(AnnotatedPeps=Peptides,stringsAsFactors = FALSE)
    }
    else if(origidatatypex=="Spectronaut"){
      withProgress(message = 'Annotated data:',min = 0, max = 2, style = "notification", detail = "Generating data", value = 1,{
        phosphoindex<-grep("\\[Phospho \\(STY\\)\\]",datareadx[[1]], perl = TRUE)
        uploaddata1<-datareadx[phosphoindex,]
        Peptidesx<-gsub("_","",uploaddata1, perl = TRUE)
        Peptidesx<-gsub("\\[Phospho \\(STY\\)\\]",input$centralresfuhao,Peptidesx, perl = TRUE)#"#"
        Peptidesx2<-str_replace_all(Peptidesx,"\\[.*?\\]","")
        
        shiny::incProgress(1, detail = "Generating data")
      })
      dataconvert<-data.frame(AnnotatedPeps=Peptidesx2,stringsAsFactors = FALSE)
    }
    else{
      dataconvert<-datareadx
    }
    dataconvertindex<-grep(input$centralresfuhao,dataconvert[[1]])
    dataconvert<-dataconvert[dataconvertindex,,drop=FALSE]
    dataconvert
  })
  #observeEvent(
  #  input$mcsbtn_seqrawdata,{
  #    output$seqannotatedata<-renderDataTable({
  #      dataread<-seqrawdataout()
  #      datatable(dataread, options = list(pageLength = 10))
  #    })
  #    output$seqannotatedatadl<-downloadHandler(
  #      filename = function(){paste("Annotated_data",usertimenum,".csv",sep="")},
  #      content = function(file){
  #        write.csv(seqrawdataout(),file,row.names=FALSE)
  #      }
  #    )
  #  }
  #)
  #
  seqbjdataout<-reactive({
    if(input$beijingif){
      files <- input$goortbeijingkufile1
      if(is.null(files)){
        dataread<-NULL
      }else{
        if (input$goortbeijingkufileType_Input == "1"){
          dataread<-read.xlsx(files$datapath,rowNames=input$goortbeijingkufirstcol,
                              colNames = input$goortbeijingkuheader,sheet = input$goortbeijingkuxlsxindex)
        }
        else if(input$goortbeijingkufileType_Input == "2"){
          if(sum(input$goortbeijingkufirstcol)==1){
            rownametfgoortbeijingku<-1
          }else{
            rownametfgoortbeijingku<-NULL
          }
          dataread<-read.xls(files$datapath,sheet = input$goortbeijingkuxlsxindex,header=input$goortbeijingkuheader,
                             row.names = rownametfgoortbeijingku, sep=input$goortbeijingkusep,stringsAsFactors = F)
        }
        else{
          if(sum(input$goortbeijingkufirstcol)==1){
            rownametfgoortbeijingku<-1
          }else{
            rownametfgoortbeijingku<-NULL
          }
          dataread<-read.csv(files$datapath,header=input$goortbeijingkuheader,
                             row.names = rownametfgoortbeijingku, sep=input$goortbeijingkusep,stringsAsFactors = F)
        }
      }
    }else{
      dataread<-NULL
    }
    dataread
  })
  output$seqbjdata<-renderDataTable({
    datareadbj<-seqbjdataout()
    datatable(datareadbj, options = list(pageLength = 10))
  })
  
  fastaseqownout<-reactive({
    files <- input$fastafileown
    if(is.null(files)){
      if(input$xuanzebgdatabase==1){
        if(input$loadseqdatatype==1){
          wuzhong<-strsplit(input$metabopathspeciesselect,"-")[[1]][1]
        }else{
          wuzhong<-strsplit(input$speciesselectrat,"-")[[1]][1]
        }
      }else{
        wuzhong<-input$wuzhongid
      }
      centralresx<<-grep("S|T|Y",input$centralres)
      RDatafiles<<-list.files("fasta/",pattern = "RData$")
      RDatafiles1<-paste0("winsSTY_",wuzhong,".RData")
      RDatafiles2<-which(RDatafiles==RDatafiles1)
      if(length(RDatafiles2)>0 & length(centralresx)>0){
        datareadfasta<-NULL
      }else{
        datafasta<-readAAStringSet(paste0("fasta/",wuzhong,".fasta"))
        pro_seqdf<-pro_seqdf1<-as.data.frame(datafasta)
        #pro_seqdf_rown<-unlist(lapply(rownames(pro_seqdf1),function(x) strsplit(x,"\\|")[[1]][2]))
        pro_seqdf_rown1<-unlist(lapply(rownames(pro_seqdf1),function(x) strsplit(x,"\\|")[[1]][1]))
        pro_seqdf_rown2<-unlist(lapply(rownames(pro_seqdf1),function(x) strsplit(x,"\\|")[[1]][2]))
        if(sum(duplicated(pro_seqdf_rown1))>=1 & sum(duplicated(pro_seqdf_rown2))>=1){
          pro_seqdf_rown<-rownames(pro_seqdf1)
        }
        else if(sum(duplicated(pro_seqdf_rown1))>=1){
          pro_seqdf_rown<-pro_seqdf_rown2
        }
        else if(sum(duplicated(pro_seqdf_rown2))>=1){
          pro_seqdf_rown<-pro_seqdf_rown1
        }
        else{
          pro_seqdf_rown<-rownames(pro_seqdf1)
        }
        rownames(pro_seqdf1)<-pro_seqdf_rown
        pro_seqdfncar<-unlist(lapply(pro_seqdf1$x,nchar))
        danlength<-input$minseqs
        pro_seqdf<-pro_seqdf1[pro_seqdfncar>(2*danlength+1),,drop=FALSE]
        n_data_fasta<-nrow(pro_seqdf)
        wincenter<-strsplit(input$centralres,"")[[1]]
        seqwindowsall_S<-vector()
        seqnamesall_S<-vector()
        wincenteri<-vector()
        k<-1
        for(ii in wincenter){
          withProgress(message = paste('Generating data',ii), style = "notification", detail = "index 1", value = 0,{
            for(i in 1:n_data_fasta){
              seqindex1<-stri_locate_all(pattern = ii, pro_seqdf$x[i], fixed = TRUE)[[1]][,1]
              if(length(seqindex1)>0){
                seqnchar<-nchar(pro_seqdf$x[i])
                seqseq<-vector()
                for(j in 1:length(seqindex1)){
                  indexjian1<-seqindex1[j]-danlength
                  indexjian2<-seqindex1[j]+danlength
                  if(indexjian1<=0){
                    xhx1<-paste(rep("_",abs(indexjian1)+1),collapse ="")
                    xhx2<-stri_sub(pro_seqdf$x[i],from = 0,to=indexjian2)
                    xhx3<-paste0(xhx1,xhx2)
                  }
                  else if(indexjian2>seqnchar){
                    xhx1<-paste(rep("_",(indexjian2-seqnchar)),collapse="")
                    xhx2<-stri_sub(pro_seqdf$x[i],from = indexjian1,to=seqnchar)
                    xhx3<-paste0(xhx2,xhx1)
                  }
                  else{
                    xhx3<-stri_sub(pro_seqdf$x[i],from = indexjian1,to=indexjian2)
                  }
                  seqwindowsall_S[k]<-xhx3
                  seqnamesall_S[k]<-rownames(pro_seqdf)[i]
                  wincenteri[k]<-ii
                  k<-k+1
                }
              }
              incProgress(1/n_data_fasta, detail = paste("index", i))
            }
          })
        }
        datareadfasta<-data.frame(ID=seqnamesall_S,Windows=seqwindowsall_S,
                                  Center=wincenteri,stringsAsFactors = F)
      }
    }else{
      datafasta<-readAAStringSet(files$datapath)
      pro_seqdf<-pro_seqdf1<-as.data.frame(datafasta)
      #pro_seqdf_rown<-unlist(lapply(rownames(pro_seqdf1),function(x) strsplit(x,"\\|")[[1]][2]))
      pro_seqdf_rown1<-unlist(lapply(rownames(pro_seqdf1),function(x) strsplit(x,"\\|")[[1]][1]))
      pro_seqdf_rown2<-unlist(lapply(rownames(pro_seqdf1),function(x) strsplit(x,"\\|")[[1]][2]))
      if(sum(duplicated(pro_seqdf_rown1))>=1 & sum(duplicated(pro_seqdf_rown2))>=1){
        pro_seqdf_rown<-rownames(pro_seqdf1)
      }
      else if(sum(duplicated(pro_seqdf_rown1))>=1){
        pro_seqdf_rown<-pro_seqdf_rown2
      }
      else if(sum(duplicated(pro_seqdf_rown2))>=1){
        pro_seqdf_rown<-pro_seqdf_rown1
      }
      else{
        pro_seqdf_rown<-rownames(pro_seqdf1)
      }
      rownames(pro_seqdf1)<-pro_seqdf_rown
      pro_seqdfncar<-unlist(lapply(pro_seqdf1$x,nchar))
      danlength<-input$minseqs
      pro_seqdf<-pro_seqdf1[pro_seqdfncar>(2*danlength+1),,drop=FALSE]
      n_data_fasta<-nrow(pro_seqdf)
      wincenter<-strsplit(input$centralres,"")[[1]]
      seqwindowsall_S<-vector()
      seqnamesall_S<-vector()
      wincenteri<-vector()
      k<-1
      for(ii in wincenter){
        withProgress(message = paste('Generating data',ii), style = "notification", detail = "index 1", value = 0,{
          for(i in 1:n_data_fasta){
            seqindex1<-stri_locate_all(pattern = ii, pro_seqdf$x[i], fixed = TRUE)[[1]][,1]
            if(length(seqindex1)>0){
              seqnchar<-nchar(pro_seqdf$x[i])
              seqseq<-vector()
              for(j in 1:length(seqindex1)){
                indexjian1<-seqindex1[j]-danlength
                indexjian2<-seqindex1[j]+danlength
                if(indexjian1<=0){
                  xhx1<-paste(rep("_",abs(indexjian1)+1),collapse ="")
                  xhx2<-stri_sub(pro_seqdf$x[i],from = 0,to=indexjian2)
                  xhx3<-paste0(xhx1,xhx2)
                }
                else if(indexjian2>seqnchar){
                  xhx1<-paste(rep("_",(indexjian2-seqnchar)),collapse="")
                  xhx2<-stri_sub(pro_seqdf$x[i],from = indexjian1,to=seqnchar)
                  xhx3<-paste0(xhx2,xhx1)
                }
                else{
                  xhx3<-stri_sub(pro_seqdf$x[i],from = indexjian1,to=indexjian2)
                }
                seqwindowsall_S[k]<-xhx3
                seqnamesall_S[k]<-rownames(pro_seqdf)[i]
                wincenteri[k]<-ii
                k<-k+1
              }
            }
            incProgress(1/n_data_fasta, detail = paste("index", i))
          }
        })
      }
      datareadfasta<-data.frame(ID=seqnamesall_S,Windows=seqwindowsall_S,
                                Center=wincenteri,stringsAsFactors = F)
    }
    datareadfasta
  })
  #
  observeEvent(input$mcsbtn_resjieshi, {
    showModal(modalDialog(
      title = "Pre-alignment result description:",
      paste0("1. Pep.upload: this column contains those peptides users upload."),br(),
      paste0("2. Stripped.pep: the peptide skeleton."),br(),
      paste0("3. Pep.main.index: the position of the main modified amino acid in the peptide, for example, if users upload their peptides containing Class I phosphorylation sites with high confidence, such as 'TSLWNPT#Y@GSWFTEK', then this software will recognize '#' as Class I phosphorylation site and '@' as non-Class I phosphorylation site by default, so the Pep.main.index will be 7."),br(),
      paste0("4. Pep.all.index: the position of all modified amino acid in the peptide. As the example in Pep.main.index, the Pep.all.index will be 7;8."),br(),
      paste0("5. Center.amino.acid: the central amino acid in the aligned peptide."),br(),
      paste0("6. Seqwindows: the aligned standard peptides. Note for multiple modification sites or types, the column provides peptides with all the sites respectively centered."),br(),
      paste0("7. PRO.from.Database: provide the protein name containing this peptide from the fasta file the user uploaded."),br(),
      paste0("8. PROindex.from.Database: the position of modified amino acid in the protein sequence."),br(),
      paste0("9. PRO.CombinedID: Combining the protein ID, Center.amino.acid and PROindex.from.Database together with '_'."),br(),
      paste0("10. Contain.if: whether containing the sequences that match the regular expression (see above), if true, marked with 'Yes', otherwise, 'No'. This column only appears when users choose the parameter--- Check if containing some regular sequence."),
      size ="l",
      easyClose = TRUE,
      footer = modalButton("Cancel")
    ))
  })
  observeEvent(input$mcsbtn_resjieshi2, {
    showModal(modalDialog(
      title = "Pre-alignment result description:",
      paste0("1. Pep.upload: this column contains those peptides users upload."),br(),
      paste0("2. Stripped.pep: the peptide skeleton."),br(),
      paste0("3. Pep.main.index: the position of the main modified amino acid in the peptide, for example, if users upload their peptides containing Class I phosphorylation sites with high confidence, such as 'TSLWNPT#Y@GSWFTEK', then this software will recognize '#' as Class I phosphorylation site and '@' as non-Class I phosphorylation site by default, so the Pep.main.index will be 7."),br(),
      paste0("4. Pep.all.index: the position of all modified amino acid in the peptide. As the example in Pep.main.index, the Pep.all.index will be 7;8."),br(),
      paste0("5. Center.amino.acid: the central amino acid in the aligned peptide."),br(),
      paste0("6. Seqwindows: the aligned standard peptides. Note for multiple modification sites or types, the column provides peptides with all the sites respectively centered."),br(),
      paste0("7. PRO.from.Database: provide the protein name containing this peptide from the fasta file the user uploaded."),br(),
      paste0("8. PROindex.from.Database: the position of modified amino acid in the protein sequence."),br(),
      paste0("9. Contain.if: whether containing the sequences that match the regular expression (see above), if true, marked with 'Yes', otherwise, 'No'. This column only appears when users choose the parameter---Check if containing some regular sequence."),br(),
      paste0("10. Seqwindows_MultiSites: there are two situations here: First, the modified amino acid will be replaced with 'X' if it is not the central residue, for example, 'NKPTSLWNPT(0.832)Y(0.168)GSWFTEK' has two phosphosites, one is the 10th amino acid with 0.832 location probability, the other is the 11th amino acid with 0.168 location probability, thus if we transform it like 'NKPTSLWNPT#Y@GSWFTEK' (high probability is replaced with '#', while low probability is replaced with '@'). Then in PTMoreR, the 10th amino acid will be considered as central residue, the 11th amino acid will be replaced with 'X', thus the standard sequence is 'PTSLWNPTYGSWFTE', correspondingly, the Seqwindows_MultiSites should be 'PTSLWNPTXGSWFTE'. Second, if we transform this peptide like 'NKPTSLWNPT#Y#GSWFTEK', the two amino acids will be both considered as central residue, thus the standard sequence is 'PTSLWNPTYGSWFTE;TSLWNPTYGSWFTEK', correspondingly, the Seqwindows_MultiSites is still 'PTSLWNPTYGSWFTE;TSLWNPTYGSWFTEK'."),
      size ="l",
      easyClose = TRUE,
      footer = modalButton("Cancel")
    ))
  })
  observeEvent(input$mcsbtn_resjieshi2_1, {
    showModal(modalDialog(
      title = "The blast result description:",
      paste0("1. Pep.upload: this column contains those peptides users upload."),br(),
      paste0("2. Stripped.pep: the peptide skeleton."),br(),
      paste0("3. Pep.main.index: the position of the main modified amino acid in the peptide, for example, if users upload their peptides containing Class I phosphorylation sites with high confidence, such as 'TSLWNPT#Y@GSWFTEK', then this software will recognize '#' as Class I phosphorylation site and '@' as non-Class I phosphorylation site by default, so the Pep.main.index will be 7."),br(),
      paste0("4. Pep.all.index: the position of all modified amino acid in the peptide. As the example in Pep.main.index, the Pep.all.index will be 7;8."),br(),
      paste0("5. Center.amino.acid: the central amino acid in the aligned peptide."),br(),
      paste0("6. Seqwindows: the aligned standard peptides."),br(),
      paste0("7. PRO.from.Database: provide the protein ID/name containing this peptide from the fasta file the user uploaded."),br(),
      paste0("8. PROindex.from.Database: the position of modified amino acid in the protein sequence."),br(),
      paste0("9. PRO.CombinedID: Combining the protein ID, Center.amino.acid and PROindex.from.Database together with '_'."),br(),
      paste0("10. Contain.if: whether containing the sequences that match the regular expression (see above), if true, marked with 'Yes', otherwise, 'No'. This column only appears when users choose the parameter---Check if containing some regular sequence (in step2)."),br(),
      paste0("11. Center.amino.acids.Other: the central amino acid mapped from the human peptides."),br(),
      paste0("12. Seqwindows.Other: the standard peptides mapped from the human peptides."),br(),
      paste0("13. PRO.from.Other: the protein ID/name from the mapped human protein."),br(),
      paste0("14. PROindex.from.Other: the position of modified amino acid in the mapped human protein sequence."),br(),
      paste0("15. PRO.CombinedID.Other: Combining the PRO.from.Other, Center.amino.acids.Other and PROindex.from.Other together with '_'."),br(),
      paste0("16. Center.aa.match: The matching degree of central amino acids (CAAs) when the uploaded peptides are blasted to Human protein sequences. 1. Exact matching: The CAAs are same, for example, the CAA is 'S' in the uploaded peptides and the CAA is also 'S' in the blasted sequence. 2. Fuzzy matching: For example, the CAA is 'S' in the uploaded peptides and the CAA could be 'S', 'T', or 'Y' in the blasted sequence. All: Reporting all results."),br(),
      paste0("17. Window.similarity: The similarity of sequence windows between the uploaded peptides and the blasted peptides. For example, if there are 15 amino acids in one sequence window, 7 here means there are 7 amino acids are exactly same (amino acids names and positions in both windows are all same)."),br(),
      paste0("18. BLOSUM50.Score: BLOSUM50 means that the matrix was built using blocks of aligned sequences that had no more than 50% identity, which is used to score alignments between evolutionarily divergent protein sequences."),br(),
      size ="l",
      easyClose = TRUE,
      footer = modalButton("Cancel")
    ))
  })
  observeEvent(input$mcsbtn_resjieshi3, {
    showModal(modalDialog(
      title = "Uploaded motif Enrichment result description:",
      paste0("1. motif: the overrepresented motif."),br(),
      paste0("2. score: the motif score, which is calculated by taking the sum of the negative log probabilities used to fix each position of the motif. Higher motif scores typically correspond to motifs that are more statistically significant as well as more specific."),br(),
      paste0("3. fg.matches: frequency of sequences matching this motif in the foreground set."),br(),
      paste0("4. fg.size: total number of foreground sequences."),br(),
      paste0("5. bg.matches: frequency of sequences matching this motif in the background set."),br(),
      paste0("6. bg.size: total number of background sequences."),br(),
      paste0("7. fold.increase: An indicator of the enrichment level of the extracted motifs. Specifically, it is calculated as (foreground matches/foreground size)/(background matches/background size)."),br(),
      paste0("8. Enrich.seq: those peptides are overrepresented in this motif."),br(),
      paste0("9. Enrich.pro: those proteins in which the peptides exist from Enrich.seq."),
      size ="l",
      easyClose = TRUE,
      footer = modalButton("Cancel")
    ))
  })
  observeEvent(input$mcsbtn_resjieshi3x, {
    showModal(modalDialog(
      title = "Blasted motif Enrichment result description:",
      paste0("1. motif: the overrepresented motif."),br(),
      paste0("2. score: the motif score, which is calculated by taking the sum of the negative log probabilities used to fix each position of the motif. Higher motif scores typically correspond to motifs that are more statistically significant as well as more specific."),br(),
      paste0("3. fg.matches: frequency of sequences matching this motif in the foreground set."),br(),
      paste0("4. fg.size: total number of foreground sequences."),br(),
      paste0("5. bg.matches: frequency of sequences matching this motif in the background set."),br(),
      paste0("6. bg.size: total number of background sequences."),br(),
      paste0("7. fold.increase: An indicator of the enrichment level of the extracted motifs. Specifically, it is calculated as (foreground matches/foreground size)/(background matches/background size)."),br(),
      paste0("8. Enrich.seq: those peptides are overrepresented in this motif."),br(),
      paste0("9. Enrich.pro: those proteins in which the peptides exist from Enrich.seq."),
      size ="l",
      easyClose = TRUE,
      footer = modalButton("Cancel")
    ))
  })
  observeEvent(input$mcsbtn_resjieshi4, {
    showModal(modalDialog(
      title = "Kinase-substrate annotation result description:",
      paste0("1. KIN_ACC_ID: kinase uniprot id."),br(),
      paste0("2. SUB_ACC_ID: substrate uniprot id."),br(),
      paste0("3. Pep.upload: the original peptide."),br(),
      paste0("4. Pep.all.index: the position of all modified amino acid in the peptide."),br(),
      paste0("5. Center.amino.acid: the central amino acid in the aligned peptide. Or, Center.amino.acids.Other: the central amino acid mapped from the human peptides."),br(),
      paste0("6. Seqwindows: the aligned standard peptides. Or, Seqwindows.Other: the standard peptides mapped from the human peptides."),br(),
      paste0("7. PROindex.from.Database: the position of modified amino acid in the protein sequence. Or, PROindex.from.Other: the position of modified amino acid in the mapped human protein sequence."),br(),
      #paste0("2. KINASE: kinase id."),br(),
      paste0("8. GENE: kinase gene name."),br(),
      #paste0("4. SUBSTRATE: substrate id."),br(),
      paste0("9. SUB_GENE: substrate gene name."),br(),
      #paste0("7. networkin_score: the prediction score from networKIN database (https://networkin.info/)."),br(),
      #paste0("8. Enrich.seq: the peptide that is overrepresented in the relevant motif."),br(),
      #paste0("9. Motif: the overrepresented motif."),br(),
      #paste0("12. PROindex.from.Database: the position of modified amino acid in the protein sequence."),br(),
      size ="l",
      easyClose = TRUE,
      footer = modalButton("Cancel")
    ))
  })
  observeEvent(input$mcsbtn_resjieshi4x,{
    showModal(modalDialog(
      title = "Kinase-substrate enrichment analysis result description:",
      paste0("1. Kinases.ID: Kinase uniprot ids."),br(),
      paste0("2. Kinases: Kinase gene names."),br(),
      paste0("3. KS.Ratio: k/n, k means the overlap between phosphosites-of-interest and the uploaded phosphosite set, n means the number of all unique phosphosites-of-interest."),br(),
      paste0("4. Bg.Ratio: M/N, M means the number of substrate phosphosites of each kinase in the whole phosphosite set, N means the number of phosphosites in the whole phosphosite set."),br(),
      paste0("5. SubstrateNum: Same as k."),br(),
      paste0("6. Direction: If KS.Ratio >= Bg.Ratio, the value is 'greater', otherwise, 'less'."),br(),
      paste0("7. P.val: Original P value obtained from Fisher test."),br(),
      #paste0("2. KINASE: kinase id."),br(),
      paste0("8. P.adj: Adjusted P value based on the BH method."),br(),
      #paste0("4. SUBSTRATE: substrate id."),br(),
      paste0("9. Substrates: Substrate phosphosites-of-interest."),br(),
      #paste0("7. networkin_score: the prediction score from networKIN database (https://networkin.info/)."),br(),
      #paste0("8. Enrich.seq: the peptide that is overrepresented in the relevant motif."),br(),
      #paste0("9. Motif: the overrepresented motif."),br(),
      #paste0("12. PROindex.from.Database: the position of modified amino acid in the protein sequence."),br(),
      size ="l",
      easyClose = TRUE,
      footer = modalButton("Cancel")
    ))
  })
  observeEvent(input$mcsbtn_resjieshi5, {
    showModal(modalDialog(
      title = "Building species database result description:",
      paste0("1. ID: uniprot ids."),br(),
      paste0("2. Windows: the standard peptides."),br(),
      paste0("3. Center: Central residue."),br(),
      size ="l",
      easyClose = TRUE,
      footer = modalButton("Cancel")
    ))
  })
  seqduiqioutx<-reactive({
    #uploaddata1<-uploaddata2<-datareaddq<-seqrawdataout()
    uploaddata2<-seqrawdataout()
    if(ncol(uploaddata2)==1){
      uploaddata1<-datareaddq<-uploaddata2
    }else{
      uploaddata1<-datareaddq<-uploaddata2[,2,drop=F]
    }
    if(TRUE){#input$seqalignif
      centralres1<-strsplit(input$centralresfuhao,";|")[[1]]
      centralres<-centralres1[centralres1!=""]
      centralres2<-paste(centralres,collapse = "|")
      uploaddata1$Stripped.pep<-gsub(paste0("_|",centralres2),"",datareaddq[[1]], perl = TRUE)
      EGindex<-lapply(datareaddq[[1]],function(x){
        xx4<-gregexpr(centralres[1],x)[[1]]
        xx3<-gregexpr(centralres2,x)[[1]]
        xx5<-unlist(lapply(xx4,function(x) which(x==xx3)))
        xx1<-1:length(xx3)
        xx6<-as.numeric(xx3)-xx1
        xx2<-paste(xx6[xx5],collapse = ";")
        xx2
      })
      EGindex1<-lapply(datareaddq[[1]],function(x){
        xx3<-gregexpr(centralres2,x)[[1]]
        xx1<-1:length(xx3)
        xx6<-as.numeric(xx3)-xx1
        xx2<-paste(xx6,collapse = ";")
        xx2
      })
      centeranjisuan<-lapply(datareaddq[[1]],function(x){
        pepi<-strsplit(gsub(centralres2,"",x),"")[[1]]
        xx4<-gregexpr(centralres[1],x)[[1]]
        xx3<-gregexpr(centralres2,x)[[1]]
        xx5<-unlist(lapply(xx4,function(x) which(x==xx3)))
        xx1<-1:length(xx3)
        xx6<-as.numeric(xx3)-xx1
        xx2<-paste(pepi[xx6[xx5]],collapse = ";")
        xx2
      })
      uploaddata1$Pep.main.index<-unlist(EGindex)
      uploaddata1$Pep.all.index<-unlist(EGindex1)
      uploaddata1$Center.amino.acid<-unlist(centeranjisuan)
      colnames(uploaddata1)<-c("Pep.upload","Stripped.pep","Pep.main.index","Pep.all.index","Center.amino.acid")
      uploaddata1<<-uploaddata1
      if(input$xuanzebgdatabase==1){
        if(input$loadseqdatatype==1){
          wuzhong<<-strsplit(input$metabopathspeciesselect,"-")[[1]][1]
        }else{
          wuzhong<<-strsplit(input$speciesselectrat,"-")[[1]][1]
        }
        if(is.na(wuzhong)){
          stop("Please select one background dataset or upload a fasta file as background dataset in the 'Import Data' step!")
        }else{
          fastafiles<<-list.files("fasta/",pattern = "fasta$")#metabopath_spedf1
          fastafiles1<-which(fastafiles==paste0(wuzhong,".fasta"))
          if(length(fastafiles1)>0){
            datafasta<-readAAStringSet(paste0("fasta/",wuzhong,".fasta"))
          }else{
            #library(UniprotR)
            baseUrl <- "https://rest.uniprot.org/uniprotkb/stream?format=fasta&query=proteome:"
            Proteome_IDx<-metabopath_spedf1$Proteome_ID[which(metabopath_spedf1$Organism.ID==wuzhong)]
            baseUrl1<-paste0(baseUrl,Proteome_IDx)
            withProgress(message = 'Downloading fasta file, wait a moment...', style = "notification", detail = "", value = 0,{
              incProgress(1/2, detail = "")
              download.file(baseUrl1, paste0("fasta/",wuzhong,".fasta"),quiet = TRUE)
            })
            datafasta<-readAAStringSet(paste0("fasta/",wuzhong,".fasta"))
          }
        }
      }else{
        wuzhong<-input$wuzhongid
        files <- isolate(input$fastafileown)
        if(is.null(files)){
          stop("Please select one background dataset or upload a fasta file as background dataset in the 'Import Data' step!")
        }else{
          datafasta<-readAAStringSet(files$datapath)
        }
      }
      n_data_fasta<<-length(datafasta@ranges@NAMES)
      pro_seqdf<<-as.data.frame(datafasta)
      pro_seqdfnames<-unlist(lapply(rownames(pro_seqdf),function(x) strsplit(x,"\\|")[[1]][2]))
      if(sum(is.na(pro_seqdfnames))>n_data_fasta/2){
        pro_seqdfnames<-unlist(lapply(rownames(pro_seqdf),function(x) strsplit(x,"\\ ")[[1]][1]))
      }
      danlength<<-input$minseqs
      seqseqall<-vector()
      proidall<-vector()
      proidindexall<-vector()
      PRO.CombinedID<-vector()
      withProgress(message = 'Generating data', style = "notification", detail = "index 1", value = 0,{
        for(i in 1:nrow(uploaddata1)){
          seqindex1<-grep(uploaddata1$Stripped.pep[i],pro_seqdf$x, perl = TRUE)
          seqindex3<-as.numeric(strsplit(uploaddata1$Pep.main.index[i],";")[[1]])
          seqseqall1<-vector()
          proidindexall1<-vector()
          procomb<-vector()
          if(length(seqindex1)>0 & length(seqindex3)>0){
            for(k in 1:length(seqindex1)){
              #stri_locate_all
              seqindex2<-stri_locate_first(pattern = uploaddata1$Stripped.pep[i], pro_seqdf$x[seqindex1[k]], fixed = TRUE)[[1]][1]#[,1]
              seqnchar<-nchar(pro_seqdf$x[seqindex1[k]])
              indexjian<-unlist(lapply(seqindex2, function(x){x+seqindex3-1}))
              seqseq<-vector()
              for(j in 1:length(indexjian)){
                indexjian1<-indexjian[j]-danlength
                indexjian2<-indexjian[j]+danlength
                if(indexjian1<=0){
                  xhx1<-paste(rep("_",abs(indexjian1)+1),collapse ="")
                  xhx2<-stri_sub(pro_seqdf$x[seqindex1[k]],from = 0,to=indexjian2)
                  xhx3<-paste0(xhx1,xhx2)
                }
                else if(indexjian2>seqnchar){
                  xhx1<-paste(rep("_",(indexjian2-seqnchar)),collapse="")
                  xhx2<-stri_sub(pro_seqdf$x[seqindex1[k]],from = indexjian1,to=seqnchar)
                  xhx3<-paste0(xhx2,xhx1)
                }
                else{
                  xhx3<-stri_sub(pro_seqdf$x[seqindex1[k]],from = indexjian1,to=indexjian2)
                }
                seqseq[j]<-xhx3
              }
              seqseqall1[k]<-paste(seqseq,collapse = ";")
              proidindexall1[k]<-paste(indexjian,collapse = ";")
              procomb[k]<-paste(paste0(pro_seqdfnames[seqindex1[k]],"_",strsplit(uploaddata1$Center.amino.acid[i],";")[[1]],indexjian),collapse = ";")
            }
            seqseqall[i]<-paste(seqseqall1,collapse = "::")#"_",";"
            proidall[i]<-paste(pro_seqdfnames[seqindex1],collapse = "::")
            proidindexall[i]<-paste(proidindexall1,collapse = "::")
            PRO.CombinedID[i]<-paste(procomb,collapse = "::")
            #PRO.CombinedID[i]<-paste(paste0(pro_seqdfnames[seqindex1],"_",
            #                                strsplit(uploaddata1$Center.amino.acid[i],";")[[1]],
            #                                strsplit(proidindexall1,";")[[1]]),
            #                         collapse = "::")
          }else{
            seqseqall[i]<-"No Match"
            proidall[i]<-"No Match"
            proidindexall[i]<-"No Match"
            PRO.CombinedID[i]<-"No Match"
          }
          
          incProgress(1/nrow(uploaddata1), detail = paste("index", i))
        }
      })
      
      uploaddata1$Seqwindows<-seqseqall
      uploaddata1$PRO.from.Database<-proidall
      uploaddata1$PROindex.from.Database<-proidindexall
      uploaddata1$PRO.CombinedID<-PRO.CombinedID
      datareaddq<-uploaddata1
    }
    
    if(input$seqalignhanif){#FALSE
      containif<-rep("No",nrow(datareaddq))
      if(ncol(datareaddq)==1){
        containif[grep(input$seqalignhan,datareaddq[[1]])]<-"Yes"
      }else{
        containif[grep(input$seqalignhan,datareaddq$Seqwindows)]<-"Yes"
      }
      datareaddq$Contain.if<-containif
    }
    if(ncol(datareaddq)>2){
      datareaddqxx<-datareaddq[datareaddq$Seqwindows!="No Match",]
    }else{
      datareaddqxx<-datareaddq
    }
    if(ncol(uploaddata2)==1){
      datareaddqxx1<-datareaddqxx
    }else{
      datareaddqxx2<-datareaddqxx[datareaddqxx$PRO.from.Database%in%uploaddata2[[1]],]
      if(nrow(datareaddqxx2)>0){
        datareaddqxx1<-datareaddqxx2
      }else{
        datareaddqxx1<-datareaddqxx
      }
    }
    datareaddqxx1
  })
  seqduiqiduositeout<-reactive({
    datareaddq<-datareaddqxx<-seqduiqioutx()#isolate(seqduiqioutx())
    sitesnum<-unlist(lapply(datareaddq$Pep.all.index,function(x){
      length(strsplit(x,";")[[1]])
    }))
    if(is.null(sitesnum)){
      datareaddqx<-matrix(ncol = 1, nrow = 0)
    }else{
      datareaddqx<-datareaddqx1<-datareaddq[sitesnum>1,]
    }
    if(nrow(datareaddqx)>0){
      Seqwindows_MultiSites<-vector()
      withProgress(message = 'Generating data', style = "notification", detail = "index 1", value = 0,{
        for(i in 1:nrow(datareaddqx)){
          pepindexi1<-as.numeric(strsplit(datareaddqx$Pep.all.index[i],";")[[1]])
          pepindexi2<-as.numeric(strsplit(datareaddqx$Pep.main.index[i],";")[[1]])
          pepindexi<-setdiff(pepindexi1,pepindexi2)
          seqwindowi<-strsplit(datareaddqx$Seqwindows[i],";")[[1]]
          
          Seqwindows_multix<-vector()
          for(ii in 1:length(pepindexi2)){
            seqwindowix<-strsplit(seqwindowi[ii],"")[[1]]
            if(length(pepindexi)>0){
              posi<-input$minseqs+1+(pepindexi-pepindexi2[ii])
              posi_low<-which(posi>length(seqwindowix) | posi<1)
              if(length(posi_low)>0){
                seqwindowix[posi[-posi_low]]<-"X"
              }else{
                seqwindowix[posi]<-"X"
              }
              Seqwindows_multix[ii]<-paste(seqwindowix,collapse ="")
            }else{
              Seqwindows_multix[ii]<-seqwindowi[ii]
            }
          }
          Seqwindows_MultiSites[i]<-paste(Seqwindows_multix,collapse =";")
          incProgress(1/nrow(datareaddqx), detail = paste("index", i))
        }
        datareaddqx$Seqwindows_MultiSites<-Seqwindows_MultiSites
      })
      if(FALSE){#!input$classicmultisiteif
        sitesnum_main<-unlist(lapply(datareaddqx$Pep.main.index,function(x){
          length(strsplit(x,";")[[1]])
        }))
        datareaddqx2<-datareaddqx[sitesnum_main>1,]
        Seqwindows_MultiSites_main<-vector()
        withProgress(message = 'Generating data', style = "notification", detail = "index 1", value = 0,{
          for(i in 1:nrow(datareaddqx2)){
            pepindexi2<-as.numeric(strsplit(datareaddqx2$Pep.main.index[i],";")[[1]])
            seqwindowi<-strsplit(datareaddqx2$Seqwindows[i],";")[[1]]
            
            Seqwindows_multix_main<-vector()
            for(ii in 1:length(pepindexi2)){
              seqwindowix<-strsplit(seqwindowi[ii],"")[[1]]
              posi<-input$minseqs+1+(pepindexi2[-ii]-pepindexi2[ii])
              posi_low<-which(posi>length(seqwindowix) | posi<1)
              if(length(posi_low)>0){
                seqwindowix[posi[-posi_low]]<-"Z"
              }else{
                seqwindowix[posi]<-"Z"
              }
              Seqwindows_multix_main[ii]<-paste(seqwindowix,collapse ="")
              
            }
            Seqwindows_MultiSites_main[i]<-paste(Seqwindows_multix_main,collapse =";")
            incProgress(1/nrow(datareaddqx2), detail = paste("index", i))
          }
          datareaddqx$Seqwindows_MultiSites[which(sitesnum_main>1)]<-Seqwindows_MultiSites_main
        })
        #datareaddq_all1<-datareaddq[sitesnum<=1,]
        #datareaddq_all<-rbind(datareaddq_all1,datareaddqx)
      }
    }else{
      datareaddqx<-NULL
    }
    datareaddqx
    #list(datareaddq_all=datareaddq_all,datareaddq_multi=datareaddqx)
  })
  seqduiqiout<-reactive({
    duiqidfall1<-seqduiqioutx()#isolate(seqduiqioutx())
    datareaddq_multi1<-isolate(seqduiqiduositeout())
    if(is.null(datareaddq_multi1)){
      duiqidfall<-duiqidfall1
    }else{
      datareaddq_multi1$Seqwindows<-datareaddq_multi1$Seqwindows_MultiSites
      sitesnum<-unlist(lapply(duiqidfall1$Pep.main.index,function(x){
        length(strsplit(x,";")[[1]])
      }))
      if(FALSE){#!input$classicmultisiteif
        datareaddq_all1<-duiqidfall1[sitesnum<=1,]
        duiqidfall<-rbind(datareaddq_all1,datareaddq_multi1[,-ncol(datareaddq_multi1)])
      }else{
        duiqidfall<-duiqidfall1
      }
    }
    unique(duiqidfall)
  })
  #seqduiqievent<-eventReactive(input$mcsbtn_seqalign,{
  #  if(input$loadseqdatatype==1){
  #    datareaddq<-seqduiqiout()
  #  }else{
  #    datareaddq<-read.csv("Prealign_data.csv",stringsAsFactors = F)
  #  }
  #  datareaddq
  #})
  seqduiqievent<-reactive({
    if(input$loadseqdatatype==1){
      datareaddq<-seqduiqiout()
    }else{
      datareaddq<-read.csv("Prealign_data.csv",stringsAsFactors = F)
    }
    datareaddq
  })
  observeEvent(
    input$mcsbtn_seqalign,{
      shinyjs::show(id = "hiddendiv1", anim = FALSE)
      output$seqduiqi<-renderDataTable({
        datareaddq<-seqduiqievent()#isolate(seqduiqiout())
        datatable(datareaddq, options = list(pageLength = 10))
      })
      output$seqduiqidl<-downloadHandler(
        filename = function(){paste("Prealign_data",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(seqduiqievent(),file,row.names=FALSE)
        }
      )
    }
  )
  
  output$seqduiqiplot<-renderPlot({
    library(ggsci)
    library(ggplot2)
    library(ggrepel)
    colpalettes<-unique(c(pal_npg("nrc")(10),pal_aaas("default")(10)))
    datareaddq<-seqduiqievent()#isolate(seqduiqiout())
    sitesnum<-unlist(lapply(datareaddq$Pep.all.index,function(x){
      length(strsplit(x,";")[[1]])
    }))
    if(is.null(sitesnum)){
      plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
      text(x = 0.34, y = 0.9, paste("No plot here~~"),
           cex = 1.5, col = "black", family="serif", font=2, adj=0.5)
    }else{
      datareaddq1<-as.data.frame(table(sitesnum))
      ggplot(datareaddq1,aes(x=sitesnum,y=Freq, group=1))+
        geom_bar(stat = "identity",col=colpalettes[1:nrow(datareaddq1)],fill=colpalettes[1:nrow(datareaddq1)],alpha=0.8)+
        geom_line(size=1.5,col=colpalettes[17]) +
        geom_point(size=6, col=colpalettes[16],shape=18)+
        geom_text_repel(aes(label=Freq),size=6)+
        labs(x="Sites Number",y="Counts",title = "Distribution of Modification Sites")+
        theme_bw()
    }
  })
  seqduiqiplotout<-reactive({
    library(ggsci)
    library(ggplot2)
    colpalettes<-unique(c(pal_npg("nrc")(10),pal_aaas("default")(10)))
    datareaddq<-seqduiqievent()#isolate(seqduiqiout())
    sitesnum<-unlist(lapply(datareaddq$Pep.all.index,function(x){
      length(strsplit(x,";")[[1]])
    }))
    datareaddq1<-as.data.frame(table(sitesnum))
    ggplot(datareaddq1,aes(x=sitesnum,y=Freq, group=1))+
      geom_bar(stat = "identity",col=colpalettes[1:nrow(datareaddq1)],fill=colpalettes[1:nrow(datareaddq1)],alpha=0.8)+
      geom_line(size=1.5,col=colpalettes[17]) +
      geom_point(size=6, col=colpalettes[16],shape=18)+
      geom_text_repel(aes(label=Freq),size=6)+
      labs(x="Sites Number",y="Counts",title = "Distribution of Modification Sites")+
      theme_bw()
  })
  output$seqduiqiplotdl<-downloadHandler(
    filename = function(){paste("SiteNumplot",usertimenum,".pdf",sep="")},
    content = function(file){
      pdf(file, width = 7,height = 7)
      print(seqduiqiplotout())
      dev.off()
    }
  )
  
  output$seqduiqiduosite<-renderDataTable({
    datatable(seqduiqiduositeout())
  })
  output$seqduiqiduositedl<-downloadHandler(
    filename = function(){paste("Prealign_MultiSites_data",usertimenum,".csv",sep="")},
    content = function(file){
      write.csv(seqduiqiduositeout(),file,row.names=FALSE)
    }
  )
  ##blast
  blastres1out<-reactive({
    library(metablastr)
    library(msa)
    if(input$xuanzebgdatabase==1){
      if(input$loadseqdatatype==1){
        wuzhong<-strsplit(input$metabopathspeciesselect,"-")[[1]][1]
      }else{
        wuzhong<-strsplit(input$speciesselectrat,"-")[[1]][1]
      }
      if(is.na(wuzhong)){
        stop("Please select or upload one a fasta file as background dataset!")
      }else{
        datafasta<-paste0("fasta/",wuzhong,".fasta")#readAAStringSet(paste0("fasta/",wuzhong,".fasta"))
      }
    }else{
      wuzhong<<-input$wuzhongid
      files <<- isolate(input$fastafileown)
      if(is.null(files)){
        stop("Please select or upload one a fasta file as background dataset!")
      }else{
        datafasta<-files$datapath#readAAStringSet(files$datapath)
      }
    }
    if(TRUE){#isolate(input$preblastif)
      #if(input$wuzhong2id==""){
      #  wuzhong2<<-"9606"
      #}else{
      #  wuzhong2<<-input$wuzhong2id
      #}
      #if(is.null(input$preblastbetweentwo)){
      #  datafasta2<-"fasta/9606.fasta"
      #  blast_best_other<<-read.csv(paste0(wuzhong,"_blast_best_9606.csv"),stringsAsFactors = FALSE)
      #}else{
      #  #load(paste("temp/",input$preblastbetweentwo,sep=""))
      #  load(input$preblastbetweentwo$datapath)
      #}
      datafasta2<-"fasta/9606.fasta"
      wuzhong2<<-"9606"
      blastfiles<<-list.files("percentdatabase/",pattern = "csv$")
      blastfiles1<-which(blastfiles==paste0(wuzhong,"_blast_best_9606.csv"))
      if(length(blastfiles1)>0){
        if(input$blastbesthit==1){
          blast_best_other<<-read.csv(paste0("percentdatabase/",wuzhong,"_blast_best_9606.csv"),stringsAsFactors = FALSE)
        }else{
          blast_best_other<<-read.csv(paste0("aligndatabase/",wuzhong,"_blast_best_9606.csv"),stringsAsFactors = FALSE)
        }
      }else{
        get_best_hit <- function(x) {
          min_val <- min(x$evalue)
          evalue <- perc_identity <- NULL
          res <- dplyr::filter(x, evalue == min_val)
          if (nrow(res) > 1) {
            #max_len <- max(res$alig_length)
            max_len <- max(res$perc_identity)
            res <- dplyr::filter(res, perc_identity == max_len)
          }
          if (nrow(res) > 1) 
            res <- dplyr::slice(res, 1)
          return(res)
        }
        withProgress(message = 'Blasting:',min = 0, max = 2, style = "notification", detail = "It will take about 1 hour......Please have a cup of coffee.", value = 1,{
          blast_best_other <<- blast_best_hit(
            query   = datafasta,
            subject = datafasta2,
            task="blastp",
            search_type = "protein_to_protein",
            cores = 8,
            db.import  = FALSE)
          blast_best_other$query_id<-unlist(lapply(blast_best_other$query_id,function(x){
            strsplit(x,"\\|")[[1]][2]
          }))
          blast_best_other$subject_id<-unlist(lapply(blast_best_other$subject_id,function(x){
            strsplit(x,"\\|")[[1]][2]
          }))
          shiny::incProgress(1, detail = "Generating data...")
        })
      }
      blast_best_other$query_id<-unlist(lapply(blast_best_other$query_id,function(x){
        strsplit(x,"\\|")[[1]][2]
      }))
      blast_best_other$subject_id<-unlist(lapply(blast_best_other$subject_id,function(x){
        strsplit(x,"\\|")[[1]][2]
      }))
      #save(blast_best_other,file = paste("temp/Blast.Between.Two.Species.",wuzhong,".",wuzhong2,"_",usertimenum,".RData",sep=""))
      #blast_best_other<-blast_best_other[blast_best_other$evalue<=input$evalueyuzhi,1:3]
    }else{
      if(input$xuanzebgdatabase2==1){
        wuzhong2<<-strsplit(isolate(input$metabopathspeciesselect2),"-")[[1]][1]
        if(is.na(wuzhong2)){
          stop("Please select or upload one a fasta file as background dataset!")
        }else{
          datafasta2<<-paste0("fasta/",wuzhong2,".fasta")#readAAStringSet(paste0("fasta/",wuzhong,".fasta"))
        }
      }else{
        wuzhong2<<-input$wuzhongid2
        files2 <<- isolate(input$fastafileown2)
        if(is.null(files2)){
          stop("Please select or upload one a fasta file as background dataset!")
        }else{
          datafasta2<<-files2$datapath#readAAStringSet(files$datapath)
        }
      }
      withProgress(message = 'Blasting:',min = 0, max = 2, style = "notification", detail = "It will take about 1 hour......Please have a cup of coffee.", value = 1,{
        blast_best_other <<- blast_best_hit(
          query   = datafasta,
          subject = datafasta2,
          task="blastp",
          search_type = "protein_to_protein",
          cores = 8,
          db.import  = FALSE)
        blast_best_other$query_id<-unlist(lapply(blast_best_other$query_id,function(x){
          strsplit(x,"\\|")[[1]][2]
        }))
        blast_best_other$subject_id<-unlist(lapply(blast_best_other$subject_id,function(x){
          strsplit(x,"\\|")[[1]][2]
        }))
        #save(datafasta2,blast_best_other,file = paste("temp/Blast.Between.Two.Species.",wuzhong,
        #                                              ".",wuzhong2,"_",usertimenum,".RData",sep=""))
        shiny::incProgress(1, detail = "Generating data...")
      })
    }
    blast_best_other<-blast_best_other[blast_best_other$evalue<=input$evalueyuzhi,1:3]
    list(datafasta=datafasta,datafasta2=datafasta2,blast_best_other=blast_best_other)
  })
  output$blastres1save<-renderUI({
    if(!isolate(input$preblastif)){
      #h4(paste0("Your results will been saved in our server and kept for about one week, which named: ",
      #          paste("Blast.Between.Two.Species_",usertimenum,".RData",sep=""),
      #          ". Please type the name in the 1.1. parameter when '1. Using pre-blast results or not?' is true."))
      h4("To speed up the analysis, if you blast to the same species next time, please download the blast results here and upload it in the 1.1. parameter when '1. Using pre-blast results or not?' is true.")
    }
  })
  blastres2out<-reactive({
    if(TRUE){#isolate(input$preblastif)
      #if(input$wuzhong2id==""){
      #  wuzhong2<<-"9606"
      #}else{
      #  wuzhong2<<-input$wuzhong2id
      #}
      #preblastproseqx<<-input$preblastproseq
      #if(is.null(input$preblastproseq)){
      #  load(file=paste0(wuzhong,"_blast_best_seqs_9606.RData"))
      #}else{
      #  #load(file=paste("temp/",input$preblastproseq,sep=""))
      #  load(input$preblastproseq$datapath)
      #}
      wuzhong2<<-"9606"
      if(input$blastbesthit==1){
        load(file=paste0("percentdatabase/",wuzhong,"_blast_best_seqs_9606.RData"))
      }else{
        load(file=paste0("aligndatabase/",wuzhong,"_blast_best_seqs_9606.RData"))
      }
      names(blastseqlist)<-unlist(lapply(names(blastseqlist),function(x){
        strsplit(x,"\\|")[[1]][2]
      }))
      #save(blastseqlist,file = paste("temp/Blast.Protein.Sequences.",wuzhong,".",wuzhong2,"_",usertimenum,".RData",sep=""))
    }else{
      blastres1outx<<-blastres1out()
      blaseresdf<-blastres1outx$blast_best_other
      queryfasta<-readAAStringSet(blastres1outx$datafasta)
      queryfastadf<-queryfastadf1<-as.data.frame(queryfasta)
      rownames(queryfastadf)<-unlist(lapply(rownames(queryfastadf1),function(x){
        strsplit(x,"\\|")[[1]][2]
      }))
      subjectfasta<-readAAStringSet(blastres1outx$datafasta2)
      subjectfastadf<-subjectfastadf1<-as.data.frame(subjectfasta)
      rownames(subjectfastadf)<-unlist(lapply(rownames(subjectfastadf1),function(x){
        strsplit(x,"\\|")[[1]][2]
      }))
      blastseqlist<-list()
      withProgress(message = 'Generating data', style = "notification", detail = "index 1", value = 0,{
        for(i in 1:nrow(blaseresdf)){
          qureyi<-blaseresdf$query_id[i]
          subjecti<-blaseresdf$subject_id[i]
          alignquery<-msa(c(queryfasta[rownames(queryfastadf)==qureyi],
                            subjectfasta[rownames(subjectfastadf)==subjecti]))
          alignquerydf<-as.data.frame(alignquery@unmasked)$x
          blastseqlist[[i]]<-alignquerydf
          incProgress(1/nrow(blaseresdf), detail = paste("index", i))
        }
      })
      names(blastseqlist)<-blaseresdf$query_id
      #save(blastseqlist,file = paste("temp/Blast.Protein.Sequences.",wuzhong,".",wuzhong2,"_",usertimenum,".RData",sep=""))
    }
    blastseqlist
  })
  #blastres2outx<-reactive({
  #  blastseqlist<<-blastres2out()
  #  save(blastseqlist,file = paste("temp/Blast.Protein.Sequences_",usertimenum,".RData",sep=""))
  #  blastseqlist
  #})
  output$blastres2save<-renderUI({
    if(!isolate(input$preblastif)){
      #h4(paste0("Your results will been saved in our server and kept for about one week, which named: ",
      #          paste("Blast.Protein.Sequences_",usertimenum,".RData",sep=""),". Please type the name in the 1.2. parameter when '1. Using pre-blast results or not?' is true."))
      h4("To speed up the analysis, if you blast to the same species next time, please download the blast results here and upload it in the 1.2. parameter when '1. Using pre-blast results or not?' is true.")
    }
  })
  blastresout<-reactive({
    library(tidyr)
    danlength<-input$minseqs
    blastres1outx<<-blastres1out()
    blaseresdf<-blastres1outx$blast_best_other
    datafasta<<-readAAStringSet(blastres1outx$datafasta)
    readfastaqnames<-unlist(lapply(names(datafasta),function(x){
      strsplit(strsplit(x," ")[[1]][1],"\\|")[[1]][2]
    }))
    if(sum(is.na(readfastaqnames))>length(readfastaqnames)/2){
      readfastaqnames<-unlist(lapply(names(datafasta),function(x) strsplit(x,"\\ ")[[1]][1]))
    }
    datafasta2<-blastres1outx$datafasta2
    datafastahuman<<-readAAStringSet(datafasta2)
    readfastasubjnames<-unlist(lapply(names(datafastahuman),function(x){
      strsplit(strsplit(x," ")[[1]][1],"\\|")[[1]][2]
    }))
    blastseqlist<<-blastres2out()
    datasuiqiallx2<-datasuiqiallxx<<-seqduiqievent()
    datasuiqiallxx2<-separate_rows(datasuiqiallxx,6:8,sep = "::")
    datasuiqiallx<-datasuiqiall<<-unique(separate_rows(datasuiqiallxx2,3:8,sep = ";"))
    datasuiqiallx$PRO.CombinedID<-paste0(datasuiqiall$PRO.from.Database,"_",datasuiqiall$Center.amino.acid,
                                         datasuiqiall$PROindex.from.Database)
    Center.amino.acids.Other<-Seqwindows.Other<-PRO.from.Other<-PROindex.from.Other<-vector()
    #Center.aa.match<-Window.similarity<-vector()
    withProgress(message = 'Generating data', style = "notification", detail = "index 1", value = 0,{
      for(i in 1:nrow(datasuiqiall)){
        centeraas<-strsplit(datasuiqiall$Center.amino.acid[i],";")[[1]]
        Pepmainindex<-as.numeric(strsplit(datasuiqiall$Pep.main.index[i],";")[[1]])
        promainindex<-as.numeric(strsplit(datasuiqiall$PROindex.from.Database[i],";")[[1]])
        grepproindex<-grep(datasuiqiall$PRO.from.Database[i],blaseresdf$query_id)
        if(length(grepproindex)>0){
          queryindex1<-blaseresdf$query_id[grepproindex]
          queryindex2<-blaseresdf$subject_id[grepproindex]
          subjectpro<-as.data.frame(datafastahuman[readfastasubjnames==queryindex2])$x
          seqnchar<-nchar(subjectpro)
          if(length(seqnchar)>0){
            if(TRUE){#isolate(input$preblastif)
              alignquerydf<-blastseqlist[[queryindex1]]
            }else{
              alignquery<-msa(c(datafasta[readfastaqnames==queryindex1],datafastahuman[readfastasubjnames==queryindex2]))
              alignquerydf<-as.data.frame(alignquery@unmasked)$x
            }
            alignquerydf1<-strsplit(alignquerydf[1],"")[[1]]
            alignquerydf2<-strsplit(alignquerydf[2],"")[[1]]
            alignquerydfhengxian1<-grep("-",alignquerydf1)
            alignquerydfhengxian2<-grep("-",alignquerydf2)
            if(length(alignquerydfhengxian1)>0){
              #alignquerydf3<-alignquerydf2[-alignquerydfhengxian1]
              #humanhenggangindex<-which(alignquerydf3[promainindex]=="-")
              #if(length(humanhenggangindex)>0){
              #  promainindex<-promainindex[-humanhenggangindex]
              #  if(length(promainindex)>0){
              #    blaseprocenter<-paste(alignquerydf3[promainindex],collapse=";")
              #  }else{
              #    blaseprocenter<-NA
              #  }
              #}else{
              #  blaseprocenter<-paste(alignquerydf3[promainindex],collapse=";")
              #}
              centeraas1<-grep(centeraas,alignquerydf1)
              centeraas2<-centeraas1[centeraas1>=promainindex]
              caai<-1
              repeat{
                x1<-sum(alignquerydfhengxian1<=centeraas2[caai])
                blaseproindex1<-centeraas2[caai]
                if((centeraas2[caai]-x1)==promainindex) break
                caai<-caai+1
              }
              if(length(alignquerydfhengxian2)>0){
                blaseproindex<-blaseproindex1-sum(alignquerydfhengxian2<=blaseproindex1)
                #blaseprocenter<-alignquerydf2[-alignquerydfhengxian2][blaseproindex]
              }else{
                blaseproindex<-blaseproindex1
                #blaseprocenter<-alignquerydf2[blaseproindex]
              }
              blaseproindex2<-blaseproindex1
              #blaseprocenter<-alignquerydf2[blaseproindex]
              #blaseproindex<-unlist(lapply(promainindex,function(x){
              #  #x1<-sum(alignquerydfhengxian1<x)
              #  if(length(alignquerydfhengxian2)>0){
              #    x2<-sum(alignquerydfhengxian2<x1+x)
              #    x1+x-x2
              #  }else{
              #    x1+x
              #  }
              #}))
            }else{
              #humanhenggangindex<-which(alignquerydf2[promainindex]=="-")
              #if(length(humanhenggangindex)>0){
              #  promainindex<-promainindex[-humanhenggangindex]
              #  if(length(promainindex)>0){
              #    blaseprocenter<-paste(alignquerydf2[promainindex],collapse=";")
              #  }else{
              #    blaseprocenter<-NA
              #  }
              #}else{
              #  blaseprocenter<-paste(alignquerydf2[promainindex],collapse=";")
              #}
              #blaseprocenter<-paste(alignquerydf2[promainindex],collapse=";")
              if(length(alignquerydfhengxian2)>0){
                blaseproindex<-promainindex-sum(alignquerydfhengxian2<=promainindex)
                #blaseprocenter<-alignquerydf2[-alignquerydfhengxian2][blaseproindex]
              }else{
                blaseproindex<-promainindex
                #blaseprocenter<-alignquerydf2[blaseproindex]
              }
              blaseproindex2<-promainindex
              #blaseprocenter<-alignquerydf2[blaseproindex]
              #blaseproindex<-unlist(lapply(promainindex,function(x){
              #  if(length(alignquerydfhengxian2)>0){
              #    x2<-sum(alignquerydfhengxian2<=x)
              #    x-x2
              #  }else{
              #    x
              #  }
              #}))
            }
            blastpepwindows<-unlist(lapply(blaseproindex2,function(x){#blaseproindex
              indexjian1<-x-danlength
              indexjian2<-x+danlength
              if(indexjian1<=0){
                xhx1<-paste(rep("_",abs(indexjian1)+1),collapse ="")
                xhx2<-stri_sub(alignquerydf[2],from = 0,to=indexjian2)#subjectpro
                xhx3<-paste0(xhx1,xhx2)
              }
              else if(indexjian2>nchar(alignquerydf[2])){#seqnchar
                xhx1<-paste(rep("_",(indexjian2-nchar(alignquerydf[2]))),collapse="")#seqnchar
                xhx2<-stri_sub(alignquerydf[2],from = indexjian1,to=nchar(alignquerydf[2]))#subjectpro seqnchar
                xhx3<-paste0(xhx2,xhx1)
              }
              else{
                xhx3<-stri_sub(alignquerydf[2],from = indexjian1,to=indexjian2)#subjectpro
              }
            }))
            blaseprocenter<-alignquerydf2[blaseproindex2]
            if(blaseprocenter!="-"){
              blaseproindex<-blaseproindex
            }else{
              blaseproindex<-0
            }
            Center.amino.acids.Other[i]<-blaseprocenter#ifelse(length(blaseprocenter)>0,blaseprocenter,NA)
            Seqwindows.Other[i]<-paste(blastpepwindows,collapse = ";")
            PRO.from.Other[i]<-queryindex2#strsplit(queryindex2,"\\|")[[1]][2]
            PROindex.from.Other[i]<-paste(blaseproindex,collapse = ";")
          }else{
            Center.amino.acids.Other[i]<-NA
            Seqwindows.Other[i]<-NA
            PRO.from.Other[i]<-NA
            PROindex.from.Other[i]<-NA
          }
        }else{
          Center.amino.acids.Other[i]<-NA
          Seqwindows.Other[i]<-NA
          PRO.from.Other[i]<-NA
          PROindex.from.Other[i]<-NA
        }
        incProgress(1/nrow(datasuiqiall), detail = paste("index", i))
      }
    })
    datasuiqiallx$Center.amino.acids.Other<-Center.amino.acids.Other
    datasuiqiallx$Seqwindows.Other<-Seqwindows.Other
    datasuiqiallx$PRO.from.Other<-PRO.from.Other
    datasuiqiallx$PROindex.from.Other<-PROindex.from.Other
    datasuiqiallx2<-datasuiqiallx[datasuiqiallx$Center.amino.acids.Other!="NA",]
    datasuiqiallx3<-datasuiqiallx2[!is.na(datasuiqiallx2$Seqwindows.Other),]
    datasuiqiallx3$PRO.CombinedID.Other<-paste0(datasuiqiallx3$PRO.from.Other,"_",datasuiqiallx3$Center.amino.acids.Other,
                                                datasuiqiallx3$PROindex.from.Other)
    unique(datasuiqiallx3)
  })
  blastresout2<-reactive({
    if(input$loadseqdatatype==1){
      blastresoutx<<-blastresout()
      withProgress(message = 'Calculating Window.similarity and BLOSUM50.Score...',min = 0, max = 2, style = "notification", detail = "", value = 1,{
        shiny::incProgress(1, detail = "Generating data")
        Center.aa.match<-apply(blastresoutx[,c("Center.amino.acid","Center.amino.acids.Other")],1,function(x){
          if(x[1]==x[2]){
            "Exact"
          }else{
            if(sum(x%in%c("S","T","Y"))==2){
              "Fuzzy"
            }else{
              "Not match"
            }
          }
        })
        Window.similarity<-apply(blastresoutx[,c("Seqwindows","Seqwindows.Other")],1,function(x){
          x1<-strsplit(x[1],"")[[1]]
          x2<-strsplit(x[2],"")[[1]]
          sum(x1==x2)
        })
        if(sum(Center.aa.match=="Not match")>0){
          Window.similarity[which(Center.aa.match=="Not match")]<-0
        }
        blastresoutx$Center.aa.match<-Center.aa.match
        blastresoutx$Window.similarity<-Window.similarity
        BLOSUM50.Score<-apply(blastresoutx[,c("Seqwindows","Seqwindows.Other")],1,function(x){
          seqs<-as.character(x)
          seq1<-seqs[1]
          seq2<-seqs[2]
          #xx1<-unique(c(grep("_",x[1]),grep("_",x[2]),
          #              grep("\\-",x[1]),grep("\\-",x[2]),
          #              grep("U",x[1]),grep("U",x[2])))
          xx1<-unique(c(grep("_",seq1),grep("_",seq2),
                        grep("\\-",seq1),grep("\\-",seq2),
                        grep("U",seq1),grep("U",seq2)))
          if(length(xx1)>0){
            #xx2<-0
            seq1x<-strsplit(seq1,"")[[1]]
            seq2x<-strsplit(seq2,"")[[1]]
            xx1x<-unique(c(grep("_",seq1x),grep("_",seq2x),
                           grep("\\-",seq1x),grep("\\-",seq2x),
                           grep("U",seq1x),grep("U",seq2x)))
            xxx1<-paste0(seq1x[-xx1x],collapse = "")
            xxx2<-paste0(seq2x[-xx1x],collapse = "")
            if(xxx1==""){
              xx2<-0
            }else{
              xx2<-pairwiseAlignment(xxx1,xxx2,substitutionMatrix = "BLOSUM50",
                                     gapOpening = 10, gapExtension = 0.2)
              xx2<-xx2@score
            }
          }else{
            xx2<-pairwiseAlignment(seq1,seq2,substitutionMatrix = "BLOSUM50",
                                   gapOpening = 10, gapExtension = 0.2)
            xx2<-xx2@score
          }
          xx2
        })
      })
      blastresoutx$BLOSUM50.Score<-BLOSUM50.Score
    }else{
      blastresoutx<-read.csv("BlastToHuman.csv",stringsAsFactors = F)
    }
    if(input$centeraamatach==1){
      blastresoutx1<-blastresoutx[grep("Exact|Fuzzy",blastresoutx$Center.aa.match),]
    }else if(input$centeraamatach==2){
      blastresoutx1<-blastresoutx
    }else{
      blastresoutx1<-blastresoutx[blastresoutx$Center.aa.match=="Exact",]
    }
    if(input$seqmatachsimilarif){
      blastresoutx1<-blastresoutx1[blastresoutx1$Window.similarity>=input$seqmatachsimilar,]
    }
    if(input$blosum50yuzhiif){
      blastresoutx1<-blastresoutx1[blastresoutx1$BLOSUM50.Score>=input$blosum50yuzhi,]
    }
    blastresoutx1
  })
  observeEvent(
    input$blastbtn_seqalign,{
      shinyjs::show(id = "hiddendiv2", anim = FALSE)
      output$blastres1<-renderDataTable({
        datatable(blastres1out()$blast_best_other)
      })
      output$blastres1dl<-downloadHandler(
        filename = function(){paste("Blast.Between.Two.Species.",wuzhong,".",wuzhong2,"_",usertimenum,".RData",sep="")},
        content = function(file){
          #write.csv(blastres1out()$blast_best_other,file,row.names=FALSE)
          seqwenbenfile1<-paste("temp/Blast.Between.Two.Species.",wuzhong,".",wuzhong2,"_",usertimenum,".RData",sep="")
          file.copy(seqwenbenfile1,file)
        }
      )
      output$blastres2<-renderPrint({
        invisible(capture.output(blastseqlist<-blastres2out()))
        #load(paste("temp/Blast.Protein.Sequences_",usertimenum,".RData",sep=""))
        print(blastseqlist[1:10])
      })
      output$blastres2dl<-downloadHandler(
        filename = function(){paste("Blast.Protein.Sequences.",wuzhong,".",wuzhong2,"_",usertimenum,".RData",sep="")},
        content = function(file){
          #write.csv(blastres2out(),file,row.names=FALSE)
          #save(blastres2out(),file)
          seqwenbenfile2<-paste("temp/Blast.Protein.Sequences.",wuzhong,".",wuzhong2,"_",usertimenum,".RData",sep="")
          file.copy(seqwenbenfile2,file)
        }
      )
      output$blastres<-renderDataTable({
        datatable(blastresout2())
      })
      output$blastresdl<-downloadHandler(
        filename = function(){paste("BlastToHuman_",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(blastresout2(),file,row.names=FALSE)
        }
      )
    }
  )
  #
  motiffujiout<-reactive({
    if(input$loadseqdatatype==1){
      datareaddq<<-seqduiqiout()
    }else{
      datareaddq<-read.csv("Prealign_data.csv",stringsAsFactors = F)
    }
    if(input$onlyregularsiteif){
      datareaddq<-datareaddq[datareaddq[[ncol(datareaddq)]]=="Yes",]
      if(nrow(datareaddq)==0){
        stop("There are no regular sequences! Please check if you select the parameter in Step 2 or type in right regular expression.")
      }
    }
    #if(ncol(datareaddq)==1) colnames(datareaddq)<-"Seqwindows"
    #if(ncol(datareaddq)==2) colnames(datareaddq)<-c("Seqwindows","Contain.if")
    datareadbj<-NULL#seqbjdataout()
    if(input$xuanzebgdatabase==1){
      if(input$loadseqdatatype==1){
        wuzhong<-strsplit(input$metabopathspeciesselect,"-")[[1]][1]
      }else{
        wuzhong<-strsplit(input$speciesselectrat,"-")[[1]][1]
      }
    }else{
      wuzhong<-input$wuzhongid
    }
    if(FALSE){#input$onlymultisiteif
      seqduiqiduositedf<-seqduiqiduositeout()
      fgseqs<-unique(unlist(lapply(seqduiqiduositedf$Seqwindows_MultiSites,function(x) strsplit(x,";|::")[[1]])))
    }else{
      fgseqs<-unique(unlist(lapply(datareaddq$Seqwindows,function(x) strsplit(x,";|::")[[1]])))
    }
    wuzhong<<-wuzhong
    withProgress(message = 'Motif Enrichment:',min = 0, max = 2, style = "notification", detail = "Generating data", value = 1,{
      if(is.null(datareadbj)){
        if(input$xuanzebgdatabase==1){
          #if(input$motifquanbuif){
          #  load(file = paste0("winsSTY_",wuzhong,".RData"))
          #  motseq <- motifx(fg.seqs=fgseqs, bg.seqs=unique(seqseqalldf_STY$Windows), central.res = input$centralres,
          #                   min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
          #}else{
          #  #warning("Please note: No background dataset is chosen or uploaded! The foreground dataset is treated as the background database by default, but this is not recommended!")
          #  motseq <- motifx(fg.seqs=fgseqs, bg.seqs=fgseqs, central.res = input$centralres,
          #                   min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
          #}
          centralresx<<-grep("S|T|Y",input$centralres)
          RDatafiles<<-list.files("fasta/",pattern = "RData$")
          RDatafiles1<-paste0("winsSTY_",wuzhong,".RData")
          RDatafiles2<-which(RDatafiles==RDatafiles1)
          if(length(RDatafiles2)>0 & length(centralresx)>0){
            load(file = paste0("fasta/winsSTY_",wuzhong,".RData"))
            motseq <- motifx(fg.seqs=fgseqs, bg.seqs=unique(seqseqalldf_STY$Windows), central.res = input$centralres,
                             min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
          }else{
            fastaseqownoutdf<<-fastaseqownout()
            motseq <- motifx(fg.seqs=fgseqs, bg.seqs=unique(fastaseqownoutdf$Windows), central.res = input$centralres,
                             min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
          }
        }else{
          fastaseqownoutdf<<-fastaseqownout()
          motseq <- motifx(fg.seqs=fgseqs, bg.seqs=unique(fastaseqownoutdf$Windows), central.res = input$centralres,
                           min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
        }
      }else{
        motseq <- motifx(fg.seqs=fgseqs, bg.seqs=unique(datareadbj[[1]]),central.res = input$centralres,
                         min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
      }
      
      shiny::incProgress(1, detail = "Generating data")
    })
    
    #motseq<-motseq
    if(is.null(motseq)){
      stop("No enrichment results, perhaps you need to adjust the 'Minimum number' and/or 'P-value threshold' parameters~~")
    }
    motseqdf<-motseq$df
    motseqdf$Enrich.seq<-sapply(motseq$motiflist,function(x) paste(x$pos,collapse = ";"))
    matchpro<-sapply(motseq$motiflist,function(x){
      xx<-unlist(lapply(x$pos,function(x) grep(x,datareaddq$Seqwindows,perl=TRUE)))
      paste(unique(datareaddq$PRO.from.Database[xx]),collapse = ";")
    })
    motseqdf$Enrich.pro<-matchpro
    motseqdf
  })
  ##blast motif
  motiffujiblastout<-reactive({
    #datareaddq<-seqduiqiout()
    datareaddqblast<<-blastresout2()#blastresout()
    if(input$onlyregularsiteif){
      datareaddqblast<-datareaddqblast[datareaddqblast$Contain.if=="Yes",]
      if(nrow(datareaddqblast)==0){
        stop("There are no regular sequences! Please check if you select the parameter in Step 2 or type in right regular expression.")
      }
    }
    datareadbj<-NULL#seqbjdataout()
    #wuzhong<<-strsplit(input$metabopathspeciesselect,"-")[[1]][1]
    if(FALSE){#input$onlymultisiteif
      seqduiqiduositedf<-seqduiqiduositeout()
      fgseqs<-unique(unlist(lapply(seqduiqiduositedf$Seqwindows_MultiSites,function(x) strsplit(x,";|::")[[1]])))
    }else{
      fgseqsblast<-unique(unlist(lapply(datareaddqblast$Seqwindows.Other,function(x) strsplit(x,";|::")[[1]])))
      #fgseqsblast<-fgseqsblast[nchar(fgseqsblast)==(2*input$minseqs+1)]
    }
    
    withProgress(message = 'Motif Enrichment:',min = 0, max = 2, style = "notification", detail = "Generating data", value = 1,{
      if(is.null(datareadbj)){
        if(input$xuanzebgdatabase==1){
          centralresx<<-grep("S|T|Y",input$centralres)
          if(length(centralresx)>0){
            load(file = paste0("fasta/winsSTY_9606.RData"))
            motseqblast <- motifx(fg.seqs=fgseqsblast, bg.seqs=unique(seqseqalldf_STY$Windows), central.res = input$centralres,
                                  min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
          }else{
            fastaseqownoutdf<<-fastaseqownout()
            motseqblast <- motifx(fg.seqs=fgseqsblast, bg.seqs=unique(fastaseqownoutdf$Windows), central.res = input$centralres,
                                  min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
          }
        }else{
          fastaseqownoutdf<<-fastaseqownout()
          motseqblast <- motifx(fg.seqs=fgseqsblast, bg.seqs=unique(fastaseqownoutdf$Windows), central.res = input$centralres,
                                min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
        }
      }else{
        motseqblast <- motifx(fg.seqs=fgseqsblast, bg.seqs=unique(datareadbj[[1]]),central.res = input$centralres,
                              min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
      }
      shiny::incProgress(1, detail = "Generating data")
    })
    
    #motseq<-motseq
    if(is.null(motseqblast)){
      stop("No enrichment results, perhaps you need to adjust the 'Minimum number' and/or 'P-value threshold' parameters~~")
    }
    motseqdf<-motseqblast$df
    motseqdf$Enrich.seq<-sapply(motseqblast$motiflist,function(x) paste(x$pos,collapse = ";"))
    matchpro<-sapply(motseqblast$motiflist,function(x){
      xx<-unlist(lapply(x$pos,function(x) grep(x,datareaddqblast$Seqwindows,perl=TRUE)))
      paste(unique(datareaddqblast$PRO.from.Database[xx]),collapse = ";")
    })
    motseqdf$Enrich.pro<-matchpro
    motseqdf
  })
  motiffujiout2<-reactive({
    if(input$loadseqdatatype==1){
      datareaddq<-seqduiqiout()
    }else{
      datareaddq<-read.csv("Prealign_data.csv",stringsAsFactors = F)
    }
    if(ncol(datareaddq)<3){
      tabdata4<-NULL
    }else{
      motiffujioutx<-motiffujiout()[,-9]
      tabdata1<-tidyr::separate_rows(motiffujioutx, Enrich.seq, sep =";")
      tabdata1x<-unique(tabdata1)
      tabdata2<-tidyr::separate_rows(datareaddq[,-c(2:4)], Seqwindows,PROindex.from.Database, sep =";")
      tabdata3<-unique(tabdata2)
      tabdata4<-base::merge(tabdata1x,tabdata3,by.x="Enrich.seq",by.y="Seqwindows",sort=FALSE)
    }
    tabdata4
  })
  regularmotiffujiout<-reactive({
    if(input$loadseqdatatype==1){
      datareaddq<-seqduiqiout()
    }else{
      datareaddq<-read.csv("Prealign_data.csv",stringsAsFactors = F)
    }
    if(ncol(datareaddq)==1) colnames(datareaddq)<-"Seqwindows"
    if(ncol(datareaddq)==2) colnames(datareaddq)<-c("Seqwindows","Contain.if")
    datareadbj<-seqbjdataout()
    fastaseqownoutdf<-fastaseqownout()
    if(input$xuanzebgdatabase==1){
      if(input$loadseqdatatype==1){
        wuzhong<-strsplit(input$metabopathspeciesselect,"-")[[1]][1]
      }else{
        wuzhong<-strsplit(input$speciesselectrat,"-")[[1]][1]
      }
    }else{
      wuzhong<<-input$wuzhongid
    }
    #wuzhong<-strsplit(input$metabopathspeciesselect,"-")[[1]][1]
    if(FALSE){#input$onlymultisiteif
      seqduiqiduositedf<-seqduiqiduositeout()
      datareaddq1<-seqduiqiduositedf$Seqwindows_MultiSites[seqduiqiduositedf$Contain.if=="Yes"]
      fgseqs<-unique(unlist(lapply(datareaddq1,function(x) strsplit(x,";|::")[[1]])))
    }else{
      datareaddq1<-datareaddq$Seqwindows[datareaddq$Contain.if=="Yes"]
      fgseqs<-unique(unlist(lapply(datareaddq1,function(x) strsplit(x,";|::")[[1]])))
    }
    withProgress(message = 'Motif Enrichment:',min = 0, max = 2, style = "notification", detail = "Generating data", value = 1,{
      if(is.null(datareadbj)){
        if(input$xuanzebgdatabase==1){
          #if(input$motifquanbuif){
          #  load(file = paste0("winsSTY_",wuzhong,".RData"))
          #  motseq <- motifx(fg.seqs=fgseqs, bg.seqs=unique(seqseqalldf_STY$Windows), central.res = input$centralres,
          #                   min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
          #}else{
          #  #warning("Please note: No background dataset is chosen or uploaded! The foreground dataset is treated as the background database by default, but this is not recommended!")
          #  motseq <- motifx(fg.seqs=fgseqs, bg.seqs=fgseqs, central.res = input$centralres,
          #                   min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
          #}
          centralresx<<-grep("S|T|Y",input$centralres)
          RDatafiles<<-list.files("fasta/",pattern = "RData$")
          RDatafiles1<-paste0("winsSTY_",wuzhong,".RData")
          RDatafiles2<-which(RDatafiles==RDatafiles1)
          if(length(RDatafiles2)>0 & length(centralresx)>0){
            load(file = paste0("fasta/winsSTY_",wuzhong,".RData"))
            motseq <- motifx(fg.seqs=fgseqs, bg.seqs=unique(seqseqalldf_STY$Windows), central.res = input$centralres,
                             min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
          }else{
            fastaseqownoutdf<<-fastaseqownout()
            motseq <- motifx(fg.seqs=fgseqs, bg.seqs=unique(fastaseqownoutdf$Windows), central.res = input$centralres,
                             min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
          }
        }else{
          motseq <- motifx(fg.seqs=fgseqs, bg.seqs=unique(fastaseqownoutdf$Windows), central.res = input$centralres,
                           min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
        }
      }else{
        motseq <- motifx(fg.seqs=fgseqs, bg.seqs=unique(datareadbj[[1]]),central.res = input$centralres,
                         min.seqs = input$minseqsnum, pval.cutoff = input$pvalcutoff)
      }
      shiny::incProgress(1, detail = "Generating data")
    })
    
    #motseq<-motseq
    if(is.null(motseq)){
      stop("No enrichment results, perhaps you need to adjust the 'Minimum number' and/or 'P-value threshold' parameters~~")
    }
    motseqdf<-motseq$df
    motseqdf$Enrich.seq<-sapply(motseq$motiflist,function(x) paste(x$pos,collapse = ";"))
    matchpro<-sapply(motseq$motiflist,function(x){
      xx<-unlist(lapply(x$pos,function(x) grep(x,datareaddq$Seqwindows,perl=TRUE)))
      paste(unique(datareaddq$PRO.from.Database[xx]),collapse = ";")
    })
    motseqdf$Enrich.pro<-matchpro
    motseqdf
  })
  motifplot_height <- reactive({
    heightx<-input$motifplot_height
    heightx
  })
  observeEvent(
    input$mcsbtn_motifquanbu,{
      shinyjs::show(id = "hiddendiv3", anim = FALSE)
      shinyjs::show(id = "hiddendiv4", anim = FALSE)
      shinyjs::show(id = "hiddendiv5", anim = FALSE)
      shinyjs::show(id = "hiddendiv6", anim = FALSE)
      output$motiffuji<-renderDataTable({
        if(input$loadseqdatatype==1){
          motiffujidf<<-isolate(motiffujiout())
        }else{
          motiffujidf<-read.csv("Motif.Enrich_uploaded.csv",stringsAsFactors = F)
        }
        datatable(motiffujidf, options = list(pageLength = 10))
      })
      output$motiffujidl<-downloadHandler(
        filename = function(){paste("Motif.Enrich_uploaded",usertimenum,".csv",sep="")},
        content = function(file){
          if(input$loadseqdatatype==1){
            motiffujidf<-isolate(motiffujiout())
          }else{
            motiffujidf<-read.csv("Motif.Enrich_uploaded.csv",stringsAsFactors = F)
          }
          write.csv(motiffujidf,file,row.names=FALSE)
        }
      )
      output$uploadmotifpwmui<-renderUI({
        if(input$loadseqdatatype==1){
          motiffujidf<-isolate(motiffujiout())
        }else{
          motiffujidf<-read.csv("Motif.Enrich_uploaded.csv",stringsAsFactors = F)
        }
        selectizeInput('uploadmotifpwm', h5('Please select one motif to view its PWM (Position weight matrix):'), choices =motiffujidf[[1]])
      })
      uploadmotifpwmdfout<-reactive({
        library(KinSwingR)
        if(input$loadseqdatatype==1){
          motiffujidf<-isolate(motiffujiout())
        }else{
          motiffujidf<-read.csv("Motif.Enrich_uploaded.csv",stringsAsFactors = F)
        }
        ii<-which(motiffujidf$motif==input$uploadmotifpwm)
        pepseq<-strsplit(motiffujidf$Enrich.seq[ii],";")[[1]]
        pepseq1<-pepseq#[-unique(c(grep("_",pepseq),grep("\\-",pepseq),grep("U",pepseq)))]
        pepseq1df<-data.frame(kinase=motiffujidf$motif[ii],substrate=pepseq1,stringsAsFactors = F)
        pepseq3<-buildPWM(as.matrix(pepseq1df),wild_card = c("_","-","U"))
        round((2^pepseq3$pwm[[1]]-0.01)/20,digits = 7)
      })
      output$uploadmotifpwmdf<-renderDataTable({
        datatable(uploadmotifpwmdfout(), options = list(pageLength = 10))
      })
      output$uploadmotifpwmdfdl<-downloadHandler(
        filename = function(){paste("Motif.PWM_upload",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(uploadmotifpwmdfout(),file,row.names=FALSE)
        }
      )
      #blast motif
      output$motiffujiblast<-renderDataTable({
        if(input$loadseqdatatype==1){
          motifblastfujidf<-motiffujiblastout()
        }else{
          motifblastfujidf<-read.csv("Motif.Enrich_blast.csv",stringsAsFactors = F)
        }
        datatable(motifblastfujidf, options = list(pageLength = 10))
      })
      output$motiffujiblastdl<-downloadHandler(
        filename = function(){paste("Motif.Enrich_blast",usertimenum,".csv",sep="")},
        content = function(file){
          if(input$loadseqdatatype==1){
            motifblastfujidf<-motiffujiblastout()
          }else{
            motifblastfujidf<-read.csv("Motif.Enrich_blast.csv",stringsAsFactors = F)
          }
          write.csv(motifblastfujidf,file,row.names=FALSE)
        }
      )
      output$blastmotifpwmui<-renderUI({
        if(input$loadseqdatatype==1){
          motifblastfujidf<-motiffujiblastout()
        }else{
          motifblastfujidf<-read.csv("Motif.Enrich_blast.csv",stringsAsFactors = F)
        }
        selectizeInput('blastmotifpwm', h5('Please select one motif to view its PWM (Position weight matrix):'), choices =motifblastfujidf[[1]])
      })
      blastmotifpwmdfout<-reactive({
        library(KinSwingR)
        if(input$loadseqdatatype==1){
          motifblastfujidf<-motiffujiblastout()
        }else{
          motifblastfujidf<-read.csv("Motif.Enrich_blast.csv",stringsAsFactors = F)
        }
        ii<-which(motifblastfujidf$motif==input$blastmotifpwm)
        pepseq<-strsplit(motifblastfujidf$Enrich.seq[ii],";")[[1]]
        pepseq1<-pepseq#[-unique(c(grep("_",pepseq),grep("\\-",pepseq),grep("U",pepseq)))]
        pepseq1df<-data.frame(kinase=motifblastfujidf$motif[ii],substrate=pepseq1,stringsAsFactors = F)
        pepseq3<-buildPWM(as.matrix(pepseq1df),wild_card = c("_","-","U"))
        round((2^pepseq3$pwm[[1]]-0.01)/20,digits = 7)
      })
      output$blastmotifpwmdf<-renderDataTable({
        datatable(blastmotifpwmdfout(), options = list(pageLength = 10))
      })
      output$blastmotifpwmdfdl<-downloadHandler(
        filename = function(){paste("Motif.PWM_blast",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(blastmotifpwmdfout(),file,row.names=FALSE)
        }
      )
      #
      output$motiffuji2<-renderDataTable({
        motiffujidf<-isolate(motiffujiout2())
        datatable(motiffujidf, options = list(pageLength = 10))
      })
      output$motiffujidl2<-downloadHandler(
        filename = function(){paste("Motif.Enrich.mapped_data",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(motiffujiout2(),file,row.names=FALSE)
        }
      )
      #
      output$regularmotiffuji<-renderDataTable({
        motiffujidf<-isolate(regularmotiffujiout())
        datatable(motiffujidf, options = list(pageLength = 10))
      })
      output$regularmotiffujidl<-downloadHandler(
        filename = function(){paste("RegularMotif.Enrich_data",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(regularmotiffujiout(),file,row.names=FALSE)
        }
      )
      ##############
      output$motifplot<-renderPlot({
        library(ggplot2)
        library(rmotifx)
        library(ggseqlogo)
        if(input$loadseqdatatype==1){
          motiffujidf<<-isolate(motiffujiout())
        }else{
          motiffujidf<-read.csv("Motif.Enrich_uploaded.csv",stringsAsFactors = F)
        }
        enrichseqnumstr<-isolate(as.numeric(strsplit(input$enrichseqnum,"-|;|,")[[1]]))
        if(input$equalheightif){
          equalh<-"probability"
        }else{
          equalh<-"bits"
        }
        if(length(enrichseqnumstr)==1){
          enrichseq<-strsplit(motiffujidf$Enrich.seq[enrichseqnumstr],";")[[1]]
          ggseqlogo(enrichseq, method=equalh)+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }else{
          motiffujidf1<-motiffujidf[enrichseqnumstr[1]:enrichseqnumstr[2],]
          enrichseq<-lapply(motiffujidf1$Enrich.seq,function(x){
            xx<-strsplit(x,";")[[1]]
          })
          names(enrichseq)<-motiffujidf1$motif
          ggseqlogo(enrichseq, ncol = 2, method=equalh)+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }
      },height = motifplot_height)
      motifplotout<-reactive({
        library(ggplot2)
        library(rmotifx)
        library(ggseqlogo)
        if(input$loadseqdatatype==1){
          motiffujidf<-isolate(motiffujiout())
        }else{
          motiffujidf<-read.csv("Motif.Enrich_uploaded.csv",stringsAsFactors = F)
        }
        enrichseqnumstr<-isolate(as.numeric(strsplit(input$enrichseqnum,"-|;|,")[[1]]))
        if(input$equalheightif){
          equalh<-"probability"
        }else{
          equalh<-"bits"
        }
        if(length(enrichseqnumstr)==1){
          enrichseq<-strsplit(motiffujidf$Enrich.seq[enrichseqnumstr],";")[[1]]
          ggseqlogo(enrichseq, method=equalh)+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }else{
          motiffujidf1<-motiffujidf[enrichseqnumstr[1]:enrichseqnumstr[2],]
          enrichseq<-lapply(motiffujidf1$Enrich.seq,function(x){
            xx<-strsplit(x,";")[[1]]
          })
          names(enrichseq)<-motiffujidf1$motif
          ggseqlogo(enrichseq, ncol = 2, method=equalh)+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }
        
        motiffujidf<-isolate(motiffujiout())
        enrichseqnumstr<-isolate(as.numeric(strsplit(input$enrichseqnum,"-|;|,")[[1]]))
        if(input$equalheightif){
          equalh<-"probability"
        }else{
          equalh<-"bits"
        }
        if(length(enrichseqnumstr)==1){
          enrichseq<-strsplit(motiffujidf$Enrich.seq[enrichseqnumstr],";")[[1]]
          ggseqlogo(enrichseq, method=equalh)+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }else{
          motiffujidf1<-motiffujidf[enrichseqnumstr[1]:enrichseqnumstr[2],]
          enrichseq<-lapply(motiffujidf1$Enrich.seq,function(x){
            xx<-strsplit(x,";")[[1]]
          })
          names(enrichseq)<-motiffujidf1$motif
          ggseqlogo(enrichseq, ncol = 2, method=equalh)+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }
      })
      output$motifplotdownload<-downloadHandler(
        filename = function(){paste("Motifplot_uploaded",usertimenum,".pdf",sep="")},
        content = function(file){
          pdf(file, width = motifplot_height()/100,height = motifplot_height()/100+3)
          print(motifplotout())
          dev.off()
        }
      )
      #blast motif plot
      output$motifblastplot<-renderPlot({
        if(input$loadseqdatatype==1){
          motifblastfujidf<-motiffujiblastout()
        }else{
          motifblastfujidf<-read.csv("Motif.Enrich_blast.csv",stringsAsFactors = F)
        }
        enrichseqnumstr<-isolate(as.numeric(strsplit(input$enrichseqnum,"-|;")[[1]]))
        if(input$equalheightif){
          equalh<-"probability"
        }else{
          equalh<-"bits"
        }
        if(length(enrichseqnumstr)==1){
          enrichseq<-strsplit(motifblastfujidf$Enrich.seq[enrichseqnumstr],";")[[1]]
          ggseqlogo(enrichseq, method=equalh)+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }else{
          motifblastfujidf1<-motifblastfujidf[enrichseqnumstr[1]:enrichseqnumstr[2],]
          enrichseq<-lapply(motifblastfujidf1$Enrich.seq,function(x){
            xx<-strsplit(x,";")[[1]]
          })
          names(enrichseq)<-motifblastfujidf1$motif
          ggseqlogo(enrichseq, ncol = 2, method=equalh)+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }
      },height = motifplot_height)
      motifblastplotout<-reactive({
        if(input$loadseqdatatype==1){
          motifblastfujidf<-motiffujiblastout()
        }else{
          motifblastfujidf<-read.csv("Motif.Enrich_blast.csv",stringsAsFactors = F)
        }
        enrichseqnumstr<-isolate(as.numeric(strsplit(input$enrichseqnum,"-|;")[[1]]))
        if(input$equalheightif){
          equalh<-"probability"
        }else{
          equalh<-"bits"
        }
        if(length(enrichseqnumstr)==1){
          enrichseq<-strsplit(motifblastfujidf$Enrich.seq[enrichseqnumstr],";")[[1]]
          ggseqlogo(enrichseq, method=equalh)+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }else{
          motifblastfujidf1<-motifblastfujidf[enrichseqnumstr[1]:enrichseqnumstr[2],]
          enrichseq<-lapply(motifblastfujidf1$Enrich.seq,function(x){
            xx<-strsplit(x,";")[[1]]
          })
          names(enrichseq)<-motifblastfujidf1$motif
          ggseqlogo(enrichseq, ncol = 2, method=equalh)+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }
      })
      output$motifblastplotdl<-downloadHandler(
        filename = function(){paste("Motifplot_blast",usertimenum,".pdf",sep="")},
        content = function(file){
          pdf(file, width = motifplot_height()/100,height = motifplot_height()/100+3)
          print(motifblastplotout())
          dev.off()
        }
      )
    }
  )
  #
  phositealigndfout1<-reactive({
    withProgress(message = 'Loading database...',min = 0, max = 2, style = "notification",{
      shiny::incProgress(1, detail = "")
      uniprotkb_9606_reviewed<-read.xlsx("uniprotkb_9606_reviewed.xlsx")
      eukyblastreslist.nbtdf<-data.table::fread("eukyblastreslist.nbtdf.csv.gz")
    })
    list(uniprotkb_9606_reviewed=uniprotkb_9606_reviewed,eukyblastreslist.nbtdf=eukyblastreslist.nbtdf)
  })
  observeEvent(
    input$prophosite_btn,{
      shinyjs::show(id = "hiddendivv1", anim = FALSE)
      shinyjs::show(id = "hiddendiv7", anim = FALSE)
      shinyjs::show(id = "hiddendiv8", anim = FALSE)
      phositealigndfout<-reactive({
        uniprotkb_9606_reviewed<<-phositealigndfout1()$uniprotkb_9606_reviewed
        eukyblastreslist.nbtdf<<-phositealigndfout1()$eukyblastreslist.nbtdf
        withProgress(message = 'Searching...',min = 0, max = 1, style = "notification",{
          shiny::incProgress(1/2, detail = "")
          checkid<<-isolate(toupper(input$prophosite))
          checkid1<-strsplit(checkid,"_")[[1]]
          checkidindex<-unique(c(which(uniprotkb_9606_reviewed$Entry==toupper(checkid1[1])),
                                 which(uniprotkb_9606_reviewed$Entry.Name==toupper(checkid1[1]))))
          if(length(checkidindex)>0){
            checkid2<-paste0(uniprotkb_9606_reviewed$Entry[checkidindex],"_",checkid1[2])
            xx1<-paste0(eukyblastreslist.nbtdf$uniprot,"_",eukyblastreslist.nbtdf$residue,
                        eukyblastreslist.nbtdf$position)
            xx1index<-which(xx1==checkid2)
            if(length(xx1index)>0){
              pipeidf<-eukyblastreslist.nbtdf[xx1index,]
              colnames(pipeidf)<-c("Uniprot.Human","Position.Human","Center.amino.acids.Human","Seqwindows.Human",
                                   "Center.amino.acids.Other","Seqwindows.Other","Uniprot.Other",
                                   "Position.Other","Taxonomy.ID")
              pipeidf<<-pipeidf[,c(1,3,2,4,7,5,8,6,9)]
              pipeidf$Taxonomy<-unlist(lapply(pipeidf$Taxonomy.ID,function(x){
                metabopath_spedf[[2]][which(metabopath_spedf[[1]]==x)]
              }))
            }else{
              pipeidf<-data.frame(Nothing="Nothing found here!")
            }
          }else{
            pipeidf<-data.frame(Nothing="Nothing found here!")
          }
        })
        pipeidf
      })
      ##
      output$phositealignplot<-renderPlot({
        library(ggplot2)
        library(ggseqlogo)
        phositdf<<-phositealigndfout()
        if(ncol(phositdf)==1){
          plot(c(0, 1), c(0, 1),type='n', xlab='', ylab='', main='', xaxt='n',yaxt='n')
          text(0.5, 0.5, 'nothing plot here!', cex=2)
        }else{
          enrichseq<-phositdf$Seqwindows.Other
          ggseqlogo(enrichseq, method="probability")+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }
      })
      phositealignplotout<-reactive({
        phositdf<<-phositealigndfout()
        if(ncol(phositdf)==1){
          plot(c(0, 1), c(0, 1),type='n', xlab='', ylab='', main='', xaxt='n',yaxt='n')
          text(0.5, 0.5, 'nothing plot here!', cex=2)
        }else{
          enrichseq<-phositdf$Seqwindows.Other
          ggseqlogo(enrichseq, method="probability")+
            scale_x_discrete(limits=as.character(-input$minseqs:input$minseqs))+
            theme(axis.text=element_text(size=14),strip.text = element_text(size=18),
                  axis.title=element_text(size=16),legend.text = element_text(size = 12),
                  legend.title = element_text(size = 13))
        }
      })
      output$phositealignplotdl<-downloadHandler(
        filename = function(){paste("Motifplot_PhosphoSite.across.129.species.",usertimenum,".pdf",sep="")},
        content = function(file){
          pdf(file, width = motifplot_height()/100,height = motifplot_height()/100+3)
          print(phositealignplotout())
          dev.off()
        }
      )
      ##
      output$phositealigndf<-renderDataTable({
        datatable(phositealigndfout(), options = list(pageLength = 5))
      })
      output$phositealigndfdl<-downloadHandler(
        filename = function(){paste("PhosphoSite.aligned.",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(phositealigndfout(),file,row.names=FALSE)
        }
      )
      ##
      pwmsimilaritydfout<-reactive({
        library(KinSwingR)
        phositdf<<-phositealigndfout()
        if(ncol(phositdf)==1){
          pipeidfx<-data.frame(Nothing="Nothing found here!")
        }else{
          pepseqdf<-data.frame(kinase=phositdf$Uniprot.Human,substrate=phositdf$Seqwindows.Other,stringsAsFactors = F)
          pepseq<-buildPWM(as.matrix(pepseqdf),wild_card = c("_","-","U"),substrates_n=1)
          pepseq1<-round((2^pepseq$pwm[[1]]-0.01)/20,digits = 7)
          ksdf<-fread("Kinase_Substrate_Dataset",data.table = FALSE)
          ksdf1<<-ksdf[ksdf$KIN_ORGANISM=="human" & ksdf$SUB_ORGANISM=="human",c("KINASE","SITE_+/-7_AA")]
          colnames(ksdf1)<-c("kinase","substrate")
          ksdf2<-table(ksdf1$kinase)[table(ksdf1$kinase)>=5]
          ksdf3<-ksdf1[ksdf1$kinase%in%names(ksdf2),]
          ksdf3$kinase<-toupper(ksdf3$kinase)
          ksdf3$substrate<-toupper(ksdf3$substrate)
          ksdf3pwm<-buildPWM(as.matrix(ksdf3),wild_card = c("_","-","U"))
          euclidean_distance_pwm<-function(pwm1,pwm2){
            # 提取PWM的权重矩阵
            weights1 <- as.matrix(pwm1)
            weights2 <- as.matrix(pwm2)
            width = ncol(weights1)
            diffMatrix = (weights1 - weights2)^2
            PWMDistance = sum(sqrt(colSums(diffMatrix)))/sqrt(2)/width
            return(PWMDistance) 
          }
          cosine_similarity_pwm<-function(pwm1,pwm2){
            # 提取PWM的权重
            pwm1 <- as.matrix(pwm1)
            pwm2 <- as.matrix(pwm2)
            # 归一化PWM
            weights1 <- pwm1 #/ sum(pwm1)
            weights2 <- pwm2 #/ sum(pwm2)
            # 计算余弦相似性的分子部分（向量点积）
            dot_product <- sum(weights1 * weights2, na.rm = TRUE)
            # 计算余弦相似性的分母部分（向量的欧几里得范数）
            norm_weights1 <- sqrt(sum(weights1^2, na.rm = TRUE))
            norm_weights2 <- sqrt(sum(weights2^2, na.rm = TRUE))
            # 避免除以零
            if (norm_weights1 == 0 || norm_weights2 == 0) {
              return(0)
            }
            # 计算并返回余弦相似性
            similarity <- dot_product/(norm_weights1*norm_weights2)
            return(similarity)
          }
          PWMvec<-vector()
          for(i in 1:length(ksdf3pwm$pwm)){
            ksdf3pwmi<-round((2^ksdf3pwm$pwm[[i]]-0.01)/20,digits = 7)
            PWMvec[i]<-cosine_similarity_pwm(pepseq1,ksdf3pwmi)
          }
          PWMvec1<-ksdf3pwm$kinase
          PWMvec1$PWM_input<-isolate(toupper(input$prophosite))
          PWMvec1$Cosine.Similarity<-PWMvec
          pipeidfx<-PWMvec1[,c(3,1,4)]
          pipeidfx<-pipeidfx[order(pipeidfx[[3]],decreasing = T),]
          colnames(pipeidfx)<-c("PWM_input","PWM_PsP","Cosine.Similarity")
          rownames(pipeidfx)<-1:nrow(pipeidfx)
        }
        pipeidfx
      })
      output$pwmsimilaritydf<-renderDataTable({
        datatable(pwmsimilaritydfout(), options = list(pageLength = 10))
      })
      output$pwmsimilaritydfdl<-downloadHandler(
        filename = function(){paste("PWM.Similarity",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(pwmsimilaritydfout(),file,row.names=FALSE)
        }
      )
    }
  )
  #
  fastaseqout<-reactive({
    files <<- input$fastafile
    if(is.null(files)){
      datareadfasta<-NULL
    }else{
      datafasta<-readAAStringSet(files$datapath)
      pro_seqdf<-pro_seqdf1<-as.data.frame(datafasta)
      pro_seqdf_rown1<-unlist(lapply(rownames(pro_seqdf1),function(x) strsplit(x,"\\|")[[1]][1]))
      pro_seqdf_rown2<-unlist(lapply(rownames(pro_seqdf1),function(x) strsplit(x,"\\|")[[1]][2]))
      if(sum(duplicated(pro_seqdf_rown1))>=1 & sum(duplicated(pro_seqdf_rown2))>=1){
        pro_seqdf_rown<-rownames(pro_seqdf1)
      }
      else if(sum(duplicated(pro_seqdf_rown1))>=1){
        pro_seqdf_rown<-pro_seqdf_rown2
      }
      else if(sum(duplicated(pro_seqdf_rown2))>=1){
        pro_seqdf_rown<-pro_seqdf_rown1
      }
      else{
        pro_seqdf_rown<-rownames(pro_seqdf1)
      }
      rownames(pro_seqdf1)<-pro_seqdf_rown
      pro_seqdfncar<-unlist(lapply(pro_seqdf1$x,nchar))
      pro_seqdf<-pro_seqdf1[pro_seqdfncar>20,,drop=FALSE]
      n_data_fasta<-nrow(pro_seqdf)
      danlength<-input$minseqs
      wincenter<-strsplit(input$centralres,"")[[1]]
      seqwindowsall_S<-vector()
      seqnamesall_S<-vector()
      wincenteri<-vector()
      k<-1
      for(ii in wincenter){
        withProgress(message = paste('Generating data',ii), style = "notification", detail = "index 1", value = 0,{
          for(i in 1:n_data_fasta){
            seqindex1<-stri_locate_all(pattern = ii, pro_seqdf$x[i], fixed = TRUE)[[1]][,1]
            if(length(seqindex1)>0){
              seqnchar<-nchar(pro_seqdf$x[i])
              seqseq<-vector()
              for(j in 1:length(seqindex1)){
                indexjian1<-seqindex1[j]-danlength
                indexjian2<-seqindex1[j]+danlength
                if(indexjian1<=0){
                  xhx1<-paste(rep("_",abs(indexjian1)+1),collapse ="")
                  xhx2<-stri_sub(pro_seqdf$x[i],from = 0,to=indexjian2)
                  xhx3<-paste0(xhx1,xhx2)
                }
                else if(indexjian2>seqnchar){
                  xhx1<-paste(rep("_",(indexjian2-seqnchar)),collapse="")
                  xhx2<-stri_sub(pro_seqdf$x[i],from = indexjian1,to=seqnchar)
                  xhx3<-paste0(xhx2,xhx1)
                }
                else{
                  xhx3<-stri_sub(pro_seqdf$x[i],from = indexjian1,to=indexjian2)
                }
                seqwindowsall_S[k]<-xhx3
                seqnamesall_S[k]<-rownames(pro_seqdf)[i]
                wincenteri[k]<-ii
                k<-k+1
              }
            }
            incProgress(1/n_data_fasta, detail = paste("index", i))
          }
        })
      }
      datareadfasta<-data.frame(ID=seqnamesall_S,Windows=seqwindowsall_S,
                                Center=wincenteri,stringsAsFactors = F)
    }
    datareadfasta
  })
  observeEvent(
    input$mcsbtn_fastaalign,{
      output$allfasta<-renderDataTable({
        if(input$refastafileif){
          datareaddq<-isolate(fastaseqout())
        }else{
          datareaddq<-isolate(fastaseqownout())
        }
        datatable(datareaddq, options = list(pageLength = 10))
      })
      output$allfastadl<-downloadHandler(
        filename = function(){paste("Fasta.align_data",usertimenum,".csv",sep="")},
        content = function(file){
          fwrite(fastaseqout(),file)
        }
      )
    }
  )
  #
  kinasedataout<-reactive({
    library(ggraph)
    library(ggrepel)
    library(graphlayouts)
    library(scales)
    library(impute)
    library(igraph)
    library(scatterpie)
    library(plotfunctions)
    library(mapplots)
    #load(file = "PSP_NetworKIN_Kinase_Substrate_Dataset_July2016.rdata")
    KSData<-read.csv("Kinase_Substrate_Dataset.csv",stringsAsFactors = F)
    KSData.filter<-KSData[,c(1,3,7,8)]#,4,9
    datareaddqblast<<-blastresout2()
    datareaddqblast<-datareaddqblast[datareaddqblast$Center.aa.match!="Not match",]
    if(input$annotationxuanze==1){
      datareaddqblast1<-datareaddqblast[,c("Pep.upload","Pep.all.index","Center.amino.acid",
                                           "Seqwindows","PRO.from.Database","PROindex.from.Database")]
      datareaddqblast2<-base::merge(datareaddqblast1,KSData.filter,by.x="PRO.from.Database",
                                    by.y="KIN_ACC_ID",sort=FALSE)
      datareaddqblast2<-datareaddqblast2[,c(1,8,2:7,9)]
      #if(input$matchtypex==1){
      #  datareaddqblast2<-base::merge(datareaddqblast1,KSData.filter,by.x="PRO.from.Database",
      #                                  by.y="KIN_ACC_ID",sort=FALSE)
      #  datareaddqblast2<-datareaddqblast2[,c(1,8,2:7,9)]
      #}else{
      #  datareaddqblast2<-base::merge(datareaddqblast1,KSData.filter,by.x="PRO.from.Database",
      #                                  by.y="SUB_ACC_ID",sort=FALSE)
      #  datareaddqblast2<-datareaddqblast2[,c(8,1:7,9)]
      #}
      datareaddqblast3<-unique(datareaddqblast2)
      colnames(datareaddqblast3)[1:2]<-c("KIN_ACC_ID","SUB_ACC_ID")
    }
    
    if(input$annotationxuanze==2){
      datareaddqblast1<-datareaddqblast[,c("Pep.upload","Pep.all.index","Center.amino.acids.Other",
                                           "Seqwindows.Other","PRO.from.Other","PROindex.from.Other")]
      datareaddqblast2<-base::merge(datareaddqblast1,KSData.filter,by.x="PRO.from.Other",
                                    by.y="KIN_ACC_ID",sort=FALSE)
      datareaddqblast2<-datareaddqblast2[,c(1,8,2:7,9)]
      #if(input$matchtypex==1){
      #  datareaddqblast2<-base::merge(datareaddqblast1,KSData.filter,by.x="PRO.from.Other",
      #                                by.y="KIN_ACC_ID",sort=FALSE)
      #  datareaddqblast2<-datareaddqblast2[,c(1,8,2:7,9)]
      #}else{
      #  datareaddqblast2<-base::merge(datareaddqblast1,KSData.filter,by.x="PRO.from.Other",
      #                                by.y="SUB_ACC_ID",sort=FALSE)
      #  datareaddqblast2<-datareaddqblast2[,c(8,1:7,9)]
      #}
      datareaddqblast3<-unique(datareaddqblast2)
      colnames(datareaddqblast3)[1:2]<-c("KIN_ACC_ID","SUB_ACC_ID")
    }
    if(input$annotationxuanze==3){
      datareaddqblast3<-data.frame(KIN_ACC_ID="ALL",stringsAsFactors = F)
    }
    #if(input$annotationxuanze==6){
    #  load(file = "human.nbtlistdf.rdata")
    #  ksdfx<-fread("Kinase_Substrate_Dataset",data.table = FALSE)
    #  ksdf.human<-ksdfx[ksdfx$KIN_ORGANISM=="human"&ksdfx$SUB_ORGANISM=="human",]
    #  ksdf.human1<-unique(ksdf.human[,c(1,3,7,8)])
    #  ksdf.human2<-ksdf.human1[ksdf.human1$KIN_ACC_ID%in%human.nbtlistdf$uniprot,]
    #  PsP.kinases.id<-names(sort(table(ksdf.human2$KIN_ACC_ID),decreasing = T))
    #  PsP.kinases<-ksdf.human2$GENE[unlist(lapply(PsP.kinases.id,function(x){
    #    which(ksdf.human2$KIN_ACC_ID==x)[1]
    #  }))]
    #  N.total<-nrow(human.nbtlistdf)
    #  x2<-datareaddqblast[,#datareaddqblast$PRO.from.Other%in%PsP.kinases.id,
    #                      c("Pep.upload","Pep.all.index","Center.amino.acids.Other",
    #                         "Seqwindows.Other","PRO.from.Other","PROindex.from.Other")]
    #  N.mat.p<-KS.Ratio<-Bg.Ratio<-SubstrateNum<-Direction<-Substrates<-vector()
    #  for(j in 1:length(PsP.kinases.id)){
    #    KSj<-ksdf.human2[ksdf.human2$KIN_ACC_ID==PsP.kinases.id[j],]
    #    Bg.KSj<-human.nbtlistdf[human.nbtlistdf$uniprot%in%KSj$SUB_ACC_ID,]
    #    Bg.Q.inter<-intersect(paste0(Bg.KSj$uniprot,"_",Bg.KSj$residue,Bg.KSj$position),
    #                          paste0(x2$PRO.from.Other,"_",x2$Center.amino.acids.Other,x2$PROindex.from.Other))
    #    N1<-N.total-nrow(x2)-nrow(Bg.KSj)+length(Bg.Q.inter)
    #    N2<-nrow(Bg.KSj)-length(Bg.Q.inter)
    #    N3<-nrow(x2)-length(Bg.Q.inter)
    #    N4<-length(Bg.Q.inter)
    #    N.mat<-matrix(c(N2,N4,N1,N3),byrow = T,nrow = 2)
    #    N.mat.fisher<-fisher.test(N.mat)
    #    N.mat.p[j]<-N.mat.fisher$p.value
    #    KS.Ratio[j]<-paste0(N4,"/",nrow(x2))
    #    Bg.Ratio[j]<-paste0(nrow(Bg.KSj),"/",N.total)
    #    SubstrateNum[j]<-N4
    #    Direction[j]<-ifelse(N4/nrow(x2)>nrow(Bg.KSj)/N.total,"greater","less")
    #    Substrates[j]<-paste(Bg.Q.inter,collapse = "/")
    #  }
    #  Segments.KS.enrich<-data.frame(Kinases.ID=PsP.kinases.id,
    #                                  Kinases=PsP.kinases,KS.Ratio=KS.Ratio,Bg.Ratio=Bg.Ratio,
    #                                  SubstrateNum=SubstrateNum,Direction=Direction,
    #                                  P.val=N.mat.p,Substrates=Substrates)
    #  Segments.KS.enrich$P.adj<-p.adjust(Segments.KS.enrich$P.val,method = "BH")
    #  datareaddqblast3<-Segments.KS.enrich[Segments.KS.enrich$SubstrateNum!=0,c(1:7,9,8)]
    #  datareaddqblast3[order(datareaddqblast3$P.adj),]
    #}
    datareaddqblast3
  })
  
  output$kinasemotifui<-renderUI({
    if(input$annotationxuanze==1|input$annotationxuanze==2){
      kkdf<-kinasedataout()
      kkdfs<-c("All",unique(kkdf$KIN_ACC_ID))
    }else{
      kkdfs<-"All"
    }
    selectInput("kinasemotif","Select one or more kinases for network plot:",choices = kkdfs,selected = "All",multiple = TRUE)
    #bsTooltip("kinasemotif","By default, 'All' is selected and means selecting all kinases to plot network. Otherwise, users can delete 'All' and select one or several kinases to plot network.",
    #          placement = "right",options = list(container = "body"))
  })
  
  kinasedataxout<-reactive({
    library(ggraph)
    library(ggrepel)
    library(graphlayouts)
    library(scales)
    library(impute)
    library(igraph)
    library(scatterpie)
    library(plotfunctions)
    library(mapplots)
    #load(file = "PSP_NetworKIN_Kinase_Substrate_Dataset_July2016.rdata")
    KSData<-read.csv("Kinase_Substrate_Dataset.csv",stringsAsFactors = F)
    KSData.filter<-KSData[,c(1,3,7,8,10)]#,4,9
    datareaddqblast<<-blastresout2()
    datareaddqblast<-datareaddqblast[datareaddqblast$Center.aa.match!="Not match",]
    load(file = "human.nbtlistdf.rdata")
    ksdfx<<-fread("Kinase_Substrate_Dataset",data.table = FALSE)
    ksdf.human<-ksdfx[ksdfx$KIN_ORGANISM=="human"&ksdfx$SUB_ORGANISM=="human",]
    ksdf.human1<-unique(ksdf.human[,c(1,3,7,8,10)])
    ksdf.human2<-ksdf.human1[ksdf.human1$KIN_ACC_ID%in%human.nbtlistdf$uniprot,]
    PsP.kinases.id<-names(sort(table(ksdf.human2$KIN_ACC_ID),decreasing = T))
    PsP.kinases<-ksdf.human2$GENE[unlist(lapply(PsP.kinases.id,function(x){
      which(ksdf.human2$KIN_ACC_ID==x)[1]
    }))]
    N.total<-nrow(human.nbtlistdf)
    x2<-datareaddqblast[,#datareaddqblast$PRO.from.Other%in%PsP.kinases.id,
                        c("Pep.upload","Pep.all.index","Center.amino.acids.Other",
                          "Seqwindows.Other","PRO.from.Other","PROindex.from.Other")]
    N.mat.p<-KS.Ratio<-Bg.Ratio<-SubstrateNum<-Direction<-Substrates<-vector()
    withProgress(message = 'Motif Enrichment:',min = 0, max = length(PsP.kinases.id), style = "notification", detail = "Generating data", value = 1,{
      for(j in 1:length(PsP.kinases.id)){
        KSj<-ksdf.human2[ksdf.human2$KIN_ACC_ID==PsP.kinases.id[j],]
        #Bg.KSj<-human.nbtlistdf[human.nbtlistdf$uniprot%in%KSj$SUB_ACC_ID,]
        Bg.KSj<-human.nbtlistdf[paste0(human.nbtlistdf$uniprot,"_",
                                       human.nbtlistdf$residue,
                                       human.nbtlistdf$position)%in%paste0(KSj$SUB_ACC_ID,"_",KSj$SUB_MOD_RSD),]
        Bg.Q.inter<-intersect(paste0(Bg.KSj$uniprot,"_",Bg.KSj$residue,Bg.KSj$position),
                              paste0(x2$PRO.from.Other,"_",x2$Center.amino.acids.Other,x2$PROindex.from.Other))
        N1<-N.total-nrow(x2)-nrow(Bg.KSj)+length(Bg.Q.inter)
        N2<-nrow(Bg.KSj)-length(Bg.Q.inter)
        N3<-nrow(x2)-length(Bg.Q.inter)
        N4<-length(Bg.Q.inter)
        N.mat<-matrix(c(N2,N4,N1,N3),byrow = T,nrow = 2)
        N.mat.fisher<-fisher.test(N.mat)
        N.mat.p[j]<-N.mat.fisher$p.value
        KS.Ratio[j]<-paste0(N4,"/",nrow(x2))
        Bg.Ratio[j]<-paste0(nrow(Bg.KSj),"/",N.total)
        SubstrateNum[j]<-N4
        Direction[j]<-ifelse(N4/nrow(x2)>nrow(Bg.KSj)/N.total,"greater","less")
        Substrates[j]<-paste(Bg.Q.inter,collapse = "/")
        
        incProgress(1/length(PsP.kinases.id), detail = paste("index", j))
      }
    })
    Segments.KS.enrich<-data.frame(Kinases.ID=PsP.kinases.id,
                                   Kinases=PsP.kinases,KS.Ratio=KS.Ratio,Bg.Ratio=Bg.Ratio,
                                   SubstrateNum=SubstrateNum,Direction=Direction,
                                   P.val=N.mat.p,Substrates=Substrates)
    Segments.KS.enrich$P.adj<-p.adjust(Segments.KS.enrich$P.val,method = "BH")
    datareaddqblast3<-Segments.KS.enrich[Segments.KS.enrich$SubstrateNum!=0,c(1:7,9,8)]
    datareaddqblast3[order(datareaddqblast3$P.adj),]
  })
  
  observeEvent(
    input$mcsbtn_kniase,{
      shinyjs::show(id = "hiddendiv9", anim = FALSE)
      shinyjs::show(id = "hiddendiv10", anim = FALSE)
      shinyjs::show(id = "hiddendiv11", anim = FALSE)
      output$kinasedata<-renderDataTable({
        kinasedatadf<<-kinasedataout()
        if(nrow(kinasedatadf)==0){
          datareadxx<-data.frame(Description="No annotation data!")
          datatable(datareadxx)
        }else{
          kinasedatadf1<-paste0("https://www.uniprot.org/uniprot/",kinasedatadf[[1]])
          kinasedatadf[[1]]<-paste0("<a href='",kinasedatadf1,"' target='_blank'>",kinasedatadf[[1]],"</a>")
          kinasedatadf2<-paste0("https://www.uniprot.org/uniprot/",kinasedatadf[[2]])
          kinasedatadf[[2]]<-paste0("<a href='",kinasedatadf2,"' target='_blank'>",kinasedatadf[[2]],"</a>")
          datatable(kinasedatadf,escape = FALSE,selection="single",class = "cell-border hover",
                    options = list(pageLength = 10,columnDefs = list(list(className = 'dt-center', targets = 0:2))))
          #if(input$annotationxuanze==1|input$annotationxuanze==2){
          #  kinasedatadf1<-paste0("https://www.uniprot.org/uniprot/",kinasedatadf[[1]])
          #  kinasedatadf[[1]]<-paste0("<a href='",kinasedatadf1,"' target='_blank'>",kinasedatadf[[1]],"</a>")
          #  kinasedatadf2<-paste0("https://www.uniprot.org/uniprot/",kinasedatadf[[2]])
          #  kinasedatadf[[2]]<-paste0("<a href='",kinasedatadf2,"' target='_blank'>",kinasedatadf[[2]],"</a>")
          #  datatable(kinasedatadf,escape = FALSE,selection="single",class = "cell-border hover",
          #            options = list(pageLength = 10,columnDefs = list(list(className = 'dt-center', targets = 0:2))))
          #}else{
          #  kinasedatadf1<-paste0("https://www.uniprot.org/uniprot/",kinasedatadf[[1]])
          #  kinasedatadf[[1]]<-paste0("<a href='",kinasedatadf1,"' target='_blank'>",kinasedatadf[[1]],"</a>")
          #  datatable(kinasedatadf,escape = FALSE,selection="single",class = "cell-border hover",
          #            options = list(pageLength = 10,columnDefs = list(list(className = 'dt-center', targets = 0:2))))
          #}
        }
      })
      output$kinasedatadl<-downloadHandler(
        filename = function(){paste("KS.Annotation_data",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(kinasedataout(),file,row.names=FALSE)
        }
      )
      output$kinasedatax<-renderDataTable({
        if(input$loadseqdatatype==1){
          kinasedatadf<<-kinasedataxout()
        }else{
          kinasedatadf<<-read.csv("KS.Enrichment_data.csv",stringsAsFactors = F)
        }
        if(nrow(kinasedatadf)==0){
          datareadxx<-data.frame(Description="No annotation data!")
          datatable(datareadxx)
        }else{
          kinasedatadf1<-paste0("https://www.uniprot.org/uniprot/",kinasedatadf[[1]])
          kinasedatadf[[1]]<-paste0("<a href='",kinasedatadf1,"' target='_blank'>",kinasedatadf[[1]],"</a>")
          datatable(kinasedatadf,escape = FALSE,selection="single",class = "cell-border hover",
                    options = list(pageLength = 10,columnDefs = list(list(className = 'dt-center', targets = 0:2))))
        }
      })
      output$kinasedatadlx<-downloadHandler(
        filename = function(){paste("KS.Enrichment_data",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(kinasedataxout(),file,row.names=FALSE)
        }
      )
      #
      cmheatmap_height<-reactive({
        input$cmheatmap_height
      })
      cmheatmappicdataout<-reactive({
        kinasemotifx<<-input$kinasemotif
        dfmerge1<<-kinasedataout()
        if(kinasemotifx[1]=="All"){
          dfmerge<-dfmerge1
        }else{
          dfmerge<-dfmerge1[dfmerge1$KIN_ACC_ID%in%kinasemotifx,]
        }
        if(input$genenamesif){
          edgesdf<-data.frame(from=dfmerge$GENE,to=dfmerge$SUB_GENE,stringsAsFactors = FALSE)
          edgesdf<-unique(edgesdf)
          nodesdf1<-data.frame(name=c(dfmerge$GENE,dfmerge$SUB_GENE),
                               Groups=c(rep("Kinase",length(dfmerge$GENE)),rep("Substrate",length(dfmerge$SUB_GENE))),
                               stringsAsFactors = FALSE)
          nodesdf3<-nodesdf2<-unique(nodesdf1)
          jiaohudouyou<-intersect(dfmerge$GENE,dfmerge$SUB_GENE)
          if(length(jiaohudouyou)>0) nodesdf3$Groups[nodesdf2$name %in% jiaohudouyou]<-"Combine"
          nodesdf<-unique(nodesdf3)
        }else{
          edgesdf<-data.frame(from=dfmerge$KIN_ACC_ID,to=dfmerge$SUB_ACC_ID,stringsAsFactors = FALSE)
          edgesdf<-unique(edgesdf)
          nodesdf1<-data.frame(name=c(dfmerge$KIN_ACC_ID,dfmerge$SUB_ACC_ID),
                               Groups=c(rep("Kinase",length(dfmerge$KIN_ACC_ID)),rep("Substrate",length(dfmerge$SUB_ACC_ID))),
                               stringsAsFactors = FALSE)
          nodesdf3<-nodesdf2<-unique(nodesdf1)
          jiaohudouyou<-intersect(dfmerge$KIN_ACC_ID,dfmerge$SUB_ACC_ID)
          if(length(jiaohudouyou)>0) nodesdf3$Groups[nodesdf2$name %in% jiaohudouyou]<-"Combine"
          nodesdf<-unique(nodesdf3)
        }
        list(nodesdf=nodesdf,edgesdf=edgesdf)
      })
      output$cmheatmappic<-renderPlot({
        nodesdf<-cmheatmappicdataout()$nodesdf
        edgesdf<-cmheatmappicdataout()$edgesdf
        gp<-graph_from_data_frame(edgesdf, directed=TRUE, vertices=nodesdf)
        V(gp)$Groups <- nodesdf$Groups
        #,layout="stress"
        ggraph(gp, layout = 'kk')+
          geom_edge_link(aes(col=I("grey60")),width=0.6,arrow = arrow(length = unit(4, 'mm')),show.legend=FALSE)+
          geom_node_point(aes(col=Groups),size=5)+geom_node_text(aes(label = name), nudge_x = 0.1, nudge_y = 0.2)+
          scale_color_brewer(palette = "Set1")+
          theme_graph(base_family="sans")
      },height = cmheatmap_height)
      cmheatmappicout<-reactive({
        nodesdf<-cmheatmappicdataout()$nodesdf
        edgesdf<-cmheatmappicdataout()$edgesdf
        gp<-graph_from_data_frame(edgesdf, directed=TRUE, vertices=nodesdf)
        V(gp)$Groups <- nodesdf$Groups
        #,layout="stress"
        ggraph(gp, layout = 'kk')+
          geom_edge_link(aes(col=I("grey60")),width=0.6,arrow = arrow(length = unit(4, 'mm')),show.legend=FALSE)+
          geom_node_point(aes(col=Groups),size=5)+geom_node_text(aes(label = name), nudge_x = 0.1, nudge_y = 0.2)+
          scale_color_brewer(palette = "Set1")+
          theme_graph(base_family="sans")
      })
      output$cmheatmappicdl<-downloadHandler(
        filename = function(){paste("KinaseSubstrate_network",usertimenum,".pdf",sep="")},
        content = function(file){
          pdf(file, width = cmheatmap_height()/80+3,height = cmheatmap_height()/80+2)
          print(cmheatmappicout())
          dev.off()
        }
      )
      output$nodetableres<-renderDataTable({
        datatable(cmheatmappicdataout()$nodesdf)
      })
      output$nodetableresdl<-downloadHandler(
        filename = function(){paste("Nodesdata",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(cmheatmappicdataout()$nodesdf,file,row.names=FALSE)
        }
      )
      output$edgetableres<-renderDataTable({
        datatable(cmheatmappicdataout()$edgesdf)
      })
      output$edgetableresdl<-downloadHandler(
        filename = function(){paste("Edgesdata",usertimenum,".csv",sep="")},
        content = function(file){
          write.csv(cmheatmappicdataout()$edgesdf,file,row.names=FALSE)
        }
      )
    }
  )
  #####Interaction data
  examplepeakdatas<-reactive({
    dataread<-read.csv("Expression_Exampledata.csv",stringsAsFactors = F,check.names = F)
    dataread
  })
  exampleinterdataout<-reactive({
    dataread2<-read.csv("SARS_HumanProteins.csv",stringsAsFactors = FALSE)
    dataread2
  })
  output$loaddatadownload1<-downloadHandler(
    filename = function(){paste("Example_ExpressionData_",usertimenum,".csv",sep="")},
    content = function(file){
      write.csv(examplepeakdatas(),file,row.names = FALSE)
    }
  )
  output$interdatadownload1<-downloadHandler(
    filename = function(){paste("Example_InteractionData_",usertimenum,".csv",sep="")},
    content = function(file){
      write.csv(exampleinterdataout(),file,row.names = FALSE)
    }
  )
  peaksdataout<-reactive({
    files1 <- input$file1
    if(is.null(files1)){
      dataread<-data.frame(Description="PTMoreR detects that you do not upload your data. Please upload the expression data, or load the example data to check first.")
      list(yuanshidf=dataread)
    }else{
      if(sum(input$firstcol)==1){
        rownametf<-1
      }else{
        rownametf<-NULL
      }
      dataread<-read.csv(files1$datapath,header=input$header,
                         row.names = rownametf,stringsAsFactors = F)
      dataread1<-dataread[,-c(1,2,3)]
      dataread2<-dataread[,c(1,2,3)]
      #rowpaste<-apply(dataread2,1,function(x){
      #  paste0(x,collapse = "_")
      #})
      rowpaste<-paste0(dataread2$PTM.ProteinId,"_",dataread2$PTM.SiteAA,"_",dataread2$PTM.SiteLocation)
      dataread1x<-dataread1[!duplicated(rowpaste),]
      rownames(dataread1x)<-rowpaste[!duplicated(rowpaste)]
      list(yuanshidf=dataread,yuanshidata=dataread1x,objectinfo=dataread2)
    }
  })
  output$peaksdata<-renderDataTable({
    if(input$loaddatatype==1){
      datatable(peaksdataout()$yuanshidf, options = list(pageLength = 10))
    }else{
      datatable(examplepeakdatas(), options = list(pageLength = 10))
    }
  })
  interactiondataout<-reactive({
    files1 <- input$Interfile1
    if(is.null(files1)){
      dataread<-data.frame(Description="PTMoreR detects that you do not upload your data. Please upload the interaction data, or load the example data to check first.")
      dataread
    }else{
      if(sum(input$firstcol)==1){
        rownametf<-1
      }else{
        rownametf<-NULL
      }
      dataread<-read.csv(files1$datapath,header=input$header,
                         row.names = rownametf,stringsAsFactors = F)
      dataread
    }
    dataread
  })
  output$interactiondata<-renderDataTable({
    if(input$loaddatatype==1){
      datatable(interactiondataout(), options = list(pageLength = 10))
    }else{
      datatable(exampleinterdataout(), options = list(pageLength = 10))
    }
  })
  processedEdataout<-reactive({
    if(input$loaddatatype==1){
      nadatax<-peaksdataout()$yuanshidata
    }else{
      dataread<-examplepeakdatas()
      dataread1<-dataread[,-c(1,2,3)]
      dataread2<-dataread[,c(1,2,3)]
      #rowpaste<-apply(dataread2,1,function(x){
      #  paste0(x,collapse = "_")
      #})
      rowpaste<-paste0(dataread2$PTM.ProteinId,"_",dataread2$PTM.SiteAA,"_",dataread2$PTM.SiteLocation)
      dataread1x<-dataread1[!duplicated(rowpaste),]
      rownames(dataread1x)<-rowpaste[!duplicated(rowpaste)]
      nadatax<-dataread1x
    }
    datadfchuli<-nadatax
    if(input$mediannormif){
      medianval<-apply(datadfchuli,2,function(x) {median(x,na.rm = TRUE)})
      datadfchuli<-sweep(datadfchuli,2,medianval,FUN = "/")
    }
    if(input$logif){
      datadfchuli<-log2(datadfchuli)
    }
    narowsum<-apply(datadfchuli,1,function(x){sum(is.na(x))})/ncol(datadfchuli)
    datadfchuli<-datadfchuli[narowsum<=0.5,]
    data_zero1<-impute.knn(as.matrix(datadfchuli),k = 10, rowmax = 1, colmax = 1)
    datadfchuli1<<-data_zero1$data
    datadfchuli1
  })
  output$processedEdata<-renderDataTable({
    datatable(processedEdataout(), options = list(pageLength = 10))
  })
  output$processedEdatadl<-downloadHandler(
    filename = function(){paste("ProcessedExpressionData_",usertimenum,".csv",sep="")},
    content = function(file){
      write.csv(processedEdataout(),file)#,row.names = FALSE
    }
  )
  ##
  output$sarsproteinsui<-renderUI({
    if(input$loaddatatype==1){
      sarsdata<-interactiondataout()
    }else{
      sarsdata<-exampleinterdataout()
    }
    #sarsdata<<-read.csv("SARS_HumanProteins.csv",stringsAsFactors = FALSE)
    selectInput("sarsproteins",h5("3.5 Select one interacting protein:"),choices = unique(sarsdata[[1]]),selected = 1,multiple = FALSE)
    #bsTooltip("kinasemotif","By default, 'All' is selected and means selecting all kinases to plot network. Otherwise, users can delete 'All' and select one or several kinases to plot network.",
    #          placement = "right",options = list(container = "body"))
  })
  interactfigheightx<-reactive({
    input$interactfigheight
  })
  interactfigwidthx<-reactive({
    input$interactfigheight*0.8
  })
  output$interactplot<-renderPlot({
    if(is.null(input$sarsproteins)){
      sarsproteinsx<<-"nsp1"
    }else{
      sarsproteinsx<<-input$sarsproteins
    }
    
    if(input$loaddatatype==1){
      sarsdata<-interactiondataout()
      blastresoutx<-blastresout2()
      classnames<-strsplit(input$grnames,";")[[1]]
      grnum1<-as.numeric(strsplit(input$grnums,";")[[1]][1])
      classnamesnum<-as.numeric(strsplit(strsplit(input$grnums,";")[[1]][2],"-")[[1]])
    }else{
      sarsdata<-exampleinterdataout()
      blastresoutx<-read.csv("BlastToHuman_1628320018.448.csv",stringsAsFactors = FALSE)
      classnames<-strsplit(input$examgrnames,";")[[1]]
      grnum1<-as.numeric(strsplit(input$examgrnums,";")[[1]][1])
      classnamesnum<-as.numeric(strsplit(strsplit(input$examgrnums,";")[[1]][2],"-")[[1]])
    }
    sarsdata<<-sarsdata
    sarsdatanames<-colnames(sarsdata)
    blastresoutx<<-blastresoutx
    #sarsdata<<-read.csv("SARS_HumanProteins.csv",stringsAsFactors = FALSE)
    expressdata<<-processedEdataout()
    classnames<<-classnames
    classnamesnum<<-classnamesnum
    grinfo<<-rep(classnames,times=classnamesnum)
    #expressdata2<-as.data.frame(cbind(grinfo=factor(grinfo,levels=classnames),t(expressdata)))
    #expressdata3<-stats::aggregate(.~grinfo,expressdata2,mean)
    expressdata2<-NULL
    for(i in 1:length(classnames)){
      expressdata2i<-expressdata[,grinfo==classnames[i],drop=FALSE]
      expressdata2<-cbind(expressdata2,rowMeans(expressdata2i,na.rm = TRUE))
    }
    colnames(expressdata2)<-classnames
    ##
    sarsdata1<-sarsdata[sarsdata[[1]]==sarsproteinsx,]#$Bait
    expresspros<-unlist(lapply(rownames(expressdata2),function(x){
      strsplit(x,"_")[[1]][1]
    }))
    expresscaas<-unlist(lapply(rownames(expressdata2),function(x){
      strsplit(x,"_")[[1]][2]
    }))
    expresssites<-unlist(lapply(rownames(expressdata2),function(x){
      strsplit(x,"_")[[1]][3]
    }))
    expressphositesUpload<-paste0(expresspros,"_",paste0(expresscaas,expresssites))
    expressdata3<-as.data.frame(expressdata2)
    expressdata3$uploadpros<-expressphositesUpload
    blastresoutx2<-unique(blastresoutx[blastresoutx$PRO.from.Other%in%sarsdata1[[2]],
                                       c("PRO.CombinedID","PRO.CombinedID.Other")])#$Preys
    if(nrow(blastresoutx2)==0){
      blastresoutx2<-unique(blastresoutx[blastresoutx$PRO.from.Database%in%sarsdata1[[2]],
                                         c("PRO.CombinedID","PRO.CombinedID.Other")])
      expressdata4<-base::merge(blastresoutx2,expressdata3,by.x = "PRO.CombinedID", by.y = "uploadpros",sort=FALSE)
      PROComIDHuman<-expressdata4$PRO.CombinedID
      for(i in 1:length(sarsdata1[[2]])){#$Preys
        PROComIDHumani<-grep(sarsdata1[[2]][i],PROComIDHuman)#$Preys
        if(length(PROComIDHumani)>0){
          PROComIDHuman[PROComIDHumani]<-gsub(sarsdata1[[2]][i],sarsdata1$PreyGene[i],PROComIDHuman[PROComIDHumani])
        }
      }
      PROComIDHuman1<-unlist(lapply(PROComIDHuman,function(x){
        strsplit(x,"_")[[1]][1]
      }))
      PROComIDHuman2<-unlist(lapply(PROComIDHuman,function(x){
        strsplit(x,"_")[[1]][2]
      }))
      nodesdf<-data.frame(name=c(sarsproteinsx,unique(PROComIDHuman1),unique(PROComIDHuman2)),
                          group=c(sarsdatanames[1],rep(sarsdatanames[3],length(unique(PROComIDHuman1))),rep("Pho Site",length(unique(PROComIDHuman2)))),
                          size=c(2,rep(1,length(c(unique(PROComIDHuman1),unique(PROComIDHuman2))))))
      edgesdf<-data.frame(from=c(rep(sarsproteinsx,length(unique(PROComIDHuman1))),PROComIDHuman1),
                          to=c(unique(PROComIDHuman1),PROComIDHuman2))
    }else{
      expressdata4<-base::merge(blastresoutx2,expressdata3,by.x = "PRO.CombinedID", by.y = "uploadpros",sort=FALSE)
      PROComIDHuman<-expressdata4$PRO.CombinedID.Other
      for(i in 1:length(sarsdata1[[2]])){
        PROComIDHumani<-grep(sarsdata1[[2]][i],PROComIDHuman)
        if(length(PROComIDHumani)>0){
          PROComIDHuman[PROComIDHumani]<-gsub(sarsdata1[[2]][i],sarsdata1$PreyGene[i],PROComIDHuman[PROComIDHumani])
        }
      }
      PROComIDHuman1<-unlist(lapply(PROComIDHuman,function(x){
        strsplit(x,"_")[[1]][1]
      }))
      PROComIDHuman2<-unlist(lapply(PROComIDHuman,function(x){
        strsplit(x,"_")[[1]][2]
      }))
      nodesdf<-data.frame(name=c(sarsproteinsx,unique(PROComIDHuman1),unique(PROComIDHuman2)),
                          group=c(sarsdatanames[1],rep(sarsdatanames[3],length(unique(PROComIDHuman1))),rep("Pho Site",length(unique(PROComIDHuman2)))),
                          size=c(2,rep(1,length(c(unique(PROComIDHuman1),unique(PROComIDHuman2))))))
      edgesdf<-data.frame(from=c(rep(sarsproteinsx,length(unique(PROComIDHuman1))),PROComIDHuman1),
                          to=c(unique(PROComIDHuman1),PROComIDHuman2))
    }
    #expressphosites<-paste0(blastresoutx2$Center.amino.acids.Other,blastresoutx2$PROindex.from.Other)
    #expressdata3<-as.data.frame(expressdata2[expresspros%in%unique(blastresoutx2$PRO.from.Database),])
    #expressdata3$uploadpros<-expressphositesUpload[expresspros%in%unique(blastresoutx2$PRO.from.Database)]
    linkpp<-igraph::graph_from_data_frame(edgesdf, directed = FALSE, vertices = nodesdf)
    if(input$zscoreif){
      phositedata<-round(t(scale(t(expressdata4[,-c(1,2)]))),3)
    }else{
      phositedata<-round(expressdata4[,-c(1,2)],3)
    }
    map2color<-function(x,pal,limits=NULL){
      if(is.null(limits)) limits=range(x)
      pal[findInterval(x,seq(limits[1],limits[2],length.out=length(pal)+1), all.inside=TRUE)]
    }
    interactvaluecolx<-strsplit(input$interactvaluecol,";")[[1]]
    mypal<-colorRampPalette(c(interactvaluecolx))(50)
    pievalueslist<-rep(list(rep(1,ncol(phositedata))),nrow(nodesdf))
    pievaluescollist1<-list()
    for(i in 1:nrow(phositedata)){
      pievaluescollist1[[i]]<-map2color(phositedata[i,],mypal,limits = range(phositedata))
    }
    sarscolx<-input$sarscol
    humanprocolx<-input$humanprocol
    pievaluescollist<-c(list(sarscolx),rep(list(humanprocolx),length(unique(PROComIDHuman1))),
                        pievaluescollist1)
    set.seed(123)
    plot(linkpp,vertex.size=c(10,rep(8,length(c(unique(PROComIDHuman1),unique(PROComIDHuman2))))),
         vertex.shape=c("square",rep("circle",length(unique(PROComIDHuman1))),
                        rep("pie",length(unique(PROComIDHuman2)))),
         vertex.color=c(sarscolx,rep(humanprocolx,length(unique(PROComIDHuman1)))),vertex.frame.color="grey60",
         vertex.pie=pievalueslist,
         vertex.pie.color=pievaluescollist,
         vertex.label.dist=1.5,
         edge.width=2)
    legend(x = "bottomleft",legend = c(sarsdatanames[1],sarsdatanames[3]),pch = c(15,16),
           col = c(sarscolx,humanprocolx),bty = "n")#"SARS-CoV-2","Human"
    gradientLegend(valRange=c(min(phositedata),max(phositedata)), 
                   color=mypal,
                   border.col=NA,
                   pos=.5,pos.num=1,depth=0.03,
                   side=1,inside=TRUE)
    legend.pie(-1,1,labels=rev(colnames(phositedata)), radius=0.1, bty="n", cex=0.8, 
               col="white",label.dist=1.3)
  },height=interactfigheightx,width = interactfigwidthx)
  interactplotout<-reactive({
    sarsproteinsx<<-input$sarsproteins
    if(input$loaddatatype==1){
      sarsdata<-interactiondataout()
      blastresoutx<-blastresout2()
      classnames<-strsplit(input$grnames,";")[[1]]
      grnum1<-as.numeric(strsplit(input$grnums,";")[[1]][1])
      classnamesnum<-as.numeric(strsplit(strsplit(input$grnums,";")[[1]][2],"-")[[1]])
    }else{
      sarsdata<-exampleinterdataout()
      blastresoutx<-read.csv("BlastToHuman_1628320018.448.csv",stringsAsFactors = FALSE)
      classnames<-strsplit(input$examgrnames,";")[[1]]
      grnum1<-as.numeric(strsplit(input$examgrnums,";")[[1]][1])
      classnamesnum<-as.numeric(strsplit(strsplit(input$examgrnums,";")[[1]][2],"-")[[1]])
    }
    sarsdata<<-sarsdata
    sarsdatanames<-colnames(sarsdata)
    blastresoutx<<-blastresoutx
    #sarsdata<<-read.csv("SARS_HumanProteins.csv",stringsAsFactors = FALSE)
    expressdata<<-processedEdataout()
    classnames<<-classnames
    classnamesnum<<-classnamesnum
    grinfo<<-rep(classnames,times=classnamesnum)
    #expressdata2<-as.data.frame(cbind(grinfo=factor(grinfo,levels=classnames),t(expressdata)))
    #expressdata3<-stats::aggregate(.~grinfo,expressdata2,mean)
    expressdata2<-NULL
    for(i in 1:length(classnames)){
      expressdata2i<-expressdata[,grinfo==classnames[i],drop=FALSE]
      expressdata2<-cbind(expressdata2,rowMeans(expressdata2i,na.rm = TRUE))
    }
    colnames(expressdata2)<-classnames
    ##
    sarsdata1<-sarsdata[sarsdata[[1]]==sarsproteinsx,]#$Bait
    expresspros<-unlist(lapply(rownames(expressdata2),function(x){
      strsplit(x,"_")[[1]][1]
    }))
    expresscaas<-unlist(lapply(rownames(expressdata2),function(x){
      strsplit(x,"_")[[1]][2]
    }))
    expresssites<-unlist(lapply(rownames(expressdata2),function(x){
      strsplit(x,"_")[[1]][3]
    }))
    expressphositesUpload<-paste0(expresspros,"_",paste0(expresscaas,expresssites))
    expressdata3<-as.data.frame(expressdata2)
    expressdata3$uploadpros<-expressphositesUpload
    blastresoutx2<-unique(blastresoutx[blastresoutx$PRO.from.Other%in%sarsdata1[[2]],
                                       c("PRO.CombinedID","PRO.CombinedID.Other")])#$Preys
    if(nrow(blastresoutx2)==0){
      blastresoutx2<-unique(blastresoutx[blastresoutx$PRO.from.Database%in%sarsdata1[[2]],
                                         c("PRO.CombinedID","PRO.CombinedID.Other")])
      expressdata4<-base::merge(blastresoutx2,expressdata3,by.x = "PRO.CombinedID", by.y = "uploadpros",sort=FALSE)
      PROComIDHuman<-expressdata4$PRO.CombinedID
      for(i in 1:length(sarsdata1[[2]])){#$Preys
        PROComIDHumani<-grep(sarsdata1[[2]][i],PROComIDHuman)#$Preys
        if(length(PROComIDHumani)>0){
          PROComIDHuman[PROComIDHumani]<-gsub(sarsdata1[[2]][i],sarsdata1$PreyGene[i],PROComIDHuman[PROComIDHumani])
        }
      }
      PROComIDHuman1<-unlist(lapply(PROComIDHuman,function(x){
        strsplit(x,"_")[[1]][1]
      }))
      PROComIDHuman2<-unlist(lapply(PROComIDHuman,function(x){
        strsplit(x,"_")[[1]][2]
      }))
      nodesdf<-data.frame(name=c(sarsproteinsx,unique(PROComIDHuman1),unique(PROComIDHuman2)),
                          group=c(sarsdatanames[1],rep(sarsdatanames[3],length(unique(PROComIDHuman1))),rep("Pho Site",length(unique(PROComIDHuman2)))),
                          size=c(2,rep(1,length(c(unique(PROComIDHuman1),unique(PROComIDHuman2))))))
      edgesdf<-data.frame(from=c(rep(sarsproteinsx,length(unique(PROComIDHuman1))),PROComIDHuman1),
                          to=c(unique(PROComIDHuman1),PROComIDHuman2))
    }else{
      expressdata4<-base::merge(blastresoutx2,expressdata3,by.x = "PRO.CombinedID", by.y = "uploadpros",sort=FALSE)
      PROComIDHuman<-expressdata4$PRO.CombinedID.Other
      for(i in 1:length(sarsdata1[[2]])){
        PROComIDHumani<-grep(sarsdata1[[2]][i],PROComIDHuman)
        if(length(PROComIDHumani)>0){
          PROComIDHuman[PROComIDHumani]<-gsub(sarsdata1[[2]][i],sarsdata1$PreyGene[i],PROComIDHuman[PROComIDHumani])
        }
      }
      PROComIDHuman1<-unlist(lapply(PROComIDHuman,function(x){
        strsplit(x,"_")[[1]][1]
      }))
      PROComIDHuman2<-unlist(lapply(PROComIDHuman,function(x){
        strsplit(x,"_")[[1]][2]
      }))
      nodesdf<-data.frame(name=c(sarsproteinsx,unique(PROComIDHuman1),unique(PROComIDHuman2)),
                          group=c(sarsdatanames[1],rep(sarsdatanames[3],length(unique(PROComIDHuman1))),rep("Pho Site",length(unique(PROComIDHuman2)))),
                          size=c(2,rep(1,length(c(unique(PROComIDHuman1),unique(PROComIDHuman2))))))
      edgesdf<-data.frame(from=c(rep(sarsproteinsx,length(unique(PROComIDHuman1))),PROComIDHuman1),
                          to=c(unique(PROComIDHuman1),PROComIDHuman2))
    }
    #expressphosites<-paste0(blastresoutx2$Center.amino.acids.Other,blastresoutx2$PROindex.from.Other)
    #expressdata3<-as.data.frame(expressdata2[expresspros%in%unique(blastresoutx2$PRO.from.Database),])
    #expressdata3$uploadpros<-expressphositesUpload[expresspros%in%unique(blastresoutx2$PRO.from.Database)]
    linkpp<-igraph::graph_from_data_frame(edgesdf, directed = FALSE, vertices = nodesdf)
    if(input$zscoreif){
      phositedata<-round(t(scale(t(expressdata4[,-c(1,2)]))),3)
    }else{
      phositedata<-round(expressdata4[,-c(1,2)],3)
    }
    map2color<-function(x,pal,limits=NULL){
      if(is.null(limits)) limits=range(x)
      pal[findInterval(x,seq(limits[1],limits[2],length.out=length(pal)+1), all.inside=TRUE)]
    }
    interactvaluecolx<-strsplit(input$interactvaluecol,";")[[1]]
    mypal<-colorRampPalette(c(interactvaluecolx))(50)
    pievalueslist<-rep(list(rep(1,ncol(phositedata))),nrow(nodesdf))
    pievaluescollist1<-list()
    for(i in 1:nrow(phositedata)){
      pievaluescollist1[[i]]<-map2color(phositedata[i,],mypal,limits = range(phositedata))
    }
    sarscolx<-input$sarscol
    humanprocolx<-input$humanprocol
    pievaluescollist<-c(list(sarscolx),rep(list(humanprocolx),length(unique(PROComIDHuman1))),
                        pievaluescollist1)
    set.seed(123)
    plot(linkpp,vertex.size=c(10,rep(8,length(c(unique(PROComIDHuman1),unique(PROComIDHuman2))))),
         vertex.shape=c("square",rep("circle",length(unique(PROComIDHuman1))),
                        rep("pie",length(unique(PROComIDHuman2)))),
         vertex.color=c(sarscolx,rep(humanprocolx,length(unique(PROComIDHuman1)))),vertex.frame.color="grey60",
         vertex.pie=pievalueslist,
         vertex.pie.color=pievaluescollist,
         vertex.label.dist=1.5,
         edge.width=2)
    legend(x = "bottomleft",legend = c(sarsdatanames[1],sarsdatanames[3]),pch = c(15,16),
           col = c(sarscolx,humanprocolx),bty = "n")#"SARS-CoV-2","Human"
    gradientLegend(valRange=c(min(phositedata),max(phositedata)), 
                   color=mypal,
                   border.col=NA,
                   pos=.5,pos.num=1,depth=0.03,
                   side=1,inside=TRUE)
    legend.pie(-1,1,labels=rev(colnames(phositedata)), radius=0.1, bty="n", cex=0.8, 
               col="white",label.dist=1.3)
  })
  output$interactplotdl<-downloadHandler(
    filename = function(){paste("InteractionPlot",usertimenum,".pdf",sep="")},
    content = function(file){
      pdf(file,width = interactfigwidthx()/100+1,height = interactfigheightx()/100+1)
      print(interactplotout())
      dev.off()
    }
  )
}
shinyApp(ui = ui, server = server)
