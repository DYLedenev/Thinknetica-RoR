1) ./classes/cargo_train.rb - child class of train.rb

2) ./classes/cargo_wagon.rb - child class of wagon.rb

3) ./classes/console.rb - one of the main classes - it is a bunch of methods which are using to operate by existing classes:
unite them, compare and use for the user interaction.

4) ./classes/inputerror.rb - my own error class - child of StandardError.

5) ./modules/instancecounter.rb - module with class and instance methods which helps to automatically count current class instances

6) main.rb - code launch

7) ./classes/pass_train.rb - child class of train.rb

8) ./classes/pass_wagon.rb - child class of wagon.rb

9) ./modules/questions.rb - base class of console.rb. This class contains methods with questions which are
frequently used in console.rb for the user input. I have used it to incapsulate questions from the console since console
class is being too big with these methods.

10) ./classes/route.rb - base class, creates routes

11) ./classes/station.rb - base class, creates stations

12) ./classes/train.rb - base class, creates trains

13) ./modules/validation.rb - module which provides possibility of validating user input

14) ./classes/wagon.rb - base class, creates wagons
