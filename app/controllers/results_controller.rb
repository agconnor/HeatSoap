class ResultsController < ApplicationController
	def index
    respond_to do |format|
      format.html
    end
  end

  def vis
    @instance_var = "this is a class param";
    @@static_var = "this is a static param";
    #@days = Result.find_by_sql(["select distinct timestep from results where experiment_id=1"]);
		@table = Result.find_by_sql(["select r.*, h1." + params[:plot] +" los1, h2." + params[:plot] + " los2 from (SELECT source_id, target_id, " + params[:agg] + "(population) as mrsa FROM `results` WHERE (timestep >= ? and timestep <= ?) GROUP BY source_id, target_id) as r "+
      " inner join hospitals h1 on r.source_id=h1.id inner join hospitals h2 on r.target_id=h2.id", params[:start], params[:end]])
    respond_to do |format|
      format.json
		end
	end
end
