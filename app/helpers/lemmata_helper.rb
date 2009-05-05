module LemmataHelper

  def underline(text)
    text.gsub(/\b_([^_]+)_\b/) { |m| "<u>" + h($1) + "</u>" }
  end
end
