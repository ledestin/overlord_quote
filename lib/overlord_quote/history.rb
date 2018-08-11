require 'active_support/core_ext/object/blank'

module OverlordQuote::History
  class LoadError < RuntimeError; end

  RC_DIR = File.join ENV["HOME"], ".overlord_quote"
  PREVIOUS_CONTEXT_FILE = File.join RC_DIR, "context.yaml"

  def self.save_context(search_term, matching_sequence_id)
    Dir.mkdir(RC_DIR) unless Dir.exists?(RC_DIR)

    yaml = {
      search_term: search_term,
      matching_sequence_id: matching_sequence_id
    }.to_yaml

    IO.write PREVIOUS_CONTEXT_FILE, yaml
  end

  def self.load_context_from_previous_call
    raise LoadError.new(
      "Context file doesn't exist: #{PREVIOUS_CONTEXT_FILE}") \
      unless File.exists? PREVIOUS_CONTEXT_FILE

    context = YAML.load IO.read(PREVIOUS_CONTEXT_FILE)
    check_context context

    [context[:search_term], context[:matching_sequence_id]]
  end

  def self.check_context(context)
    raise LoadError.new("Invalid saved context, please run without --last to create new context") unless valid_context?(context)
  end

  def self.valid_context?(context)
    context[:search_term].present? && context[:matching_sequence_id].present?
  end
end
