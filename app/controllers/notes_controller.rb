class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_note, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    if current_user.has_role? :admin
      @notes = Note.all
    else
      @notes = Note.where(user_id: current_user)
    end
  end

  def new
    @note = current_user.notes.build
  end

  def create
    @note = current_user.notes.build(note_params)

    if @note.save
      redirect_to @note
    else
      render 'new'
    end
  end

  def show
  end

  def edit

  end

  def update
    if @note.update(note_params)
      redirect_to @note
    else
      render 'edit'
    end

  end

  def destroy
    @note.destroy
    redirect_to notes_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end

  def find_note
    @note = Note.find(params[:id])
  end
end
