# Processamento de Interatome - Seleção de base de dados e evidências experimentais a fim de calcular escore combinado para evidências

# Dados do Interatoma <- STRING 11.0 - Baixar dados do versão mais atualizada do arquivo de interatoma do STRING contendo subescores por canal e abrir em R
'295358.protein.links.detailed.v11.5'<-read.delim("/home/bryan/Documentos/GitHub/Systems_biology_analysis/295358.protein.links.detailed.v11.5.txt", sep="", stringsAsFactors=FALSE)
string_database_experimental <- subset(`295358.protein.links.detailed.v11.5`, select=c(1,2,7,8))

# Normalização de banco de dados e dados experimentais 
string_database_experimental$database<-string_database_experimental$database/1000
string_database_experimental$experimental <- string_database_experimental$experimental/1000
string_database_experimental$s_db_nop = (string_database_experimental$database - 0.041)/(1-0.041) # Não entendi a origem do valor 0.041
string_database_experimental$s_exp_nop = (string_database_experimental$experimental - 0.041)/(1-0.041) # Não entendi a origem do valor 0.041
string_database_experimental$s_db_nop <- ifelse(string_database_experimental$s_db_nop < 0, 0, string_database_experimental$s_db_nop)
string_database_experimental$s_exp_nop <- ifelse(string_database_experimental$s_exp_nop < 0, 0, string_database_experimental$s_exp_nop)

# Cálculo do escore combinado de valores de banco de dados e dados experimentais
string_database_experimental$s_tot_nop = 1-(1-string_database_experimental$s_exp_nop)*(1-string_database_experimental$s_db_nop)
string_database_experimental$combined_score = string_database_experimental$s_tot_nop + 0.041*(1-string_database_experimental$s_tot_nop)
string_database_experimental$combined_score <- ifelse(string_database_experimental$combined_score == 0.041, 0, string_database_experimental$combined_score)
string_database_experimental$combined_score <- signif(string_database_experimental$combined_score,digits=3)

# Filtragem de dados através do valor de escore combinado
string_database_experimental_filtered <- string_database_experimental %>% filter(combined_score>=0.4) # '%>%' (pipe - canalização) é definido por CRAN
string_database_experimental_filtered$protein1 <- gsub("295358.", "\\1", string_database_experimental_filtered$protein1) # Remove '4932.' do nome dos genes
string_database_experimental_filtered$protein2 <- gsub("295358.", "\\1", string_database_experimental_filtered$protein2) # Remove '4932.' do nome dos genes

# Adicionar nome do gene para cada ORF
library(dplyr) # Biblioteca para manipulação de dados
# <Nomenclatura arrumar>

# Gerar dataframe de 'graph_string_db_exp' para abrir no Cytoscape
graph_string_db_exp <- string_database_experimental_filtered [,8:10]
graph_string_db_exp <- graph_string_db_exp_filtered [c(2,3,1)]
write.table(cbind(rownames(graph_string_db_exp),graph_string_db_exp), file = 'graph_string_db_exp.txt', sep='\t', row.names=F, quote=F) # No ambiente do Cytoscape importar a rede 'graph_string_db_exp.txt'

### rcy3 para abrir rede (como no cytoscape)

