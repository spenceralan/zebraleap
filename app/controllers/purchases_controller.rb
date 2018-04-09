class PurchasesController < ApplicationController

  def index
    purchases = Purchase.by_user(current_user)

    if params[:limit]
      purchases = purchases.provided_limit(params[:limit])
    end

    if params[:since]
      purchases = purchases.since(params[:since])
    end

    render json: { purchases: purchases }
  end
end
