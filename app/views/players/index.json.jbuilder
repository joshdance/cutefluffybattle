json.array!(@players) do |player|
  json.extract! player, :id, :name, :wins, :matches, :win_percentage
  json.url player_url(player, format: :json)
end
