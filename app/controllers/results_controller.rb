class ResultsController < ApplicationController
  caches_page :vis
  
  def index
    @experiments = Experiment.all
    respond_to do |format|
      format.html
      format.json {}
    end
  end

  def vis
    @table = Result.find_by_sql([
        "select r.*, h1." + params[:plot] +" los1, h2." + params[:plot] + " los2
           from (SELECT source_id, target_id, " + params[:aggregate] + "(population) as mrsa
                   FROM `results`
                  WHERE (timestep >= ? and timestep <= ?)
                    AND experiment_id = ?
                  GROUP BY source_id, target_id) as r "+
        " inner join hospitals h1 on r.source_id=h1.id
          inner join hospitals h2 on r.target_id=h2.id", params[:start], params[:end], params[:experiment]])
    respond_to do |format|
      format.json { render :json => @table.to_json }
    end
  end
end
