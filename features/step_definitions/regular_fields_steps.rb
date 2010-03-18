Given /^the noun has an? (annotation)$/ do |field|
  field.gsub! " ", "_"
  @lemma["#{field}1"] = @lemma["#{field}2"] = "field content"
  @lemma.save
end

Then /^the page should show the (annotation)$/ do |field|
  field.gsub! " ", "_"
  [1, 2].each do |side|
    response_body.should have_tag ".entry-line" do
      with_tag ".margin#{side}" do
        response_body.should have_tag "span.#{field}"
      end
    end
  end
end

