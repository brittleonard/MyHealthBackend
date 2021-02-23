class Post
  attr_reader :id, :name, :date, :details, :image

  # if heroku, use heroku psql db
  # --------------------------------------------------
  # if statement shouldn't require change
  if (ENV['DATABASE_URL'])
    uri = URI.parse(ENV['DATABASE_URL'])
    DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
  # --------------------------------------------------

  # else, use local psql db
  else
    DB = PG.connect(
      host: "localhost",
      port: 5432,
      dbname: 'posts')
  end

  def initialize(opts = {})
    @id = opts["id"].to_i
    @name = opts["name"]
    @date = opts["date"]
    @details = opts["details"]
    @image = opts["image"]
  end

   def self.all
      results = DB.exec("SELECT * FROM posts;")
      results.each do |result|
         {
            "id" => result["id"].to_i,
            "name" => result["name"],
            "date" => result["date"],
            "details" => result["details"],
            "image" => result["image"]
         }
      end
   end

   def self.find(id)
      results = DB.exec("SELECT * FROM posts WHERE id=#{id};")
      return {
         "id" => results.first["id"].to_i,
         "name" => results.first["name"],
         "date" => results.first["date"],
         "details" => results.first["details"],
         "image" => results.first["image"]
       }
   end

   def self.create(opts)
      results = DB.exec(
         <<-SQL
            INSERT INTO posts (name, date, details, image)
            VALUES ( '#{opts["name"]}', '#{opts["date"]}', '#{opts["details"]}', '#{opts["image"]}' )
            RETURNING id, name, date, details, image;
         SQL
      )
      return {
         "id" => results.first["id"].to_i,
         "name" => results.first["name"],
         "date" => results.first["date"],
         "details" => results.first["details"],
         "image" => results.first["image"]
      }
   end

   def self.delete(id)
      results = DB.exec("DELETE FROM posts WHERE id=#{id};")
      return { "deleted" => true }
   end

   def self.update(id, opts)
      results = DB.exec(
         <<-SQL
            INSERT INTO posts (name, date, details, image)
            VALUES ( '#{opts["name"]}', '#{opts["date"]}', '#{opts["details"]}', '#{opts["image"]}' )
            RETURNING id, name, date, details, image ;
         SQL
      )
      return {
         "id" => results.first["id"].to_i,
         "name" => results.first["name"],
         "date" => results.first["date"],
         "details" => results.first["details"],
         "image" => results.first["image"]
      }
   end
end
