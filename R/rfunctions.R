#' Runs the PTMoreR Shiny web application.
#' @export
PTMoreR_app <- function() {
  shiny::runApp(system.file('PTMoreRapp', package='PTMoreR'),
                host=getOption("0.0.0.0"), port =getOption("8989"))
}

#' Pre-alignment.
#' @export
prealign<-function(data,datatype="Normal",central.amino.acid="ST",
                   label.of.modification="#",width=7,
                   species.fasta.file="10116.fasta"){
  library(Biostrings)
  library(stringi)
  library(stringr)
  library(tidyr)
  dataread<-data
  if(ncol(dataread)==1){
    datareadx<-dataread
  }else{
    datareadx<-dataread[,2,drop=F]
  }
  origidatatypex<-datatype
  Peptides<-vector()
  if(origidatatypex=="MaxQuant"){
    for(i in 1:nrow(datareadx)){
      pep1<-datareadx[[1]][i]
      Peptidesi1<-strsplit(gsub("[^0-9.]", ";", pep1),";")[[1]]
      Peptidesi2<-Peptidesi1[Peptidesi1!=""]
      for(ii in 1:length(Peptidesi2)){
        if(as.numeric(Peptidesi2[ii])>=0.75){
          pep1<-gsub(paste0("\\(",Peptidesi2[ii],"\\)"),label.of.modification,pep1)#"#"
        }else{
          pep1<-gsub(paste0("\\(",Peptidesi2[ii],"\\)"),"",pep1)
        }
      }
      Peptides[i]<-pep1
    }
    dataconvert<-data.frame(AnnotatedPeps=Peptides,stringsAsFactors = FALSE)
  }else if(origidatatypex=="Spectronaut"){
    phosphoindex<-grep("\\[Phospho \\(STY\\)\\]",datareadx[[1]], perl = TRUE)
    uploaddata1<-datareadx[phosphoindex,]
    Peptidesx<-gsub("_","",uploaddata1, perl = TRUE)
    Peptidesx<-gsub("\\[Phospho \\(STY\\)\\]",label.of.modification,Peptidesx, perl = TRUE)#"#"
    Peptidesx2<-str_replace_all(Peptidesx,"\\[.*?\\]","")
    dataconvert<-data.frame(AnnotatedPeps=Peptidesx2,stringsAsFactors = FALSE)
  }else{
    dataconvert<-datareadx
  }
  dataconvertindex<-grep(label.of.modification,dataconvert[[1]])
  uploaddata2<-dataconvert[dataconvertindex,,drop=FALSE]
  if(ncol(uploaddata2)==1){
    uploaddata1<-datareaddq<-uploaddata2
  }else{
    uploaddata1<-datareaddq<-uploaddata2[,2,drop=F]
  }
  centralres1<-strsplit(label.of.modification,";|")[[1]]
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
  datafasta<-readAAStringSet(species.fasta.file)
  n_data_fasta<-length(datafasta@ranges@NAMES)
  pro_seqdf<-as.data.frame(datafasta)
  pro_seqdfnames<-unlist(lapply(rownames(pro_seqdf),function(x) strsplit(x,"\\|")[[1]][2]))
  if(sum(is.na(pro_seqdfnames))>n_data_fasta/2){
    pro_seqdfnames<-unlist(lapply(rownames(pro_seqdf),function(x) strsplit(x,"\\ ")[[1]][1]))
  }
  danlength<-width
  seqseqall<-vector()
  proidall<-vector()
  proidindexall<-vector()
  PRO.CombinedID<-vector()
  for(i in 1:nrow(uploaddata1)){
    seqindex1<-grep(uploaddata1$Stripped.pep[i],pro_seqdf$x, perl = TRUE)
    seqindex3<-as.numeric(strsplit(uploaddata1$Pep.main.index[i],";")[[1]])
    seqseqall1<-vector()
    proidindexall1<-vector()
    procomb<-vector()
    if(length(seqindex1)>0 & length(seqindex3)>0){
      for(k in 1:length(seqindex1)){
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
      seqseqall[i]<-paste(seqseqall1,collapse = "::")
      proidall[i]<-paste(pro_seqdfnames[seqindex1],collapse = "::")
      proidindexall[i]<-paste(proidindexall1,collapse = "::")
      PRO.CombinedID[i]<-paste(procomb,collapse = "::")
    }else{
      seqseqall[i]<-"No Match"
      proidall[i]<-"No Match"
      proidindexall[i]<-"No Match"
      PRO.CombinedID[i]<-"No Match"
    }
  }
  uploaddata1$Seqwindows<-seqseqall
  uploaddata1$PRO.from.Database<-proidall
  uploaddata1$PROindex.from.Database<-proidindexall
  uploaddata1$PRO.CombinedID<-PRO.CombinedID
  datareaddq<-unique(uploaddata1)
  datareaddq1<-separate_rows(datareaddq,6:9,sep = "::")
  datareaddq2<-unique(separate_rows(datareaddq1,3:9,sep = ";"))
  colnames(datareaddq2)<-c("Uploaded Peptides","Peptide Skeleton",
                          "Main Modification Site in Uploaded Peptides",
                          "All Modification Site in Uploaded Peptides",
                          "Center amino acid","Aligned Standard Peptides",
                          "Protein ID from Database",
                          "Modified Amino Acid Site in Protein Sequence",
                          "Combined Protein Identifier")
  datareaddq3<-datareaddq2[,c(1,7,5,8,9,6,2,3,4)]
  datareaddq3
}

#' Preparing blast data/files.
#' @export
blastedfile<-function(speciesid1 = "10090",fastafile1 = "",speciesid2 = "9606",
                      fastafile2 = "",savepath="."){
  library(metablastr)
  library(rBLAST)
  library(msa)
  library(Biostrings)
  library(data.table)
  print("###Starting BLASTing, mapping best matched proteins between two species...###")
  makeblastdb(file = fastafile2, db_name = paste0(speciesid2, "_db"), dbtype = "prot")
  dbx <- blast(paste0(speciesid2, "_db"), type = "blastp")
  seqx <- readAAStringSet(fastafile1)
  blast_best_other <- predict(dbx, seqx, BLAST_args = "-max_target_seqs 1 -num_threads 8")
  colnames(blast_best_other)[1:3] <- c("query_id", "subject_id", "perc_identity")
  blast_best_other$query_id <- unlist(lapply(blast_best_other$query_id, function(x) strsplit(x, "\\|")[[1]][2]))
  blast_best_other$subject_id <- unlist(lapply(blast_best_other$subject_id, function(x) strsplit(x, "\\|")[[1]][2]))
  blaseresdf<-blast_best_other
  fwrite(blast_best_other,file = paste0(savepath,"/",speciesid1,"_blast_best_",speciesid2,".csv"))
  ##
  print("###Starting BLASTing, align the protein sequences between each two best matched proteins...###")
  queryfasta<-readAAStringSet(fastafile1)
  queryfastadf<-queryfastadf1<-as.data.frame(queryfasta)
  rownames(queryfastadf)<-unlist(lapply(rownames(queryfastadf1),function(x){
    strsplit(x,"\\|")[[1]][2]
  }))
  subjectfasta<-readAAStringSet(fastafile2)
  subjectfastadf<-subjectfastadf1<-as.data.frame(subjectfasta)
  rownames(subjectfastadf)<-unlist(lapply(rownames(subjectfastadf1),function(x){
    strsplit(x,"\\|")[[1]][2]
  }))
  blastseqlist<-list()
  for(i in 1:nrow(blaseresdf)){
    qureyi<-blaseresdf$query_id[i]
    subjecti<-blaseresdf$subject_id[i]
    alignquery<-msa(c(queryfasta[rownames(queryfastadf)==qureyi],
                      subjectfasta[rownames(subjectfastadf)==subjecti]))
    alignquerydf<-as.data.frame(alignquery@unmasked)$x
    blastseqlist[[i]]<-alignquerydf
    if(i %% 100 == 0){
      print(paste("Processed", i, "records"))
    }
  }
  names(blastseqlist)<-blaseresdf$query_id
  save(blastseqlist,file = paste0(savepath,"/",speciesid1,"_blast_best_",speciesid2,".RData"))
  ##
  return(list(blastedfile.csv=blaseresdf,blastedfile.rdata=blastseqlist))
}

#' BLAST between two species.
#' @export
blasttwo <- function(prealigndf=NULL,speciesid1 = "10090",fastafile1 = "",
                     speciesid2 = "9606",fastafile2 = "",
                     blastedfile.csv="",blastedfile.rdata="",
                     minseqs = 7,evalue = 0.000001,
                     centeraamatach = 1,seqmatachsimilar = 8,blosum50yuzhi = 50){
  library(tidyr)
  library(Biostrings)
  library(data.table)
  library(stringi)
  
  # Step 5: Prepare main data frame (simulate seqduiqievent and datasuiqiall)
  # NOTE: This part requires your own data structure, here we simulate a placeholder data.frame
  if(is.null(prealigndf)){
    stop("Please input the result from the Pre-alignment step. Perhaps you need run prealign function first.")
  }else{
    datasuiqiall <- prealigndf[prealigndf$`Protein ID from Database`!="No Match",]
  }
  
  # Step 2: Prepare subject fasta file (Human or other species)
  blast_best_other<-read.csv(blastedfile.csv,stringsAsFactors = FALSE)
  blast_best_other <- blast_best_other[blast_best_other$evalue <= evalue, 1:3]
  load(file=blastedfile.rdata)
  
  # Step 4: Read fasta sequences
  datafasta_set <- readAAStringSet(fastafile1)
  readfastaqnames <- unlist(lapply(names(datafasta_set), function(x) strsplit(strsplit(x, " ")[[1]][1], "\\|")[[1]][2]))
  if (sum(is.na(readfastaqnames)) > length(readfastaqnames)/2) {
    readfastaqnames <- unlist(lapply(names(datafasta_set), function(x) strsplit(x, "\\ ")[[1]][1]))
  }
  datafastahuman <- readAAStringSet(fastafile2)
  readfastasubjnames <- unlist(lapply(names(datafastahuman), function(x) strsplit(strsplit(x, " ")[[1]][1], "\\|")[[1]][2]))
  
  # Step 6: BLAST alignment and extract features
  Center.amino.acids.Other <- Seqwindows.Other <- PRO.from.Other <- PROindex.from.Other <- vector()
  danlength <- minseqs
  print("###Starting BLAST alignment...###")
  for (i in 1:nrow(datasuiqiall)) {
    centeraas <- strsplit(datasuiqiall$`Center amino acid`[i], ";")[[1]]
    promainindex<-as.numeric(strsplit(datasuiqiall$`Modified Amino Acid Site in Protein Sequence`[i],";")[[1]])
    grepproindex <- grep(datasuiqiall$`Protein ID from Database`[i], blast_best_other$query_id)
    if (length(grepproindex) > 0) {
      queryindex1<-blast_best_other$query_id[grepproindex][1]
      queryindex2<-blast_best_other$subject_id[grepproindex][1]
      subjectpro<-as.data.frame(datafastahuman[readfastasubjnames==queryindex2])$x
      seqnchar <- nchar(subjectpro)
      if(length(seqnchar)>0){
        alignquerydf<-blastseqlist[[queryindex1]]
        alignquerydf1 <- strsplit(alignquerydf[1], "")[[1]]
        alignquerydf2 <- strsplit(alignquerydf[2], "")[[1]]
        alignquerydfhengxian1 <- grep("-", alignquerydf1)
        alignquerydfhengxian2 <- grep("-", alignquerydf2)
        if (length(alignquerydfhengxian1) > 0) {
          centeraas1 <- grep(centeraas, alignquerydf1)
          centeraas2 <- centeraas1[centeraas1 >= promainindex]
          caai <- 1
          repeat {
            x1 <- sum(alignquerydfhengxian1 <= centeraas2[caai])
            blaseproindex1 <- centeraas2[caai]
            if ((centeraas2[caai] - x1) == promainindex) break
            caai <- caai + 1
          }
          if (length(alignquerydfhengxian2) > 0) {
            blaseproindex <- blaseproindex1 - sum(alignquerydfhengxian2 <= blaseproindex1)
          } else {
            blaseproindex <- blaseproindex1
          }
          blaseproindex2 <- blaseproindex1
        } else {
          if (length(alignquerydfhengxian2) > 0) {
            blaseproindex <- promainindex - sum(alignquerydfhengxian2 <= promainindex)
          } else {
            blaseproindex <- promainindex
          }
          blaseproindex2 <- promainindex
        }
        blastpepwindows <- unlist(lapply(blaseproindex2, function(x) {
          indexjian1 <- x - danlength
          indexjian2 <- x + danlength
          if (indexjian1 <= 0) {
            xhx1 <- paste(rep("_", abs(indexjian1) + 1), collapse = "")
            xhx2 <- stri_sub(alignquerydf[2], from = 0, to = indexjian2)
            xhx3 <- paste0(xhx1, xhx2)
          } else if (indexjian2 > nchar(alignquerydf[2])) {
            xhx1 <- paste(rep("_", (indexjian2 - nchar(alignquerydf[2]))), collapse = "")
            xhx2 <- stri_sub(alignquerydf[2], from = indexjian1, to = nchar(alignquerydf[2]))
            xhx3 <- paste0(xhx2, xhx1)
          } else {
            xhx3 <- stri_sub(alignquerydf[2], from = indexjian1, to = indexjian2)
          }
        }))
        blaseprocenter <- alignquerydf2[blaseproindex2]
        if (blaseprocenter != "-") {
          blaseproindex <- blaseproindex
        } else {
          blaseproindex <- 0
        }
        Center.amino.acids.Other[i] <- blaseprocenter
        Seqwindows.Other[i] <- paste(blastpepwindows, collapse = ";")
        PRO.from.Other[i] <- queryindex2
        PROindex.from.Other[i] <- paste(blaseproindex, collapse = ";")
      }else{
        Center.amino.acids.Other[i]<-NA
        Seqwindows.Other[i]<-NA
        PRO.from.Other[i]<-NA
        PROindex.from.Other[i]<-NA
      }
    }else {
      Center.amino.acids.Other[i] <- NA
      Seqwindows.Other[i] <- NA
      PRO.from.Other[i] <- NA
      PROindex.from.Other[i] <- NA
    }
    if(i %% 100 == 0){
      print(paste("Processed", i, "records"))
    }
  }
  datasuiqiall$Center.amino.acids.Other <- Center.amino.acids.Other
  datasuiqiall$Seqwindows.Other <- Seqwindows.Other
  datasuiqiall$PRO.from.Other <- PRO.from.Other
  datasuiqiall$PROindex.from.Other <- PROindex.from.Other
  #datasuiqiall$PRO.CombinedID <- paste0(datasuiqiall$PRO.from.Database, "_", datasuiqiall$Center.amino.acid, datasuiqiall$PROindex.from.Database)
  datasuiqiall$PRO.CombinedID.Other <- paste0(datasuiqiall$PRO.from.Other, "_", datasuiqiall$Center.amino.acids.Other, datasuiqiall$PROindex.from.Other)
  # Step 7: Calculate Center.aa.match, Window.similarity, BLOSUM50.Score
  Center.aa.match <- apply(datasuiqiall[, c("Center amino acid", "Center.amino.acids.Other")], 1, function(x) {
    if (x[1] == x[2]) {
      "Exact"
    } else {
      if (sum(x %in% c("S", "T", "Y")) == 2) {
        "Fuzzy"
      } else {
        "Not match"
      }
    }
  })
  Window.similarity <- apply(datasuiqiall[, c("Aligned Standard Peptides", "Seqwindows.Other")], 1, function(x) {
    x1 <- strsplit(x[1], "")[[1]]
    x2 <- strsplit(x[2], "")[[1]]
    sum(x1 == x2)
  })
  if (sum(Center.aa.match == "Not match") > 0) {
    Window.similarity[which(Center.aa.match == "Not match")] <- 0
  }
  datasuiqiall$Center.aa.match <- Center.aa.match
  datasuiqiall$Window.similarity <- Window.similarity
  datasuiqiall$BLOSUM50.Score <- apply(datasuiqiall[, c("Aligned Standard Peptides", "Seqwindows.Other")], 1, function(x) {
    seqs <- as.character(x)
    seq1 <- seqs[1]
    seq2 <- seqs[2]
    xx1 <- unique(c(grep("_", seq1), grep("_", seq2), grep("\\-", seq1), grep("\\-", seq2), grep("U", seq1), grep("U", seq2)))
    if (length(xx1) > 0) {
      seq1x <- strsplit(seq1, "")[[1]]
      seq2x <- strsplit(seq2, "")[[1]]
      xx1x <- unique(c(grep("_", seq1x), grep("_", seq2x), grep("\\-", seq1x), grep("\\-", seq2x), grep("U", seq1x), grep("U", seq2x)))
      xxx1 <- paste0(seq1x[-xx1x], collapse = "")
      xxx2 <- paste0(seq2x[-xx1x], collapse = "")
      if (xxx1 == "") {
        xx2 <- 0
      } else {
        xx2 <- pairwiseAlignment(xxx1, xxx2, substitutionMatrix = "BLOSUM50", gapOpening = 10, gapExtension = 0.2)
        xx2 <- xx2@score
      }
    } else {
      xx2 <- pairwiseAlignment(seq1, seq2, substitutionMatrix = "BLOSUM50", gapOpening = 10, gapExtension = 0.2)
      xx2 <- xx2@score
    }
    xx2
  })
  
  # Step 8: Filtering
  if (centeraamatach == 1) {
    datasuiqiall1 <- datasuiqiall[grep("Exact|Fuzzy", datasuiqiall$Center.aa.match), ]
  }else if (centeraamatach == 2) {
    datasuiqiall1 <- datasuiqiall
  }else{
    datasuiqiall1 <- datasuiqiall[datasuiqiall$Center.aa.match == "Exact", ]
  }
  datasuiqiall1 <- datasuiqiall1[datasuiqiall1$Window.similarity >= seqmatachsimilar, ]
  datasuiqiall1 <- datasuiqiall1[datasuiqiall1$BLOSUM50.Score >= blosum50yuzhi, ]
  datasuiqiall1<-datasuiqiall1[,c(1,7,8,9,3,6,2,4,5,10:17)]
  # Step 9: Set column names as in Shiny output
  if (ncol(datasuiqiall1) == 17) {
    colnames(datasuiqiall1) <- c(
      "Uploaded Peptides", "Peptide Skeleton",
      "Main Modification Site in Uploaded Peptides",
      "All Modification Site in Uploaded Peptides",
      "Center amino acid", "Aligned Standard Peptides",
      "Protein ID from Database",
      "Modified Amino Acid Position in Protein Sequence",
      "Combined Protein Identifier",
      "Blasted Center amino acid", "Blasted Standard Peptides",
      "Blasted Protein ID",
      "Blasted Modified Amino Acid Position in Protein Sequence",
      "Blasted Combined Protein Identifier",
      "Standard Peptides Matching Degree",
      "Window Similarity", "BLOSUM50 Score"
    )
  } else {
    colnames(datasuiqiall1) <- c(
      "Uploaded Peptides", "Peptide Skeleton",
      "Main Modification Site in Uploaded Peptides",
      "All Modification Site in Uploaded Peptides",
      "Center amino acid", "Aligned Standard Peptides",
      "Protein ID from Database",
      "Modified Amino Acid Position in Protein Sequence",
      "Combined Protein Identifier",
      "Regular Sequence Inclusion Check",
      "Blasted Center amino acid", "Blasted Standard Peptides",
      "Blasted Protein ID",
      "Blasted Modified Amino Acid Position in Protein Sequence",
      "Blasted Combined Protein Identifier",
      "Standard Peptides Matching Degree",
      "Window Similarity", "BLOSUM50 Score"
    )
  }
  
  return(datasuiqiall1[,-4])
}


