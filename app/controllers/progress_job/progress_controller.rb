module ProgressJob
  class ProgressController < ActionController::Base

    def show
      @delayed_job = Delayed::Job.find_by(id: params[:job_id])
      if @delayed_job
        hash = {
          progress_max: @delayed_job.progress_max,
          progress_current: @delayed_job.progress_current
        }
        percentage = !@delayed_job.progress_max.zero? ? @delayed_job.progress_current / @delayed_job.progress_max.to_f * 100 : 0
        render json: hash.merge!(percentage: percentage).to_json
      else
        render json: {job_not_found: true}.to_json
      end
    end

  end
end
