class ResultsController < ApplicationController
  caches_page :vis
  caches_page :view, :if => Proc.new { |c| c.request.format.json? }
  
  def index
    @hospitals = Hospital.all
    respond_to do |format|
      format.html
      format.json { render :json => @hospitals.to_json }
    end
  end

  def vis
    @table = Result.find_by_sql([
        "SELECT source_id, target_id, avg(mrsa) as avg, min(mrsa) as min, max(mrsa) as max
           FROM `results`
          WHERE (timestep >= ? and timestep <= ?)
            AND experiment_id = ?
          GROUP BY source_id, target_id", params[:start], params[:end], params[:experiment_id]])
    respond_to do |format|
      format.json { render :json => @table.to_json }
    end
  end
  
  def view
    @results = Result.find_by_sql([
        "SELECT timestep, population, mrsa
           FROM `results`
          WHERE source_id = ?
            AND target_id = ?
            AND experiment_id = ?
          ORDER BY timestep ASC", params[:source_id], params[:target_id], params[:experiment_id]])
    respond_to do |format|
        format.html
        format.json { render :json => @results.to_json }
    end
  end
end
