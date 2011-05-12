Sched::Application.routes.draw do

  match 'at/:datetime' => 'api#at', :datetime => /\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}/
  match 'in/:n.:unit' => 'api#in', :n => /\d+/, :unit => /(minutes?|hours?|days?|weeks?|months?)/
  match 'every/:n.:unit' => 'api#every', :n => /\d+/, :unit => /(minutes?|hours?|days?|weeks?|months?)/

end
