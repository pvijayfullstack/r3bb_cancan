class WorkoutsController < ApplicationController
  load_and_authorize_resource
  
  # GET /workouts
  # GET /workouts.xml
  def index
    @workouts = current_user.workouts.find(:all, :order => 'date desc', :limit => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @workouts }
    end
  end

  # GET /workouts/1
  # GET /workouts/1.xml
  def show
    @workout = current_user.workouts.find(params[:id])
    @activities = @workout.activities.find(:all, :include => :exercise)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @workout }
    end
  end

  # GET /workouts/new
  # GET /workouts/new.xml
  def new
    @workout = current_user.workouts.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workout }
    end
  end

  # GET /workouts/1/edit
  def edit
    @workout = current_user.workouts.find(params[:id])
  end

  # POST /workouts
  # POST /workouts.xml
  def create
    @workout = current_user.workouts.build(params[:workout])

    respond_to do |format|
      if @workout.save
        format.html { redirect_to(@workout, :notice => 'Workout was successfully created.') }
        format.xml  { render :xml => @workout, :status => :created, :location => @workout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @workout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /workouts/1
  # PUT /workouts/1.xml
  def update
    @workout = current_user.workouts.find(params[:id])

    respond_to do |format|
      if @workout.update_attributes(params[:workout])
        format.html { redirect_to(@workout, :notice => 'Workout was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @workout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.xml
  def destroy
    @workout = current_user.workouts.find(params[:id])
    @workout.destroy

    respond_to do |format|
      format.html { redirect_to(workouts_url) }
      format.xml  { head :ok }
    end
  end
end
