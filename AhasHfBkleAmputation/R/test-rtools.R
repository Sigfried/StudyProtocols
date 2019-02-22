#library(tidyverse)
readRenviron('.env')

library(DatabaseConnector)
library(SqlRender)

connectionDetails <- createConnectionDetails( dbms="postgresql", 
                                              server=paste0(Sys.getenv("PGHOST"),'/',
                                                            Sys.getenv('PGDATABASE')),
                                              user = Sys.getenv('PGUSER'),
                                              password = Sys.getenv('PGPASSWORD'),
                                              schema="mimic3_100p")
conn <- connect(connectionDetails)

# getwd()
# [1] "/export/home/goldss/projects/StudyProtocols/AhasHfBkleAmputation"

OhdsiRTools::insertCohortDefinitionSetInPackage(fileName = "settings.csv",
                                                baseUrl = "http://api.ohdsi.org:80/WebAPI",
                                                insertTableSql = TRUE,
                                                insertCohortCreationR = TRUE,
                                                generateStats = FALSE,
                                                packageName="ischemicStrokePhenotype")
# Inserting cohort: Male50plus
# Error in readChar(fileName, file.info(fileName)$size) : 
#   invalid 'nchars' argument
# In addition: Warning message:
#   In file(con, "rb") :
#   file("") only supports open = "w+" and open = "w+b": using the former

#not working
renderedSql <- loadRenderTranslateSql("Male50plus.sql",
                                      #packageName = "CohortMethod", # tried this and below
                                      packageName = "ischemicStrokePhenotype",
                                      dbms = connectionDetails$dbms,
                                      CDM_schema = "mimic3_100p_results")



stmnt = "select top 10 * from person"

#SqlRender::translateSql(stmnt, targetDialect = 'postgresql')


# Error in readChar(pathToSql, file.info(pathToSql)$size) : 
#   invalid 'nchars' argument
# In addition: Warning message:
#   In file(con, "rb") :
#   file("") only supports open = "w+" and open = "w+b": using the former

# same error with many other variations:
# SqlRender::loadRenderTranslateSql('./inst/sql/sql_server/Male50plus.sql', 'ischemicStrokePhenotype', 'postgres')
# SqlRender::loadRenderTranslateSql('./inst/sql/sql_server/Male50plus.sql', packageName = 'ischemicStrokePhenotype')
# SqlRender::loadRenderTranslateSql('Male50plus.sql', 'ischemicStrokePhenotype', 'sql server')
# SqlRender::loadRenderTranslateSql('Male50plus.sql', 'ischemicStrokePhenotype', 'sql_server')
# SqlRender::loadRenderTranslateSql('Male50plus.sql', 'ischemicStrokePhenotype', 'sqlserver')
# SqlRender::loadRenderTranslateSql('Male50plus.sql', 'ischemicStrokePhenotype')
