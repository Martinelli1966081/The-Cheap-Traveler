# app/helpers/maps_helper.rb
module MapsHelper
  # Tipi di mappa validi
  VALID_MAP_TYPES = ['roadmap', 'satellite', 'terrain', 'hybrid'].freeze
  
  # Modalità valide
  VALID_MODES = ['place', 'view', 'directions', 'search', 'streetview'].freeze
  def embed_google_map(location, options = {})
    # Validazione dei parametri
    api_key = validate_api_key
    mode = validate_mode(options[:mode])
    maptype = validate_maptype(options[:maptype])
    
    # Costruzione dei parametri
    params = build_params(location, mode, maptype, options)
    
    # Generazione dell'iframe
    generate_iframe(params, options)
  rescue => e
    handle_error(e)
  end
  private
  def validate_api_key
    key = ENV['GOOGLE_API_KEY'] || Rails.application.credentials.dig(:google_maps, :api_key)
    raise 'Google Maps API key is missing' unless key.present?
    key
  end
  def validate_mode(mode)
    mode = (mode || 'place').to_s.downcase
    VALID_MODES.include?(mode) ? mode : 'place'
  end
  def validate_maptype(maptype)
    maptype = (maptype || 'roadmap').to_s.downcase
    VALID_MAP_TYPES.include?(maptype) ? maptype : 'roadmap'
  end
  def build_params(location, mode, maptype, options)
    params = {
      key: ENV['GOOGLE_API_KEY'],
      q: location,
      zoom: options[:zoom]&.clamp(0, 20) || 14,
      maptype: maptype,
      language: options[:language],
      region: options[:region]
    }.compact
    # Aggiungi parametri specifici per modalità
    case mode
    when 'directions'
      params.merge!({
        origin: options[:origin] || location,
        destination: options[:destination],
        waypoints: options[:waypoints]
      }.compact)
    end
    params
  end
  def generate_iframe(params, options)
    mode = params.delete(:mode) || 'place'
    
    content_tag(:div, class: 'google-map-container') do
      content_tag(:iframe, '', {
        width: options[:width] || '100%',
        height: options[:height] || '400px',
        frameborder: 0,
        style: 'border:0',
        allowfullscreen: true,
        loading: 'lazy',
        referrerpolicy: 'no-referrer-when-downgrade',
        src: "https://www.google.com/maps/embed/v1/#{mode}?#{params.to_query}"
      })
    end
  end
  def handle_error(error)
    if Rails.env.development?
      content_tag(:div, "Google Maps Error: #{error.message}", style: 'color: red; padding: 1rem; border: 2px solid red')
    else
      content_tag(:div, 'Map unavailable', class: 'map-error')
    end
  end
end