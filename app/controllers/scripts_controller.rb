class ScriptsController < ApplicationController
  # GET /scripts
  # GET /scripts.json
  def index
    @scripts = Script.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scripts }
    end
  end

  # GET /scripts/1
  # GET /scripts/1.json
  def show
    @script = Script.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @script }
    end
  end

  # GET /scripts/new
  # GET /scripts/new.json
  def new
    @script = Script.new
    get_all_frequencies
    get_all_users
    get_all_categories

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @script }
    end
  end

  # GET /scripts/1/edit
  def edit
    @script = Script.find(params[:id])
    get_all_frequencies
    get_all_users
    get_all_categories
  end

  # POST /scripts
  # POST /scripts.json
  def create
    @script = Script.new(params[:script])
    get_all_frequencies
    get_all_users
    get_all_categories

    respond_to do |format|
      if @script.save
        Script.delay.check_query(@script)
        format.html { redirect_to @script, notice: 'Script was successfully created.' }
        format.json { render json: @script, status: :created, location: @script }
      else
        format.html { render action: "new" }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scripts/1
  # PUT /scripts/1.json
  def update
    params[:frequencies] ||= {}
    params[:users] ||= {}
    @script = Script.find(params[:id])
    get_all_frequencies
    get_all_users
    get_all_categories

    @script.err_message = nil if !@script.err_message.nil?

    respond_to do |format|
      if @script.update_attributes(params[:script])
        Script.delay.check_query(@script)
        format.html { redirect_to @script, notice: 'Script was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scripts/1
  # DELETE /scripts/1.json
  def destroy
    @script = Script.find(params[:id])
    @script.destroy

    respond_to do |format|
      format.html { redirect_to scripts_url }
      format.json { head :no_content }
    end
  end

  private

  def get_all_frequencies
    @frequencies = Frequency.all(:order => 'id')
  end

  def get_all_users
    @users = User.all(:order => 'name')
  end

  def get_all_categories
    @categories = Category.all(:order => 'name')
  end
end
