class CategorySerializer < ActiveModel::Serializer

  def attributes(*args)
    data = super
    data[:id] = object.id
    data[:name] = object.name
    data[:category_type] = object.category_type
    data[:model] = object.model
    data

  end
end
