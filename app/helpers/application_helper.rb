# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def path_to_id(string)
    string.tr("/", "-").gsub(/(^-*|-*$)/, '')
  end
end
