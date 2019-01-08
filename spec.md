# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
 *Sinatra is used*
- [x] Use ActiveRecord for storing information in a database
 *ActiveRecord is used*
- [x] Include more than one model class (e.g. User, Post, Category)
 *Models used are: User, Team, and Player*
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
 *A Team has_many Players*
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
 *A Player belongs_to a team/a team belongs_to a user*
- [x] Include user accounts with unique login attribute (username or email)
 *There are user accounts and a unique email and username is needed to signup*
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
 *Users can create, read, update, destroy their team*
- [x] Ensure that users can't modify content created by other users
 *Users can only edit their team/select players not already selected by other users*
- [x] Include user input validations
 *Bcrypt is used to validate passwords/the correct username has to be inputed in order to log in*
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
 *The README includes a short description, install instructions, a contributors guide and a link to the license for your code*
Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
