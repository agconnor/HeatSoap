class ResultsController < ApplicationController
	def index
		@table = Result.find_by_sql(["select r.*, h1.mean_los_pos los1, h2.mean_los_pos los2 from (SELECT source_id, target_id, sum(population) as mrsa FROM `results` WHERE (timestep >= ? and timestep <= ?) GROUP BY source_id, target_id) as r "+
      " inner join hospitals h1 on r.source_id=h1.id inner join hospitals h2 on r.target_id=h2.id", params[:start], params[:end]])
    respond_to do |format|
			format.html
      format.json
		end
	end
end
