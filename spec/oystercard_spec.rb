# This is the error: uninitialized constant Oystercard (NameError)
# This is the file path: /Users/acsauk/Projects/week_2/oystercard/spec/oystercard_spec.rb
# This is the line number of the error: 2
# The NameError has appeared because we have not told the spec file where to find the constant
# Create a constant/class called 'Oystercard' and link it in the spec file using require
require 'oystercard'

describe Oystercard do

 context 'when a new card is initialized' do

   it 'has a default monetary value of zero' do
     card = Oystercard.new
     expect( subject.balance ).to eq(0)
   end

 end

end
