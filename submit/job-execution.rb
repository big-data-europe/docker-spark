require 'sparql/client'
require 'rdf/vocab'

class JobExecution

  def initialize(sparql_endpoint)
    @client = SPARQL::Client.new sparql_endpoint
  end

  def start
    while true
      job = wait_for_job
      execute_job(job)
    end
  end
  
  def wait_for_job
    result = []
    while result.empty?
      puts "Checking store for a job"
      query = File.read('/config/job-description.sparql')
      result = @client.query query
      sleep 5
    end
    result.first
  end

  def execute_job(job)
    # create arguments string for Spark app
    pattern = File.read('/config/job-arguments.pattern')
    arguments = eval(pattern)

    # execute Spark submit
    puts "Executing job #{job['job']} with arguments: #{arguments}"
    ENV['SPARK_APPLICATION_ARGS'] = arguments
    `/bin/bash /spark-submit.sh`
    puts "Finished job. Updating status."
    update_status_query(job['job'])
  end

  def update_status_query(job_uri, status_uri = "http://www.big-data-europe.eu/vocabularies/job/Done")
    query =  "PREFIX cogs: <http://vocab.deri.ie/cogs#> "
    query += "PREFIX job: <http://www.big-data-europe.eu/vocabularies/job/> "
    query += "WITH <#{ENV['SPARQL_GRAPH']}>"
    query += "DELETE { "
    query += "  <#{job_uri}> job:status ?status "
    query += "} WHERE { "
    query += "  <#{job_uri}> a cogs:Job ; "
    query += "    job:status ?status . "
    query += "} "
    query += " "
    query += "INSERT DATA { "
    query += "  <#{job_uri}> job:status <#{status_uri}> "    
    query += "} "
    @client.update query
  end
  
end

jobExecution = JobExecution.new ENV['SPARQL_ENDPOINT']
jobExecution.start



