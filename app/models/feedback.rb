class Feedback < ActiveRecord::Base
  attr_accessible :body, :category, :email
end
