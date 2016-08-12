module Color
  def self.score_to_rgb(score)
    start_color = {red: 255, green: 0, blue: 0}
    end_color = {red: 0, green: 255, blue: 0}

    mixed_color = {red: 0, green: 0, blue: 0}

    [:red, :green, :blue].each do |component|
      mixed_color[component] += end_color[component]*score
      mixed_color[component] += start_color[component]*(1-score)
      mixed_color[component] = mixed_color[component].floor
    end

    mixed_color
  end

  def self.rgb_to_hex(rgb)
    "#"+("%02x" % rgb[:red]) + ("%02x" % rgb[:green]) + ("%02x" % rgb[:blue])
  end
end