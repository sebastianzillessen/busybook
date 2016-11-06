Rails.application.routes.draw do
  resources :schedules
  resources :calendars
  resources :offers

  root to: "calendars#index"

  methods = %w(options get put delete mkcalendar propfind proppatch report move copy)

  methods.each do |method|
    with_options to: 'ical/calendar#' + method, via: method.to_s do
      match '/calendar', calendar: '', calendar_object: ''
      match '/calendar/:calendar', calendar_object: ''
      match '/calendar/:calendar/*calendar_object'
    end

    with_options to: 'well_known#redirect', via: method.to_s do
      match '/.well-known/:type'
    end
  end

  namespace :json do
    resources :schedules
    resources :calendars
    resources :offers
    match 'offered_schedules/:id' => 'offered_schedules#update', as: :offered_schedule, via: [:put, :get]
  end


  # other requests: return 404 Bad Request
  methods.each do |method|
    #match '/*otherwise', to: proc { [404, {}, ['']] }, via: method

    # return 200 to prevent annoying OS X calendar error prompts
    match '/', to: proc { [200, {}, ['']] }, via: method
  end


end
