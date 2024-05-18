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
  # pdf.pages.map  { |page| page.text }.join

  # But we return the last one just for testing (to don't spend a lot of tokens)
  pdf.pages.first.text
end


