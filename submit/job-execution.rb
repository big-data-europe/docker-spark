require 'sparql/client'
require 'rdf/vocab'

class JobExecution

  def initialize(sparql_endpoint)
    @client = SPARQL::Client.new sparql_endpoint
  end

  def start
    while true
      arguments = wait_for_job
      execute_job(arguments)
    end
  end
  
  def wait_for_job
    # poll for a job
    result = []
    while result.empty?
      puts "Checking store for a job"
      query = File.read('/config/job-description.sparql')
      result = @client.query query
      sleep 5
    end

    # parse result and create arguments for Spark app
    pattern = File.read('/config/job-arguments.pattern')
    resource = result.first
    eval(pattern)
  end

  def execute_job(arguments)
    puts "Executing job with arguments: #{arguments}"
    ENV['SPARK_APPLICATION_ARGS'] = arguments
    `/bin/bash /spark-submit.sh`
  end
  
end

jobExecution = JobExecution.new ENV['SPARQL_ENDPOINT']
jobExecution.start



