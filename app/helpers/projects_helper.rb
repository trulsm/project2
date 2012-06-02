module ProjectsHelper
  
  # Not used yet
  def first_log(project)
  	first = project.logs.first
  	project.logs.each do |log|
  		if log.log_date < first.log_date
  			first = log
  		end
  	end
  end

end