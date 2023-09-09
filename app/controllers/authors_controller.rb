# frozen_string_literal: true

class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show edit update destroy]

  def index
    @authors = Author.all
  end

  def show; end

  def new
    @author = Author.new
  end

  def edit; end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to author_url(@author), notice: "Author was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @author.update(author_params)
      redirect_to author_url(@author), notice: "Author was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @author.destroy

    redirect_to authors_url, notice: "Author was successfully destroyed."
  end

  def report
    @author = Author.includes(:books).find(params[:id])
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :cpf)
  end
end
