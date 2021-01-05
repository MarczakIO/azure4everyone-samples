val appID = ""
val password = ""
val tenantID = ""
val fileSystemName = "";
var storageAccountName = "";

val configs =  Map("fs.azure.account.auth.type" -> "OAuth",
       "fs.azure.account.oauth.provider.type" -> "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
       "fs.azure.account.oauth2.client.id" -> appID,
       "fs.azure.account.oauth2.client.secret" -> password,
       "fs.azure.account.oauth2.client.endpoint" -> ("https://login.microsoftonline.com/" + tenantID + "/oauth2/token"),
       "fs.azure.createRemoteFileSystemDuringInitialization"-> "true")

dbutils.fs.mount(
source = "abfss://" + fileSystemName + "@" + storageAccountName + ".dfs.core.windows.net/",
mountPoint = "/mnt/data",
extraConfigs = configs)


val df = spark.read.csv("/mnt/data/demo/movies.csv")

display(df)

val df = spark.read.option("header", "true").csv("/mnt/data/demo/movies.csv")


val selected = df.select("movieId", "title")

selected.write.csv("/mnt/data/demo/movies-2.csv")
