class IssueMailer < ActionMailer::Base

  def issue(issue)
    recipients    APP_CONFIG["site_owner"]["email"]
    from          "no-reply@bilexicon"
    subject       "Issue: #{issue[:title]}"
    sent_on       Time.now
    body          issue
  end

end
