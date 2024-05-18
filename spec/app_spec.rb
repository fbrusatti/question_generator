ENV['APP_ENV'] = 'test'

require_relative '../app'
require 'rspec'
require 'rack/test'

RSpec.describe 'Sinatra AI' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'home page serves' do
    get '/'
    expect(last_response).to be_ok
  end

  describe 'extract_text_from_pdf' do
    it 'works' do
      # Path to the test PDF file
      file_path = 'spec/fixtures/test_pdf_file.pdf'

      # Open the file
      file = File.open(file_path, 'rb')

      # Call the method
      extracted_text = extract_text_from_pdf(file)

      # Close the file
      file.close

      # Expectations based on the content of your test PDF file
      expect(extracted_text).to include('This is a test PDF file!')
    end
  end
end

