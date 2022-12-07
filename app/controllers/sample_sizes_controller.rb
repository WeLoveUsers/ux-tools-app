class SampleSizesController < ApplicationController
  def usability_problems
    @proportion = 31
    if !params[:proportion].nil?
      @proportion = params[:proportion].to_i
    end
  end
end
