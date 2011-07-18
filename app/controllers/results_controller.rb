class ResultsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_goal
  
  # GET /results
  # GET /results.xml
  def index
    @results = @goal.results.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @results }
    end
  end

  # GET /results/1
  # GET /results/1.xml
  def show
    @result = @goal.results.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @result }
    end
  end

  # GET /results/new
  # GET /results/new.xml
  def new
    @result = @goal.results.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @result }
    end
  end

  # GET /results/1/edit
  def edit
    @result = @goal.results.find(params[:id])
  end

  # POST /results
  # POST /results.xml
  def create
    @result = @goal.results.build(params[:result])

    respond_to do |format|
      if @result.save
        format.html { redirect_to(@goal, :notice => 'Result was successfully created.') }
        format.xml  { render :xml => @result, :status => :created, :location => @result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /results/1
  # PUT /results/1.xml
  def update
    @result = @goal.results.find(params[:id])

    respond_to do |format|
      if @result.update_attributes(params[:result])
        format.html { redirect_to(@goal, :notice => 'Result was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.xml
  def destroy
    @result = @goal.results.find(params[:id])
    @result.destroy

    respond_to do |format|
      format.html { redirect_to(goal_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
    def find_goal
      @goal = current_user.goals.find(params[:goal_id])
    end
end
