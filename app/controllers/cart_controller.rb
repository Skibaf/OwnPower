class CartController < ApplicationController
  def show
    @render_cart = true
  end

  def add
    @lesson = Lesson.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(lesson_id: @lesson.id)
    @cart.orderables.create(lesson: @lesson)
    respond_to do |format|
      format.turbo_stream do
            render turbo_stream: [turbo_stream.replace('cart',
                                                       partial: 'cart/cart',
                                                       locals: { cart: @cart }),
                                  turbo_stream.replace(@plessons)]
       end
      end
  end

  def remove
    Orderable.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart',
                                                  partial: 'cart/cart',
                                                  locals: { cart: @cart })
      end
    end
  end


  end

