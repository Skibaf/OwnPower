class CartController < ApplicationController
  def show
    @render_cart = true
  end

  def add
    @lesson = Lesson.find_by(id: params[:id])

    # Verifica si la lección existe antes de agregarla al carrito
    unless @lesson
      flash[:error] = 'La lección no existe.'
      redirect_back(fallback_location: root_path)
      return
    end

    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(lesson_id: @lesson.id)

    if current_orderable
      # Si ya hay una orderable para esta lección, muestra un mensaje indicando que ya está en el carrito
      flash[:notice] = 'Esta lección ya está en el carrito.'
    else
      # Si no existe, crea una nueva orderable para la lección en el carrito
      @cart.orderables.create(lesson: @lesson, quantity: quantity)
      flash[:success] = 'Lección agregada al carrito correctamente.'
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('cart', partial: 'cart/cart', locals: { cart: @cart }),
          turbo_stream.replace(@plessons)
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

