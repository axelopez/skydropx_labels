class RequestLabelsController < ApplicationController
  before_action :set_request_label, only: %i[ show edit update destroy retry ]

  # GET /request_labels or /request_labels.json
  def index
    @request_labels = RequestLabel.where("identifier like ?", "%#{params[:search]}%").order("updated_at desc").page params[:page]
  end

  # GET /request_labels/1 or /request_labels/1.json
  def show
  end

  # GET /request_labels/new
  def new
    @request_label = RequestLabel.new
  end

  # GET /request_labels/1/edit
  def edit
  end


  def retry
    LabelWorker.perform_async @request_label.id
    redirect_to @request_label, alert: "Task Queued"
  end

  # POST /request_labels or /request_labels.json
  def create
    @request_label = RequestLabel.new(request_label_params)

    respond_to do |format|
      if @request_label.save
        format.html { redirect_to @request_label, notice: "Request label was successfully created." }
        format.json { render :show, status: :created, location: @request_label }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_labels/1 or /request_labels/1.json
  def update
    respond_to do |format|
      if @request_label.update(request_label_params)
        format.html { redirect_to @request_label, notice: "Request label was successfully updated." }
        format.json { render :show, status: :ok, location: @request_label }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_labels/1 or /request_labels/1.json
  def destroy
    @request_label.destroy
    respond_to do |format|
      format.html { redirect_to request_labels_url, notice: "Request label was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_label
      @request_label = RequestLabel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_label_params
      params.require(:request_label).permit(:token_id, :status, :request)
    end
end
