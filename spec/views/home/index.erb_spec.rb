require 'spec_helper'

describe 'home/index' do 
  it 'muestra formulario de registro' do 
    assign(:resource, mock_model("User").as_null_object)
    render
    save_and_open_page
    rendered.should have_selector('form.new_user')
  end
end