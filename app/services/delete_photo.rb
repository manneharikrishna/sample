class DeletePhoto
  def initialize(photo)
    @photo = photo
  end

  def call
    if @photo.played? || @photo.subscribed?
      @photo.update!(visible: false)
    else
      @photo.destroy!
    end
  end
end
