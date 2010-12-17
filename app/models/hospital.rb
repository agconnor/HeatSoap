class Hospital < ActiveRecord::Base
  def aggregate_by_source_id()
    Result.find_by_sql(['select target_id, avg(mrsa) mean, count(*) count, max(mrsa) max, min(mrsa) min, std(mrsa) std from results where source_id = ? group by target_id', self.id])
  end
  
  def aggregate_by_target_id()
    Result.find_by_sql(['select source_id, avg(mrsa) mean, count(*) count, max(mrsa) max, min(mrsa) min, std(mrsa) std from results where target_id = ? group by source_id', self.id])
  end
  
  def Hospital.get_row_mapping
    by_los = self.order("mean_los_pos asc")
    by_capacity = self.order("capacity asc")
    row_mapping = Hash.new
    row_mapping[:mean_los_pos] = Array.new
    row_mapping[:capacity] = Array.new
    row_mapping[:id] = Array.new
    i = 1
    by_los.each do |row|
      row_mapping[:mean_los_pos][i] = row.id
      i += 1
    end
    
    i = 1
    by_capacity.each do |row|
      row_mapping[:capacity][i] = row.id
      i += 1
    end
    
    return row_mapping
  end
end
