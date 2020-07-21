// scala 2.12
// com.crealytics:spark-excel_2.12:0.13.1

// scala 2.11
// com.crealytics:spark-excel_2.11:0.13.1

// Databricks notebook source
val containerName = ""
val storageAccountName = ""
val key = ""

val url = "wasbs://" + containerName + "@" + storageAccountName + ".blob.core.windows.net/"
var config = "fs.azure.account.key." + storageAccountName + ".blob.core.windows.net"

dbutils.fs.mount(
  source = url,
  mountPoint = "/mnt/myblob",
  extraConfigs = Map(config -> key))

// COMMAND ----------

display(dbutils.fs.ls("/mnt/myblob"))

// COMMAND ----------

val df = spark.read
.format("com.crealytics.spark.excel")
.option("header", true)
.load("/mnt/myblob/data.xls")

display(df)

// COMMAND ----------

import com.crealytics.spark.excel._

val df = spark.read.excel(
  header = true
).load("/mnt/myblob/data.xlsx")

// show XLSX
// show XLS
// show XLSM
// show XLSB
  
display(df)

// COMMAND ----------

val df = spark.read
.format("com.crealytics.spark.excel")
.option("dataAddress", "planes!A1")
.option("header", true)
.load("/mnt/myblob/data.xlsx")

display(df)

// COMMAND ----------

val df = spark.read
.format("com.crealytics.spark.excel")
.option("dataAddress", "Persons[#All]")
.option("header", true)
.load("/mnt/myblob/data.xlsx")

display(df)

// COMMAND ---------- 

df.repartition(1)
  .write
  .format("com.databricks.spark.csv")
  .mode("overwrite")
  .option("header","true")
  .save("/mnt/myblob/persons.csv")
  
// COMMAND ----------

val sheetNames = WorkbookReader(
  Map("path" -> "/mnt/myblob/data.xlsx"), 
  spark.sparkContext.hadoopConfiguration
).sheetNames

// COMMAND ----------

sheetNames.foreach { item =>

  var data = spark.read
    .format("com.crealytics.spark.excel")
    .option("dataAddress", (item + "!A1"))
    .option("header", true)
    .load("/mnt/myblob/data.xlsx")

  data.repartition(1)
    .write
    .format("com.databricks.spark.csv")
    .mode("overwrite")
    .option("header","true")
    .save("/mnt/myblob/databricks-output/" + item + ".csv")
  
}

// COMMAND ----------

import org.apache.spark.sql._
import org.apache.spark.sql.types._

val moviesSchema = StructType(Array(
    StructField("MovieId", DoubleType, nullable = false),
    StructField("Title", StringType, nullable = false),
    StructField("Genres", StringType, nullable = false)
))

val df = spark.read
  .format("com.crealytics.spark.excel")
  .option("dataAddress", "movies!A1")
  .option("header", true)
  .schema(moviesSchema)
  .load("/mnt/myblob/data.xlsx")

display(df)

// COMMAND ----------

val df = spark.read
.format("com.crealytics.spark.excel")
.option("dataAddress", "planes!A1")
.option("header", true)
.load("/mnt/myblob/data.xlsx")

display(df)

// COMMAND ----------

import org.apache.spark.sql.functions._

val aggregated = df
  .groupBy("MAKER")
  .count()

display(aggregated)

// COMMAND ----------

aggregated
  .write
  .format("com.crealytics.spark.excel")
  .option("header", true)
  .option("dataAddress", "Aggregated!A1")
  .mode("overwrite")
  .save("/mnt/myblob/output.xlsx")

// COMMAND ----------

aggregated
  .write
  .format("com.crealytics.spark.excel")
  .option("header", true)
  .option("dataAddress", "Aggregated!A1")
  .mode("overwrite")
  .save("/mnt/myblob/output.xlsx")

df
  .write
  .format("com.crealytics.spark.excel")
  .option("header", true)  
  .option("dataAddress", "Original!A1")
  .mode("append")
  .save("/mnt/myblob/output.xlsx")

// COMMAND ----------


val spark: SparkSession = ???
val df = spark.read.excel(
    header = true,  // Required
    dataAddress = "'My Sheet'!B3:C35", // Optional, default: "A1"
    treatEmptyValuesAsNulls = false,  // Optional, default: true
    inferSchema = false,  // Optional, default: false
    addColorColumns = true,  // Optional, default: false
    timestampFormat = "MM-dd-yyyy HH:mm:ss",  // Optional, default: yyyy-mm-dd hh:mm:ss[.fffffffff]
    maxRowsInMemory = 20,  // Optional, default None. If set, uses a streaming reader which can help with big files
    excerptSize = 10,  // Optional, default: 10. If set and if schema inferred, number of rows to infer schema from
    workbookPassword = "pass"  // Optional, default None. Requires unlimited strength JCE for older JVMs
).schema(myCustomSchema) // Optional, default: Either inferred schema, or all columns are Strings
 .load("Worktime.xlsx")
