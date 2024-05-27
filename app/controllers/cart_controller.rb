class CartController < ApplicationController
  def show
    @render_cart = true
  end

  def add
    @lesson = Lesson.find_by(id: params[:id])
  
    unless @lesson
      flash[:error] = 'La lección no existe.'
      redirect_back(fallback_location: root_path)
      return
    end
  
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(lesson_id: @lesson.id)
  
    if current_orderable
      
      return redirect_to request.referer, alert: "La clase seleccionada ya esta en el carrito. Selecciona otra."
    else
      @cart.orderables.create(lesson: @lesson, quantity: quantity)
      
    end
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart }),
          turbo_stream.replace('alert', partial: 'layouts/notice')
        ]
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

