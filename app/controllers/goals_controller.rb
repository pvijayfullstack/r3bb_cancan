class GoalsController < ApplicationController
  load_and_authorize_resource
  
  # GET /goals
  # GET /goals.xml
  def index
    @goals = current_user.goals.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @goals }
    end
  end

  # GET /goals/1
  # GET /goals/1.xml
  def show
    @goal = current_user.goals.find(params[:id]) 
    @results = @goal.results.find(:all, :order => 'date desc')

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
          f.title({ :text=>"Combination chart"})
          f.options[:x_axis][:categories] = ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
          f.labels(:items=>[:html=>"Total fruit consumption", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
          f.series(:type=> 'column',:name=> 'Jane',:data=> [3, 2, 1, 3, 4])
          f.series(:type=> 'column',:name=> 'John',:data=> [2, 3, 5, 7, 6])
          f.series(:type=> 'column', :name=> 'Joe',:data=> [4, 3, 3, 9, 0])
          f.series(:type=> 'column', :name=> 'Joe',:data=> [4, 3, 3, 9, 0])
          f.series(:type=> 'spline',:name=> 'Average', :data=> [3, 2.67, 3, 6.33, 3.33])
          f.series(:type=> 'pie',:name=> 'Total consumption', 
            :data=> [
              {:name=> 'Jane', :y=> 13, :color=> 'red'}, 
              {:name=> 'John', :y=> 23,:color=> 'green'},
              {:name=> 'Joe', :y=> 19,:color=> 'blue'}
            ],
            :center=> [100, 80], :size=> 100, :showInLegend=> false)
        end
        
@h = LazyHighCharts::HighChart.new('graph') do |f|
  f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
  f.x_axis(:categories => ["United States", "Japan", "China", "Germany", "France"])
  f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
  f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

  yAxes = Array.new
  yAxes << {:title => {:text => "GDP in Billions", :margin => 70} ,}
  yAxes << {:title => {:text => "Population in Millions"}, :opposite => true}
  f.options[:y_axis] = yAxes

  f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
  f.chart({:defaultSeriesType=>"column"})
end

@chart_pie = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
      series = {
               :type=> 'pie',
               :name=> 'Browser share',
               :data=> [
                  ['Firefox',   45.0],
                  ['IE',       26.8],
                  {
                     :name=> 'Chrome',    
                     :y=> 12.8,
                     :sliced=> true,
                     :selected=> true
                  },
                  ['Safari',    8.5],
                  ['Opera',     6.2],
                  ['Others',   0.7]
               ]
      }
      f.series(series)
      f.options[:title][:text] = "THA PIE"
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
      f.plot_options(:pie=>{
        :allowPointSelect=>true, 
        :cursor=>"pointer" , 
        :dataLabels=>{
          :enabled=>true,
          :color=>"white",
          :style=>{
            :font=>"13px Trebuchet MS, Verdana, sans-serif"
          }
        }
      })  
end

@bar = LazyHighCharts::HighChart.new('column') do |f|
      f.series(:name=>'John',:data=> [3, 20, 3, 5, 4, 10, 12 ])
      f.series(:name=>'Jane',:data=>[1, 3, 4, 3, 3, 5, 4,-46] )   
      f.title({ :text=>"example test title from controller"})

      ###  Options for Bar
      ### f.options[:chart][:defaultSeriesType] = "bar"
      ### f.plot_options({:series=>{:stacking=>"normal"}}) 

      ## or options for column
      f.options[:chart][:defaultSeriesType] = "column"
      f.plot_options({:column=>{:stacking=>"percent"}})
    end
        
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @goal }
    end
  end

  # GET /goals/new
  # GET /goals/new.xml
  def new
    @goal = current_user.goals.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @goal }
    end
  end

  # GET /goals/1/edit
  def edit
    @goal = current_user.goals.find(params[:id])
  end

  # POST /goals
  # POST /goals.xml
  def create
    @goal = current_user.goals.build(params[:goal])

    respond_to do |format|
      if @goal.save
        format.html { redirect_to(@goal, :notice => 'Goal was successfully created.') }
        format.xml  { render :xml => @goal, :status => :created, :location => @goal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /goals/1
  # PUT /goals/1.xml
  def update
    @goal = current_user.goals.find(params[:id])

    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.html { redirect_to(@goal, :notice => 'Goal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.xml
  def destroy
    @goal = current_user.goals.find(params[:id])
    @goal.destroy

    respond_to do |format|
      format.html { redirect_to(goals_url) }
      format.xml  { head :ok }
    end
  end
  
end
