## Question Generator

This small Sinatra application generates multiple-choice questions based on a given text extracted from a pdf file.

Each question has three multiple-choice options where only one is the correct answer.

- `'question'`: Represents the text of the question.
- `'options'`: Represents a list of choices for the question.
- `'answer'`: Represents the correct choice among the options.

Either OpenAI or Ollama models can be used.

To use OpenAI, configure your `.env` file with your `TOKEN_OPENAI` token,
and then call the application with the environment variable `AI_ENGINE=openai`.
Otherwise, the application will default to using Ollama.

To install Ollama

```
brew install ollama
ollama serve
ollama pull llama3:latest # In new terminal tab.
```

### Usage

#### Install

```sh
cp env.example env

# Add your TOKEN_OPENAI token

bundle install

# Start the sinatra application with OpenAI
AI_ENGINE=openai ruby app.rb

# Start it with Ollama
ruby app.rb
```

Open browser upload a pdf file and you will get as response a list of questions
based in the PDF.

### License

The gem is available as open source under the terms of the MIT License. [MIT License](https://opensource.org/license/MIT)

