class City < ApplicationRecord
  # Une ville peut avoir plusieurs utilisateurs (relation one-to-many)
  has_many :users
end


