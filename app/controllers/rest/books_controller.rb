module Rest
  class BooksController < ApplicationController
    def index
      scope = Book.order(:title)
      scope = scope.where(year: params[:year].to_i) if params[:year]
      @books = scope.all

      render json: @books.as_json(except: %i[created_at updated_at])
    end

    def create
      @book = Book.new(book_params)
      valid = @book.save

      if valid
        render json: @book.as_json(except: %i[created_at updated_at])
      else
        render_invalid_record(@book.errors)
      end
    end

    def years
      @years = Book.group(:year).count.sort
      render json: @years.map { |year, count| { year: year, count: count } }
    end

    private

    def book_params
      params.required(:book).permit(%i[title year description stars category])
    end
  end
end
