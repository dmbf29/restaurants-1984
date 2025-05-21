# Fill the DB with some instances we can use
puts "Cleaning the DB..."
Restaurant.destroy_all
User.destroy_all

CHEFS = %w[Hayao Hikari Jairo Julian Kae Kaho Max Nathaniel Naw Owen Ryan Saulo Shunji Tsering William]
CATEGORIES = %W[burger ramen sushi desserts healthy kebabs pizza tacos sandwiches dumplings soup curry rice pasta steakhouse vegan bakery juice salads seafood brunch wings cafe bbq deli pies buffet pub brasserie shakes creamery grill]

def get_category(name)
  last_word = name.split.last.downcase
  CATEGORIES.include?(last_word) ? last_word : CATEGORIES.sample
end

puts "Creating #{CHEFS.count} Restaurants..."
CHEFS.shuffle.each do |name|
  user = User.create!(email: "#{name.downcase}@lewagon.com", password: '123123', name: name)
  restaurant_name = Faker::Restaurant.unique.name
  Restaurant.create!(
    name: "#{name}'s #{restaurant_name}",
    rating: rand(3..5),
    address: "日本, 〒153-0063 東京都目黒区 目黒#{rand(1..3)}丁目#{rand(1..10)}番#{rand(1..3)}号",
    category: get_category(restaurant_name),
    chef_name: name,
    opening_date: Date.today - rand(10..30),
    user: user
  )
end
puts "... created #{Restaurant.count} restaurants"
