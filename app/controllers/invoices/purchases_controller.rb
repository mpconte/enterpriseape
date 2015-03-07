class Invoices::PurchasesController < ApplicationController  

  respond_to :html
  
  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all
    respond_with(@purchases)
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
    respond_with(@purchase)
  end

  # GET /purchases/new
  def new
    @invoice = Invoice.find(params[:invoice_id])
    @purchase = Purchase.new
    
    respond_with(@purchase)
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @invoice = Invoice.find(params[:invoice_id])
    @purchase = Purchase.new(purchase_params)
    @purchase.invoice = @invoice

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @invoice, notice: 'Purchase was successfully created.' }
        format.json { render action: 'show', status: :created, location: @invoice }
      else
        format.html { render action: 'new' }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @purchase.update(purchase_params)
    respond_with(@purchase)
  end

  def destroy
    @invoice = Invoice.find(params[:invocie_id])
    @purchase = Purchase.find(params[:id])
    title = @purchase.name
    
    if @purchase.destroy 
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @invoice
    else
      flash[:error] = "There was an error deleting the purchase."
      render :show
    end
  end

  private
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    def purchase_params
      params.require(:purchase).permit(:name, :category, :quantity, :invoice_id, :price)
    end
end
