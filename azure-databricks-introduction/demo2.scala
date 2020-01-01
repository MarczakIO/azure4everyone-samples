// Databricks notebook source
val containerName = "<container_name>"
val storageAccountName = "<storage_account_name>"
val sas = "<sas_token>"

val url = "wasbs://" + containerName + "@" + storageAccountName + ".blob.core.windows.net/"
var config = "fs.azure.sas." + containerName + "." + storageAccountName + ".blob.core.windows.net"

// COMMAND ----------

dbutils.fs.mount(
  source = url,
  mountPoint = "/mnt/staging",
  extraConfigs = Map(config -> sas))


// COMMAND ----------

val df = spark.read.json("/mnt/staging/small_radio_json.json")
display(df)

// COMMAND ----------

val specificColumnsDf = df.select("firstname", "lastname", "gender", "location", "level")
display(specificColumnsDf)

// COMMAND ----------

val renamedColumnsDF = specificColumnsDf.withColumnRenamed("level", "subscription_type")
display(renamedColumnsDF)

// COMMAND ----------

renamedColumnsDF.createOrReplaceTempView("renamed")

// COMMAND ----------

// MAGIC %sql
// MAGIC SELECT 
// MAGIC    count(*) as count,
// MAGIC    subscription_type
// MAGIC FROM renamed
// MAGIC GROUP BY 
// MAGIC    subscription_type

// COMMAND ----------

val aggregate = spark.sql("""
SELECT 
   count(*) as count,
   subscription_type
FROM renamed
GROUP BY 
   subscription_type
""")

// COMMAND ----------

aggregate.write.mode("overwrite").csv("/mnt/staging/output/aggregate.csv")
