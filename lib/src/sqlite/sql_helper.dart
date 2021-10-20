import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE books(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        isbn TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<void> createTablesuser(sql.Database database) async {
    await database.execute("""CREATE TABLE user(
        id TEXT PRIMARY KEY  NOT NULL,
        password TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    print("Created tables user");
  }

  static Future<void> dropdatabase(sql.Database database) async {
    await database.execute("""drop database
      """);
    print("Created tables user");
  }

// id: the id of a item
// title, isbn: name and isbn of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<void> createdummy() async {
    // When creating the db, create the table
    final db = await SQLHelper.db();

    db.execute("""
    INSERT INTO books (title,isbn)
    VALUES('Harry Potter and the Philosophers Stone','2070643026');
    
      """);
    db.execute("""
    INSERT INTO books (title,isbn)
    VALUES('Harry Potter and the Chamber of Secrets','0439064864');
    
      """);
    db.execute("""
    INSERT INTO books (title,isbn)
    VALUES('Harry Potter and the Prisoner of Azkaban','0439136350');
    
      """);
    db.execute("""
    INSERT INTO books (title,isbn)
    VALUES('Harry Potter and the Goblet of Fire','0439139597');
    
      """);
    db.execute("""
    INSERT INTO books (title,isbn)
    VALUES('Harry Potter and the Order of the Phoenix','0439358078');
    
      """);
    db.execute("""
    INSERT INTO books (title,isbn)
    VALUES('Harry Potter and the Half-Blood Prince','9602749660');
    
      """);
    db.execute("""
    INSERT INTO books (title,isbn)
    VALUES('Harry Potter and the Deathly Hallows','0545139708');
    
      """);
    db.execute("""
    INSERT INTO books (title,isbn)
    VALUES('Dont Make Me Think Revisited A Common Sense Approach to Web Usability','9780321965516');
    
      """);
    db.execute("""
    INSERT INTO books (title,isbn)
    VALUES('Steal like an artist','9780761169253');
    
      """);
    db.execute("""
    INSERT INTO books (title,isbn)
    VALUES('New Moon','1905654642');
    
      """);

    print("Created tables");
  }

  static Future<void> createdusers() async {
    // When creating the db, create the table
    final db = await SQLHelper.db();

    db.execute("""CREATE TABLE user(
        id TEXT PRIMARY KEY  NOT NULL,
        password TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    db.execute("""
    INSERT INTO user (id,password)
    VALUES('admin','admin');
      """);
    db.execute("""
    INSERT INTO user (id,password)
    VALUES('user','user');
      """);

    print("Created tables user");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'bookmanager.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String title, String? noisbn) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'isbn': noisbn};
    final id = await db.insert('books', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getBooks() async {
    final db = await SQLHelper.db();
    return db.query('books', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('books', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getUser(
      String id, String password) async {
    final db = await SQLHelper.db();
    return db.rawQuery("SELECT * FROM user where id = '" +
        id +
        "' and password = '" +
        password +
        "'");
  }

  // Update an item by id
  static Future<int> updateItem(int id, String title, String? noisbn) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'isbn': noisbn,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('books', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("books", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}
