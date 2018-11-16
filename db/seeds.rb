User.create(username: "BaublesBaloo", email: "Baubles@hotmail.com", password: "Woof!")

Piece.create(name: "Jug", size: "1.5 Pint", user_id: User.find_by_username("BaublesBaloo").id)
Pattern.create(name: "Love & Kisses", user_id: User.find_by_username("BaublesBaloo").id)

Piece.create(name: "Mug", size: "Half Pint", user_id: User.find_by_username("BaublesBaloo").id)
Pattern.create(name: "Utility", user_id: User.find_by_username("BaublesBaloo").id)

Piece.create(name: "Mug", size: "1 Pint", user_id: User.find_by_username("BaublesBaloo").id)
Pattern.create(name: "Black Toast", user_id: User.find_by_username("BaublesBaloo").id)

Piece.create(name: "Bowl", size: "French", user_id: User.find_by_username("BaublesBaloo").id)
Pattern.create(name: "Cambridge Blue Toast", user_id: User.find_by_username("BaublesBaloo").id)

Piece.create(name: "Teapot", size: "2 Cup (Old Style)", user_id: User.find_by_username("BaublesBaloo").id)
Pattern.create(name: "Blue Toast", user_id: User.find_by_username("BaublesBaloo").id)

PiecePattern.create(piece_id: Piece.find_by_name("Mug").id, pattern_id: Pattern.find_by_name("Love & Kisses").id)
PiecePattern.create(piece_id: Piece.find_by_name("Mug").id, pattern_id: Pattern.find_by_name("Black Toast").id)
PiecePattern.create(piece_id: Piece.find_by_name("Bowl").id, pattern_id: Pattern.find_by_name("Utility").id)
PiecePattern.create(piece_id: Piece.find_by_name("Bowl").id, pattern_id: Pattern.find_by_name("Blue Toast").id)
PiecePattern.create(piece_id: Piece.find_by_name("Jug").id, pattern_id: Pattern.find_by_name("Love & Kisses").id)
PiecePattern.create(piece_id: Piece.find_by_name("Jug").id, pattern_id: Pattern.find_by_name("Utility").id)
PiecePattern.create(piece_id: Piece.find_by_name("Mug").id, pattern_id: Pattern.find_by_name("Cambridge Blue Toast").id)
PiecePattern.create(piece_id: Piece.find_by_name("Teapot").id, pattern_id: Pattern.find_by_name("Utility").id)


Wishlist.create(user_id: User.find_by_username("BaublesBaloo").id, pattern_name: "Love & Kisses", piece_name: "Candle Holder", piece_size: "Large", quantity: "2" )
Wishlist.create(user_id: User.find_by_username("BaublesBaloo").id, pattern_name: "Utility", piece_name: "Cup & Saucer", piece_size: "Large", quantity: "2" )
Wishlist.create(user_id: User.find_by_username("BaublesBaloo").id, pattern_name: "Cambridge Blue Toast", piece_name: "Bowl", piece_size: "French", quantity: "2" )
Wishlist.create(user_id: User.find_by_username("BaublesBaloo").id, pattern_name: "Love & Kisses", piece_name: "Plate", piece_size: "8.5 Inch", quantity: "1" )
Wishlist.create(user_id: User.find_by_username("BaublesBaloo").id, pattern_name: "Tiny Toast & Marmalade", piece_name: "Sugarpot", piece_size: "Dollies", quantity: "1" )
Wishlist.create(user_id: User.find_by_username("BaublesBaloo").id, pattern_name: "Tiny Toast & Marmalade", piece_name: "Jug", piece_size: "Dollies", quantity: "1" )
Wishlist.create(user_id: User.find_by_username("BaublesBaloo").id, pattern_name: "Tiny Toast & Marmalade", piece_name: "Cup & Saucer", piece_size: "Dollies", quantity: "3" )
