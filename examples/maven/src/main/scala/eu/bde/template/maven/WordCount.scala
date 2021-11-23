package eu.bde.template.maven

import org.apache.spark.sql.SparkSession

object WordCount {

  /** Usage: WordCount [file] */
  def main(args: Array[String]): Unit = {
    if (args.length < 1) {
      System.err.println("Usage: WordCount <file>")
      System.exit(1)
    }
    println("WordCount Example Here")
    val spark = SparkSession
      .builder
      .appName("WordCount")
      .getOrCreate()

    val file = spark.read.textFile(args(0)).rdd

    val counts = file.flatMap(line => line.split(" "))
      .map(word => (word, 1))
      .reduceByKey(_ + _)
    
    val output = counts.collect()

    output.foreach { case (word, count) =>
      println(s"$word: $count")
    }
    spark.stop()
  }
}