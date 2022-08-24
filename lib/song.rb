class Song

  attr_accessor :id, :name, :album

  def initialize(id:nil, name:, album:)
    @id = id
    @name = name
    @album = album
  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end
  
  def save
    #For strings that will take up multiple lines in your text editor, use a heredoc (Links to an external site.) to create a string that runs on to multiple lines. <<- + special word meaning "End of Document" + the string, on multiple lines + special word meaning "End of Document". You don't have to use a heredoc, it's just a helpful tool for crafting long strings in Ruby. 
    #Back to our regularly scheduled programming...
    sql = <<-SQL
    INSERT INTO songs (name, album)
    VALUES (?, ?)
    SQL
    #Instead of interpolating variables into a string of SQL, we are using the ? characters as placeholders.
#call the variable db to update the data.
    DB[:conn].execute(sql, self.name, self.album)

    #get the song ID from the database and save it to the ruby instance
    self.id= DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    #return the ruby instance.
  self
  end

  def self.create(name:, album:)
    song=Song.new(name:name, album: album)
    song.save
  end
end

azimimio =Song.new(name: "Gold Digger", album: "Late Registration")
  azimimio.name
azimimio.album

