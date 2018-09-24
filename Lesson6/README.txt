1) cargo_train.rb - child class of train.rb

2) cargo_wagon.rb - child class of wagon.rb

3) console.rb - one of the main classes - it is a bunch of methods which are using to operate by existing classes:
unite them, compare and use for the user interaction.

4) inputerror.rb - my own error class - child of StandardError.

5) instancecounter.rb - module with class and instance methods which helps to automatically count current class instances

6) main.rb - code launch

7) pass_train.rb - child class of train.rb

8) pass_wagon.rb - child class of wagon.rb

9) questionnaire.rb - base class of console.rb and menu.rb. This class contains methods with questions which are
frequently used in console.rb for the user input. I have used it to incapsulate questions from the console since console
class is being too big with these methods.

10) requirements.rb - here I put all require_relatives alltogether. This made LOC number better :)

11) route.rb - base class, creates routes

12) station.rb - base class, creates stations

13) test.rb - created this one to test each class methods.

14) train.rb - base class, creates trains

15) validation.rb - module which provides possibility of validating user input

16) wagon.rb - base class, creates wagons
