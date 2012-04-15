require 'spec_helper'

describe 'home/index.erb' do 
  it 'muestra formulario de registro' do 
    render 
    rendered.should contain('Hola mundo')
  end
end