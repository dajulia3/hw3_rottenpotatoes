# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create! movie
  end
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I (uncheck|check) the following ratings: (.*)/ do |check_uncheck, rating_list|
  ratings_arr = rating_list.scan(/"([^"]*)"\s*,?\s*/).flatten
  if check_uncheck == "check"
    ratings_arr.each {|rating|check "ratings["+rating+"]" }
  elsif check_uncheck =="uncheck"
    ratings_arr.each {|rating|uncheck "ratings["+rating+"]" }
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

#Don't know if this works yet...
Then /I should see all of the movies/ do
  #Movie.all.each{|mov| step %Q{Then I should see "#{mov.title}"} } my original way...
  #but let's do it their suggested way
  page.should have_css("table#movielist tbody tr", :count=> Movie.all.count)
end
