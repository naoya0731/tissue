Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'SQ3yaux2ikNxtItISkMBVLbVg', 'd4ukPRYHmz7PVt29G1KeLMBY8bgN2glseIiqBeCKwWahbKNvaA', callback_url: "http://127.0.0.1:3000/users/auth/twitter/callback"
end