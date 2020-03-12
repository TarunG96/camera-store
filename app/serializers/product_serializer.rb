class ProductSerializer < ActiveModel::Serializer

  def attributes(*args)
    data = super
    data[:id] = object.id
    data[:name] = object.name
    data[:description] = object.description
    data[:make] = object.make
    data[:price] = object.price
    data

  end
end
