require 'spec_helper'

describe 'Node' do
  let(:test_hash) {
    {'en' => {
        'greeting' => 'Hi %{name}',
        'home'     => {
            'title' => 'My page'
        }},
     'es' => {
         'greeting' => 'Hola %{name}',
         'a'        => {},
         'b'        => nil,
         'c'        => 1,
         'd'        => [1, 2]}}
  }
  let(:test_tree) { T[test_hash] }

  it '#t' do
    expect(test_tree.t('es.greeting')).to eq('Hola %{name}')
    expect(test_tree.t('en.home')).to eq('title' => 'My page')
    expect { test_tree.t('none') }.to raise_error(T::NodeNotFoundError)
  end

  it '#at' do
    expect(test_tree.at('es.greeting').key).to eq('greeting')
    expect(test_tree.at('none')).to be_nil
  end

  it '#merge' do
    a = I18n::Tree['en' => {'blog' => {'title' => 'Blog'}}]
    b = I18n::Tree['en' => {'blog' => {'subtitle' => 'Recent posts'}}]
    expect(a.merge(b)).to eq(T[{'en' => {'blog' => {'subtitle' => 'Recent posts', 'title' => 'Blog'}}}])
  end

  it '#to_h' do
    expect(test_tree.to_h).to eq(test_hash)
  end

  it '#inspect' do
    Term::ANSIColor.coloring = false
    inspected                = test_tree.inspect
    expect(inspected + "\n").to eq <<-TEXT
[tree]:
  en
    greeting: "Hi %{name}"
    home
      title: "My page"
  es
    a
    b: nil
    c: 1
    d: [1, 2]
    greeting: "Hola %{name}"
    TEXT
  end
end
