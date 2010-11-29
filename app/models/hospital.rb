class Hospital < ActiveRecord::Base
  def aggregate_by_source_id()
    Result.find_by_sql(['select target_id, avg(mrsa) mean, count(*) count, max(mrsa) max, min(mrsa) min, std(mrsa) std from results where source_id = ? group by target_id', self.id])
  end
  
  def aggregate_by_target_id()
    Result.find_by_sql(['select source_id, avg(mrsa) mean, count(*) count, max(mrsa) max, min(mrsa) min, std(mrsa) std from results where target_id = ? group by source_id', self.id])
  end
end
