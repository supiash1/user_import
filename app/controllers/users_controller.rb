class UsersController < ApplicationController
  # TODO: Modify the import method to upload the CSV file directly to S3 and read data from there,
  # as Heroku's filesystem is ephemeral and not suitable for direct file uploads.
  def import
    @user_imports = UsersImport.new(CsvFileReader.new(params[:file].path)).call
    respond_to(&:turbo_stream)
  end
end
