# frozen_string_literal: true

module Utils
  # Filters out all the valid emails from the argument string
  # @param [Array<String>] mails string of emails entered
  # @return [Array<String>] array of valid emails
  def self.parse_mails(mails)
    mails.split(/[\s,]/).select do |email|
      email.present? && Devise.email_regexp.match?(email)
    end.uniq.map(&:downcase)
  end

  # Filters out all the valid emails from the argument string except the current user
  # @param [Array<String>] mails string of emails entered
  # @param [User] current current user
  # @return [Array<String>] array of emails except the current user's mail
  def self.parse_mails_except_current_user(mails, current)
    mails.split(/[\s,]/).select do |email|
      email.present? && email != current.email && Devise.email_regexp.match?(email)
    end.uniq.map(&:downcase)
  end

  # Forms notice string for given email input
  # @param [Array<String>] input_mails string of emails entered
  # @param [Array<String>] parsed_mails array of valid emails
  # @param [Array<String>] newly_added array of emails that have been newly added
  # @return [String] notice string
  def self.mail_notice(input_mails, parsed_mails, newly_added)
    total = input_mails.count(&:present?)
    valid = parsed_mails.count
    invalid = total - valid
    already_present = (parsed_mails - newly_added).count

    notice = if total != 0 && valid != 0
      "Out of #{total} Email(s), #{valid} #{valid == 1 ? 'was' : 'were'} valid and #{invalid} #{invalid == 1 ? 'was' : 'were'} invalid. #{newly_added.count} user(s) will be invited. " + \
        (if already_present.zero?
           "No users were already present."
         else
           "#{already_present} user(s) #{already_present == 1 ? 'was' : 'were'} already present."
         end)
    else
      "No valid Email(s) entered."
    end
  end
end
