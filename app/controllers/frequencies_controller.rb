class FrequenciesController < ApplicationController
  # GET /frequencies
  # GET /frequencies.json
  def index
    @frequencies = Frequency.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @frequencies }
    end
  end

  # GET /frequencies/1
  # GET /frequencies/1.json
  def show
    @frequency = Frequency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @frequency }
    end
  end

  # GET /frequencies/new
  # GET /frequencies/new.json
  def new
    @frequency = Frequency.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @frequency }
    end
  end

  # GET /frequencies/1/edit
  def edit
    @frequency = Frequency.find(params[:id])
  end

  # POST /frequencies
  # POST /frequencies.json
  def create
    @frequency = Frequency.new(params[:frequency])

    respond_to do |format|
      if @frequency.save
        format.html { redirect_to @frequency, notice: 'Frequency was successfully created.' }
        format.json { render json: @frequency, status: :created, location: @frequency }
      else
        format.html { render action: "new" }
        format.json { render json: @frequency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /frequencies/1
  # PUT /frequencies/1.json
  def update
    @frequency = Frequency.find(params[:id])

    respond_to do |format|
      if @frequency.update_attributes(params[:frequency])
        format.html { redirect_to @frequency, notice: 'Frequency was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @frequency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frequencies/1
  # DELETE /frequencies/1.json
  def destroy
    @frequency = Frequency.find(params[:id])
    @frequency.destroy

    respond_to do |format|
      format.html { redirect_to frequencies_url }
      format.json { head :no_content }
    end
  end
end
