module OffersHelper
  def offer_data_object(offer)
    {url: json_offer_path(offer, format: :json)}.to_json
  end
end
