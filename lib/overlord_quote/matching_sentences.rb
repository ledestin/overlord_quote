require "forwardable"

module OverlordQuote
  class MatchingSentence
    attr_reader :id, :sentence

    def initialize(id, sentence)
      @id, @sentence = id, sentence
    end

    def orig_sentence
      @sentence
    end
  end

  class MatchingSentences
    extend Forwardable

    def_delegators :@matching_sentences, :empty?, :size, :[]

    def initialize(sentences)
      @sentences = sentences
    end

    def random_sentence
      @matching_sentences[random_index]
    end

    private

    def random_index
      rand @matching_sentences.size
    end
  end
end
