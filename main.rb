# Exercise 6

class ParseParticipants
  
  def initialize(participant_email_string)
    @participant_email_string = participant_email_string
  end

  def parse_email_string 
    participants= []
    return if @participants_email_string.blank?
    @participants_email_string.split.uniq.map do |email_address|
      User.create(email: email_address.downcase, password: Devise.friendly_token)
    end
  end
end

class LaunchDiscussionWorkflow

  def initialize(discussion, host, participants)
    @discussion = discussion
    @host = host
    @participants = participants
  end

  def run
    return unless valid?
    run_callbacks(:create) do
      ActiveRecord::Base.transaction do
        discussion.save!
        create_discussion_roles!
      end
    end
  end
  # ...
end

discussion = Discussion.new(title: "fake", ...)
host = User.find(42)
participants_email_string = ParseParticipants.new("fake1@example.com\nfake2@example.com\nfake3@example.com")
participants = participant_email_string.parse_email_string

workflow = LaunchDiscussionWorkflow.new(discussion, host, participants)
workflow.run
