require 'csv'

class EntryCSV
  def initialize(data:)
    @csv            = CSV.new(data, headers: true)
    @error_messages = []
    @rows           = []
  end

  def valid?
    readable? && headers_present?
  end

  attr_reader(
    :error_messages,
    :occurred_on_index,
    :amount_index,
    :description_index
  )

  delegate :close, to: :csv

  def each(&block)
    raise(StandardError, "CSV data is invalid") unless valid?

    rows.each do |row|
      yield(row)
    end
  end

  private

  attr_reader :csv, :rows

  def readable?
    return true if rows.any?

    csv.each { |row| rows << row }
    true
  rescue => e
    @error_messages << "CSV read error: #{e.message}"
    false
  end

  def headers_present?
    set_header_indices

    validate_occurred_on_index
    validate_amount_index
    validate_description_index

    error_messages.empty?
  end

  def set_header_indices
    return unless csv.headers.is_a?(Array)

    @occurred_on_index = find_occurred_on_index
    @amount_index      = find_amount_index
    @description_index = find_description_index
  end

  def find_occurred_on_index
    csv.headers.find_index { |header| header.downcase.include?("post date") }
  end

  def find_amount_index
    csv.headers.find_index { |header| header.downcase.include?("amount") }
  end

  def find_description_index
    csv.headers.find_index { |header| header.downcase.in?(%w(payee description)) }
  end

  def validate_occurred_on_index
    if occurred_on_index.blank?
      @error_messages << "Unable to identify date column in CSV"
    end
  end

  def validate_amount_index
    if amount_index.blank?
      @error_messages << "Unable to identify amount column in CSV"
    end
  end

  def validate_description_index
    if description_index.blank?
      @error_messages << "Unable to identify description column in CSV"
    end
  end
end
