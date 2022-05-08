Rails.application.routes.draw do
  get '/' => "home#top"

  get 'items/index' => "items#index"
  
  get 'items/part/:part_number' => "items#part"
  get 'items/date/:supplier_reply' => "items#date"
  get 'items/work/:work_number' => "items#work"
  get 'parts/edit/:part_number' => "parts#index"
  get 'parts/destroy/:part_number' => "parts#destroy"
  get 'items/rescheduled' => "items#rescheduled"
  get 'items/weld' => "items#weld"
  get 'items/tig' => "items#tig"
  get 'items/add' => "items#add"
  get 'items/bend' => "items#bend"
  get 'items/laser' => "items#laser"
  get 'items/valve' => "items#valve"
  get 'items/ebw' => "items#ebw"
  get 'items/long' => "items#long"
  get 'items/out' => "items#out"
  get 'parts' => "parts#index"

  post 'part_search' => "items#part_search"
  post 'work_search' => "items#work_search"
  post 'parts/register' => "parts#register"
  post 'parts' => "parts#index"
  post 'items/laser/request/create/:id' => "items#laser_request_create"
  post 'items/laser/request/cancel/:id' => "items#laser_request_cancel"
  post 'items/laser/receive/create/:id' => "items#laser_receive_create"
  post 'items/laser/receive/cancel/:id' => "items#laser_receive_cancel"

  get 'items/index'
  resources :items do
    collection do
      post :import
    end
  end

  
end