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

    def_delegators :@matching_sentences, :size, :[]

    def initialize(search_term, sentences)
      @search_term, @sentences = search_term, sentences
      @matching_sentences = filter_sentences
    end

    def size
      @matching_sentences.size
    end

    def random_sentence
      MatchingSentence.new random_index, @matching_sentences[random_index]
    end

    private

    def random_index
      @random_index ||= rand @matching_sentences.size
    end

    def filter_sentences
      return @sentences.dup unless @search_term

      @sentences.find_all do |sentence|
        sentence.text =~ /#{@search_term}/i
      end
    end
  end
end
