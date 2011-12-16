class FitnessGoalsController < ApplicationController
  include Databasedotcom::Rails::Controller
  #http_basic_authenticate_with :name => "ray", :password => "xxx", :except => :index

  before_filter :init

  def init
    dbdc_client.materialize('Participant__c')
    dbdc_client.materialize('ParticipantProfile__c')
    dbdc_client.materialize('Fitness_Goal__c')

    @dbdc_client = dbdc_client
  end
  
  # GET /fitness_goals
  # GET /fitness_goals.json
  def index
    @participant = Participant__c.find(request[:participant_id])
    @fitness_goals = Fitness_Goal__c.query("Participant__r.Id=" + "'#{request[:participant_id]}'")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fitness_goals }
    end
  end

  # GET /fitness_goals/1
  # GET /fitness_goals/1.json
  def show
    @participant = Participant__c.find(request[:participant_id])
    @fitness_goal = Fitness_Goal__c.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fitness_goal }
    end
  end

  # GET /fitness_goals/new
  # GET /fitness_goals/new.json
  def new
    @participant = Participant__c.find(request[:participant_id])
    @fitness_goal = Fitness_Goal__c.new
    @operation = 'create'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fitness_goal }
    end
  end

  # GET /fitness_goals/1/edit
  def edit
    @participant = Participant__c.find(request[:participant_id])
    @fitness_goal = Fitness_Goal__c.find(params[:id])
    @operation = 'update'
  end

  # POST /fitness_goals
  # POST /fitness_goals.json
  def create
    @participant = Participant__c.find(request[:participant_id])
    params[:fitness_goal__c]['Participant__c'] = @participant['Id']
    @fitness_goal = Fitness_Goal__c.new(params[:fitness_goal__c])
    fitness_goal = Fitness_Goal__c.coerce_params(params[:fitness_goal__c])

    respond_to do |format|
      if (@fitness_goal = Fitness_Goal__c.create fitness_goal)
        format.html { redirect_to participant_fitness_goal_path(@participant, @fitness_goal), notice: 'Fitness goal was successfully created.' }
        format.json { render json: @fitness_goal, status: :created, location: @fitness_goal }
      else
        format.html { render action: "new" }
        format.json { render json: @participant.fitness_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fitness_goals/1
  # PUT /fitness_goals/1.json
  def update
    @participant = Participant__c.find(request[:participant_id])
    @fitness_goal = Fitness_Goal__c.find(params[:id])

    params[:fitness_goal__c].keys.each do |key|
      @fitness_goal[key] = params[:fitness_goal__c][key]
      puts "---" + params[:fitness_goal__c][key]
    end

    result = @fitness_goal.save
    puts result

    respond_to do |format|
      if result
        format.html { redirect_to [@participant, @fitness_goal], notice: 'Fitness goal was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @participant.fitness_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fitness_goals/1
  # DELETE /fitness_goals/1.json
  def destroy
    @participant = Participant__c.find(request[:participant_id])
    @fitness_goal = Fitness_Goal__c.find(params[:id])
    @fitness_goal.delete

    respond_to do |format|
      format.html { redirect_to participant_fitness_goals_url }
      format.json { head :ok }
    end
  end
end
