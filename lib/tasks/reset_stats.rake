desc "Reset W/L and rating"
task reset_rating: :environment do
  User.all.each do |user|
    user.wins = 0
    user.losses = 0
    user.rating = 1400
    user.save
  end
end