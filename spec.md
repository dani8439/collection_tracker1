# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database - created database with four different tables to reflect the different classes needed to create models.
- [x] Include more than one model class (e.g. User, Post, Category) - User class, Piece class, abd Pattern class.
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - Seven has_many, and has_many_through relationships in order to properly link a piece to a user. Want the models to reflect that a User can have many pieces, and a piece can have many patterns.  
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) PiecePattern is the Join table to link all models, and the belongs_to relationship to both Piece, and Pattern to clearly link all models.
- [x] Include user accounts with unique login attribute (username or email) - Validations in the User class, so that username, and email are unique and no other user can replicate that information.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - All resources have these abilities.
- [x] Ensure that users can't modify content created by other users - multiple times measures are put in place; checking that the information is the same user_id as session[:id], so that actions can be saved, updated, read, or destroyed. Both occur in the Controllers, and within the embedded ruby code to assure a user cannot see another person's content.
- [x] Include user input validations - in users controller so that no username or email are alike, and in piece and pattern so that no fields are empty.
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - flash messages appear at bottom of screen to inform users when there are mistakes made.
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits - more than one hundred.
- [x] Your commit messages are meaningful - tried to be as clear as possible.
- [x] You made the changes in a commit that relate to the commit message - always.
- [x] You don't include changes in a commit that aren't related to the commit message - tried to be as clear as possible.
