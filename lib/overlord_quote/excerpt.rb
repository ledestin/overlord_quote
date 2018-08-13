require "forwardable"

module OverlordQuote
  class Excerpt
    class Sentence
      attr_reader :id, :sentence

      def initialize(id, sentence)
        @id, @sentence = id, sentence
      end

      def orig_sentence
        @sentence
      end
    end

    extend Forwardable

    def_delegators :@sentences, :empty?, :size, :[]

    def initialize(sentences)
      @sentences = sentences.each_with_index.map do |sentence, id|
        Sentence.new id, sentence
      end
    end

    def random_sentence
      @sentences[random_index]
    end

    private

    def random_index
      rand @sentences.size
    end
  end
end
