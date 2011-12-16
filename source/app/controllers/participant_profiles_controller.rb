class ParticipantProfilesController < ApplicationController
  include Databasedotcom::Rails::Controller
  #http_basic_authenticate_with :name => "ray", :password => "xxx", :except => :index

  before_filter :init

  def init
    dbdc_client.materialize('Participant__c')
    dbdc_client.materialize('ParticipantProfile__c')
    dbdc_client.materialize('Fitness_Goal__c')

    @dbdc_client = dbdc_client
  end
  
  # GET /participant_profiles
  # GET /participant_profiles.json
  def index
    @participant = Participant__c.find(request[:participant_id])
    @participant_profiles = ParticipantProfile__c.query("Participant__r.Id=" + "'#{request[:participant_id]}'")
    #render :text => 'result is here.'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participant_profiles }
    end

  end

  # GET /participant_profiles/1
  # GET /participant_profiles/1.json
  def show
    @participant = Participant__c.find(request[:participant_id])
    @participant_profile = ParticipantProfile__c.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participant_profile }
    end
  end

  # GET /participant_profiles/new
  # GET /participant_profiles/new.json
  def new
    @participant = Participant__c.find(request[:participant_id])
    @participant_profile = ParticipantProfile__c.new
    @operation = 'create'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant_profile }
    end
  end

  # GET /participant_profiles/1/edit
  def edit
    @participant = Participant__c.find(request[:participant_id])
    @participant_profile = ParticipantProfile__c.find(params[:id])
    @operation = 'update'
  end

  # POST /participant_profiles
  # POST /participant_profiles.json
  def create
    @participant = Participant__c.find(request[:participant_id])
    params[:participant_profile__c]['Participant__c'] = @participant['Id']
    participant_profile = ParticipantProfile__c.coerce_params(params[:participant_profile__c])

    respond_to do |format|
      if (@participant_profile = ParticipantProfile__c.create participant_profile) 
        format.html { redirect_to participant_participant_profile_path(@participant, @participant_profile),
          notice: 'Participant profile was successfully created.' }
        format.json { render json: @participant_profile, status: :created, location: @participant_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @participant.participant_profiles.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /participant_profiles/1
  # PUT /participant_profiles/1.json
  def update
    @participant = Participant__c.find(request[:participant_id])
    @participant_profile = ParticipantProfile__c.find(params[:id])

    params[:participant_profile__c].keys.each do |key|
      @participant_profile[key] = params[:participant_profile__c][key]
      puts "---" + params[:participant_profile__c][key]
    end

    result = @participant_profile.save
    puts result
    respond_to do |format|
      if result
        format.html { redirect_to [@participant, @participant_profile],
          notice: 'Participant profile was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @participant.participant_profile.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participant_profiles/1
  # DELETE /participant_profiles/1.json
  def destroy
    @participant = Participant__c.find(request[:participant_id])
    @participant_profile = ParticipantProfile__c.find(params[:id])
    @participant_profile.delete

    respond_to do |format|
      format.html { redirect_to participant_participant_profiles_url }
      format.json { head :ok }
    end
  end
end
