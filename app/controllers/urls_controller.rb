require 'securerandom'

class UrlsController < ApplicationController
    def create
       url = Url.new url_params
			 url.short_url = shorten_url
			 url.expire_at = Time.current + 2.minutes

			 if url.save
				render json: url, status: :created
			 else
				render json: url.errors, status: 422
			 end
    end

	def short
		url = Url.find_by short_url: params[:short_url]
		if url.expire_at < Time.current
			return render json: {message: "Url Vencida!"}
		end
		
		
		render json: url, status: 200
	end

    private
		def shorten_url
			codes = Url.all.pluck(:short_url)
			random_alphanumeric_string = SecureRandom.alphanumeric(5)
			while codes.include? random_alphanumeric_string do
				random_alphanumeric_string = SecureRandom.alphanumeric(5)
			end
			random_alphanumeric_string
		end


    def url_params
			params.permit(:original_url)
    end

end

