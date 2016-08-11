require 'color_functions'

describe Color do
  it 'is awesome' do
    expect(Color::score_to_rgb(0.45)).to eq({red: 140, green: 114, blue: 0})
  end
end