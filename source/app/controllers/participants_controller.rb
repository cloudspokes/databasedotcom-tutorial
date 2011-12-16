class ParticipantsController < ApplicationController
  include Databasedotcom::Rails::Controller
  #http_basic_authenticate_with :name => "ray", :password => "xxx", :except => :index

  before_filter :init

  def init
    dbdc_client.materialize('Participant__c')
    dbdc_client.materialize('ParticipantProfile__c')
    dbdc_client.materialize('Fitness_Goal__c')

    dbdc_client.debugging = true
    @dbdc_client = dbdc_client    
  end

  # GET /participants
  # GET /participants.json
  def list
    @participants = Participant__c.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participants }
    end
  end

  def index
    redirect_to welcome_participants_path
  end

  # welcome page
  def welcome
    @participant = Participant__c.new
    @operation = 'POST'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participants }
    end
  end

  def find
    if !params[:participant__c]['Email__c'].empty?
      @participant = Participant__c.query(
        "Email__c ='#{params[:participant__c]['Email__c']}' limit 1"
        )
    end

    if @participant.empty?
      redirect_to params.merge!(:action => "new")
      return
    else
      redirect_to participant_path(@participant.first['Id'])
      return
    end
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    @participant = Participant__c.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /participants/new
  # GET /participants/new.json
  def new
    @participant = Participant__c.new
    @operation = 'create'

    unless params[:participant__c][:Email__c].empty?
      @participant["Email__c"] = params[:participant__c][:Email__c]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /participants/1/edit
  def edit
    @participant = Participant__c.find(params[:id])
    @operation = 'update'
    #@participant = Participant.find(params[:id])
  end

  # POST /participants
  # POST /participants.json
  def create
    participant = Participant__c.coerce_params(params[:participant__c])
    respond_to do |format|
      if (@participant = Participant__c.create participant)
        @participant.reload
        format.html { redirect_to participant_path(@participant), notice: 'Participant was successfully created.' }
        format.json { render json:participant_path(@participant), status: :created, location: @participant }
      else
        format.html { render action: "new" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /participants/1
  # PUT /participants/1.json
  def update
    @participant = Participant__c.find(params[:id])

    params[:participant__c].keys.each do |key|
      @participant[key] = params[:participant__c][key]
      puts "---" + params[:participant__c][key]
    end
    # TODO GEM defect, does not allow update to records with unique entries.
    #result = @participant.save
    result = @participant.update_attributes(params[:participant__c])
    puts result
    respond_to do |format|
      if result
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant = Participant__c.find(params[:id])
    @participant.delete

    respond_to do |format|
      format.html { redirect_to participants_url }
      format.json { head :ok }
    end
  end
end