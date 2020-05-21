class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  # GET /parties
  # GET /parties.json
  def index
    @parties = current_user.parties
    @upcoming_invites = current_user.parties_guest
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
    @party = Party.find(params[:id])
  end

  # GET /parties/new
  def new
    @party = Party.new
  end

  # GET /parties/1/edit
  def edit
    @party = Party.find(params[:id])
    redirect_to @party unless @party.user_id == current_user.id
  end

  # POST /parties
  # POST /parties.json
  def create
    @party = Party.new(party_params)
    @party.user_id = current_user.id
    respond_to do |format|
      if @party.save
        format.html { redirect_to @party, notice: 'Party was successfully created.' }
        format.json { render :show, status: :created, location: @party }
      else
        format.html { render :new }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parties/1
  # PATCH/PUT /parties/1.json
  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @party }
      else
        format.html { render :edit }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def party_params
      params.require(:party).permit(:name, :location, :start_time, :end_time, :details, :guest_list)
    end
end
