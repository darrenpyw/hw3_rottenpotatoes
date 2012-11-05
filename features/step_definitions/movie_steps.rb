# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
#flunk "Unimplemented"
end

Then /I should see the following movies/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    if !(movie[:rating] =~ /[PG||R]/) then flunk "sort by rating is not working" end
  end
#flunk "Unimplemented"
end

Then /I should not see the following movies/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    if !(movie[:rating] =~ /[PG\-13||G]/) then flunk "sort by rating is not working" end
  end
#flunk "Unimplemented"
end

Then /I should not see any movies/ do
  rows= page.all("table#movies tbody tr td[1]").map {|t| t.text}.size
  rows.should == 0
end

Then /I should see all the movies/ do
  rows= page.all("table#movies tbody tr td[1]").map {|t| t.text}.size
  rows.should == Movie.all.size
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  puts page.body.include? "/(.*)#{e1}(.*)#{e2}/"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |rate|
    if uncheck == "un"
      step %Q(I uncheck #{rate})
    else
      step %Q(I check #{rate})
    end
  end
end

