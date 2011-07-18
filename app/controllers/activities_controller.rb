class ActivitiesController < ApplicationController
  load_and_authorize_resource
  before_filter :find_workout
  
  def index
    @activities = @workout.activities.find(:all)

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @activities }
    end
  end

  def show
    @activity = @workout.activities.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @activity }
    end
  end

  def new
    @activity = @workout.activities.build
    
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @activity }
    end
  end

  def edit
    @activity = @workout.activities.find(params[:id])
  end

  def create
    @activity = @workout.activities.build(params[:activity])

    respond_to do |format|
      if @activity.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to workout_url(@workout) }
        format.xml  { render :xml => @activity, :status => :created, :location => activity_url(@workout, @activity) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @activity = @workout.activities.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        flash[:notice] = 'Activity was successfully updated.'
        format.html { redirect_to workout_url(@workout) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end
       
  def destroy
    @activity = @workout.activities.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to(workout_activities_url) }
      format.xml  { head :ok }
    end
  end
  
  protected 
    def find_workout
      @workout = Workout.find(params[:workout_id]) 
    end
end
