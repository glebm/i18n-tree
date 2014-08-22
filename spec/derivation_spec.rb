require 'spec_helper'

describe 'Derivation' do
  it 'append' do
    expect(
        T[a: 1].append(T.node(:b, 2)).to_h
    ).to eq('a' => 1, 'b' => 2)
  end

  it 'append_at' do
    expect(
        T[a: {b: {x: 1}}].append_at('a.b', T.node(:y, 2)).to_h
    ).to eq('a' => {'b' => {'x' => 1, 'y' => 2}})
  end
end
