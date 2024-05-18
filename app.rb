require 'sinatra'
require 'dotenv/load'
require 'openai'
require 'byebug'
require 'pdf/reader'

get '/' do
  erb :index, locals: { text_response: nil }
end

post '/search' do
  file = params[:file][:tempfile]
  pdf_text = extract_text_from_pdf(file)
  @questions = generate_questions(pdf_text)

  erb :index
end

private

# Initialize the OpenAI client
def client
  @client ||= OpenAI::Client.new(
    access_token: ENV['TOKEN_OPENAI'],
    log_errors: true
  )
end

# Generate questions based on `full_text`
#
# returns an array of questions with options and one answer
#
def generate_questions(full_text)
  prompt = <<-STRING
    Generate 3 questions based on the following text.
    For each question, provide 3 multiple-choice options and indicate the correct answer.
    Please format each question as a JSON object (ready to be parsed by ruby with JSON.parse) with: 
        * 'question'
        * 'options' (a list of choices) and 
        * 'answer' (the correct choice) keys.
  STRING

  response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: prompt },
          { role: "user", content: full_text}],
        temperature: 0.7
    })

  response['choices'].map { |choice| JSON.parse(choice['message']['content']) }
end

def extract_text_from_pdf(file)
  pdf = PDF::Reader.new(file)

  # This is the real algorithm to extract all pdf text~
  pdf.pages.map  { |page| page.text }.join
end

# Just for testing purposes to check what models we have available
#
# To use this method start a console with:
# 
#  irb -I. -r app.rb
#  > check_existing_models
#
def check_existing_models
  puts client.models.list
end
