# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
materials = 100.times do |i|
  new_mat = Material.find_or_initialize_by({
                "name"=> "Material #{i}",
                })
  new_mat.quantity = i*2
  new_mat.try(:save)
end
