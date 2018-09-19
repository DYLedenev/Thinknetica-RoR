cargo_wagon.rb - child class of wagon.rb

main.rb - code launch

pass_train.rb - child class of train.rb

questionnaire.rb - base class of console.rb and menu.rb. This class contains methods with questions which are
frequently used in console.rb for the user input. I have used it to incapsulate questions from the console since console
class is being too big with these methods.

route.rb - base class, creates routes

train.rb - base class, creates trains

cargo_train.rb - child class of train.rb

console.rb - child class of questionnaire.rb but it is a parent class for menu.rb. Console - is a bunch of methods which
are using to operate by existing classes: unite them, compare and use for the user interaction.

menu.rb - child class of questionnaire.rb and console.rb. Outputs the menu and calls console methods. I used it to be
in the different class in order to encapsulate initialization and other methods of console. Also, console class is being
too big without it.

pass_wagon.rb - child class of wagon.rb
requirements.rb - here I put all require_relatives alltogether. This made LOC number better :)

station.rb - base class, creates stations

wagon.rb - base class, creates wagons

test.rb - created this one to test each class methods.
