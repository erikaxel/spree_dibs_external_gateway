Spree::Core::Engine.add_routes do
  post '/dibs/return', to: 'checkout#dibs_return'
  post '/dibs/cancel', to: 'checkout#dibs_cancel'
  post '/dibs/test_post', to: 'dibs#test_post'
end
