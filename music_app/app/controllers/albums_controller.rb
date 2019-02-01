class AlbumsController < ApplicationController
    def show 
        @album = Album.find_by(id: params[:id])
        render :show
    end
    
    def new
        @album = Album.new
        @band = Band.find_by(id: params[:band_id])
        @album.band_id = @band.id 
        render :new
    end

    def edit
        @album = Album.find_by(id: params[:id])
        @band = Band.find_by(id: @album.band_id)
        render :edit
    end

    def create 
        
        @band = Band.find_by(id: params[:album][:band_id])
       @album = Album.new(album_params)
       
       if @album.save 
        redirect_to band_url(params[:album][:band_id])
       else
        flash.now[:errors] = @album.errors.full_messages
        render :new
       end
    end

    def update
    end
    
    def destroy 
    end 

    private
    def album_params 
        params.require(:album).permit(:title, :year, :studio?, :band_id)
    end

end