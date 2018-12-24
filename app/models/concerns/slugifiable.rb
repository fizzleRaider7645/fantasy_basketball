module Slugifiable
  module Instance
    def slug
      self.name.downcase.split(" ").join("-")
    end
  end
   module Class
     def self.find_by_slug(slug)
       name = slug.split("-").map { |name_part| name_part.capitalize }.join(" ")
       @object = self.find_by_name(name)
     end
  end
end
