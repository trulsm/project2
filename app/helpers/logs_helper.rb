module LogsHelper

	def akkumulert(project)
		if project.logs.any?
			akkumulert = 0
			project.logs.each do |log|
				akkumulert = akkumulert + log.float_entry
			end
			return akkumulert.to_f
		else
			return "No logs recorded"
		end
	end

	def mean_value(project)
		if project.logs.any?
			sum = 0
			project.logs.each do |log|
				sum = sum + log.float_entry
			end
			return (sum/project.logs.count).to_f
		else
			return "No logs recorded"
		end
	end

end
