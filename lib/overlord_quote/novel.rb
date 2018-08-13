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
      @sentences.find_all do |sentence|
        sentence.text =~ /#{search_term}/i
      end
    end

    def quote(starting_sentence:, before_sentences: 0, after_sentences: )
      start_id = decrement_id(starting_sentence.id, before_sentences)
      end_id = starting_sentence.id + after_sentences

      format_quote \
        @sentences.slice(start_id..end_id).join(" ")
    end

    private

    def decrement_id(id, decrement_by)
      new_id = id - decrement_by
      new_id = 0 if new_id.negative?
      new_id
    end

    def format_quote(quote)
      remove_line_breaks quote
    end

    def remove_line_breaks(text)
      text.gsub("\n", " ").chomp
    end
  end
end
