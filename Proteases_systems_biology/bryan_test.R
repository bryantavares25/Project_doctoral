#### Aprendendo R ####

'295358.protein.links.detailed.v11.5' <- read.delim("/home/bryan/Documentos/GitHub/Systems_biology_analysis/295358.protein.links.detailed.v11.5.txt", sep="", stringsAsFactors=FALSE)

string_database_experimental <- subset(`295358.protein.links.detailed.v11.5`, select = c(1, 2, 7, 8))

# Normalização dos valores das colunas Experimental e Database
string_database_experimental$experimental<-string_database_experimental$experimental/1000
string_database_experimental$database<-string_database_experimental$database/1000
#
string_database_experimental$s_exp_nop =(string_database_experimental$experimental - 0.041)/(1-0.041)
string_database_experimental$s_db_nop =(string_database_experimental$database - 0.041)/(1-0.041)
#
string_database_experimental$s_exp_nop <-ifelse(string_database_experimental$s_exp_nop < 0, 0, string_database_experimental$s_exp_nop)
string_database_experimental$s_db_nop <-ifelse(string_database_experimental$s_db_nop < 0, 0, string_database_experimental$s_db_nop)
string_database_experimental$s_tot_nop = 1-(1-string_database_experimental$s_exp_nop)*(1-string_database_experimental$s_db_nop)
string_database_experimental$combined_score = string_database_experimental$s_tot_nop + 0.041*(1-string_database_experimental$s_tot_nop)
string_database_experimental$combined_score <- ifelse(string_database_experimental$combined_score == 0.041, 0, string_database_experimental$combined_score)
string_database_experimental$combined_score <- signif(string_database_experimental$combined_score,digits=3)
#Filter data using combined_score
string_database_experimental_b <-string_database_experimental %>% filter(combined_score>=0.4)
#Remove "4932." number from gene names
string_database_experimental_b$protein1<-gsub("4932.", "\\1", string_database_experimental_b$protein1)
string_database_experimental_b$protein2<-gsub("4932.", "\\1",string_database_experimental_b$protein2)

print(labels)
print(resp)
print(x)
