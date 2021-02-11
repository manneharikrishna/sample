class PhotosController < BaseController
  def index
    photos = PhotosQuery.new(current_player).call
    render json: photos, each_serializer: PhotosSerializer
  end

  def create
    photo = current_player.photos.create(photo_params)

    if photo.persisted?
      render json: photo, status: :created
    else
      render_errors(photo)
    end
  end

  def destroy
    DeletePhoto.new(photo).call
    head :ok
  end

  private

  def photo_params
    params.permit(:image)
  end

  def photo
    @photo ||= current_player.photos.find(params[:id])
  end
end
