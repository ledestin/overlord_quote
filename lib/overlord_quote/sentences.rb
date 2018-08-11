module OverlordQuote
  Sentence = Struct.new(:id, :text) do
    def to_s
      text
    end
  end

  class Sentences
    SENTENCE_REGEX = /(?:^|\.\s*)(?:\s*)([A-Z][^.]+\.)/m

    include Enumerable
    extend Forwardable

    def_delegators :@sentences, :size, :[]

    def initialize(text_file)
      text = File.read text_file
      @sentences = text.scan(SENTENCE_REGEX).flatten

      @sentences = @sentences.each_with_index.map do |sentence, id|
        Sentence.new id, sentence
      end
    end

    def each(&b)
      @sentences.each &b
    end

    def quote(starting_sentence:, after_sentences: )
      format_quote \
        @sentences.slice(starting_sentence.id,
                         after_sentences + 1).join(" ")
    end

    private

    def format_quote(quote)
      remove_line_breaks quote
    end

    def remove_line_breaks(text)
      text.gsub("\n", " ").chomp
    end
  end
end
