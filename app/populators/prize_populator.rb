PrizePopulator = lambda do |options|
  fragment = options[:fragment]
  collection = options[:collection]

  item = collection.find_by(id: fragment[:id].to_i)

  if fragment[:_destroy].to_bool
    collection.delete(item)
    return skip!
  end

  item || collection.append(Prize.new)
end
