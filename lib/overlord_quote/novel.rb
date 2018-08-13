require "forwardable"

module OverlordQuote
  Sentence = Struct.new(:id, :text) do
    def to_s
      text
    end
  end

  class Novel
    SENTENCE_REGEX = /(?:^|\.\s*)(?:\s*)([A-Z][^.]+\.)/m

    include Enumerable
    extend Forwardable

    def_delegators :@sentences, :size, :[]

    def self.from_file(file_name)
      text = File.read file_name
      new text.scan(SENTENCE_REGEX).flatten
    end

    def initialize(sentences)
      @sentences = sentences.each_with_index.map do |sentence, id|
        next sentence if sentence.is_a?(Sentence)

        Sentence.new id, sentence
      end
    end

    def each(&b)
      @sentences.each &b
    end

    def find_by_text(search_term)
      return self unless search_term

      matches = @sentences.find_all do |sentence|
        sentence.text =~ /#{@search_term}/i
      end
      self.class.new matches
    end

    def quote(starting_sentence:, after_sentences: )
      format_quote \
        @sentences.slice(starting_sentence.id,
                         after_sentences + 1).join(" ")
    end

    def to_matching
      @sentences.each_with_index.map do |sentence, id|
        MatchingSentence.new id, sentence
      end
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
