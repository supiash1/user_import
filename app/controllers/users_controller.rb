class UsersController < ApplicationController
  def import
    @user_imports = UsersImport.new(CsvFileReader.new(params[:file].path)).call
    respond_to(&:turbo_stream)
  end
end
