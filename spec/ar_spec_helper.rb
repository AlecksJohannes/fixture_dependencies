require 'active_record'

ActiveRecord::Base.establish_connection(:adapter=>'sqlite3', :database=>File.join(File.dirname(File.expand_path(__FILE__)), 'db', 'fd_spec.sqlite3'))

class Artist < ActiveRecord::Base
  has_many :albums
end

class Album < ActiveRecord::Base
  belongs_to :artist
  has_and_belongs_to_many :tags
end

class Tag < ActiveRecord::Base
  if ActiveRecord.respond_to?(:version) # Rails 4+
    has_and_belongs_to_many :albums, proc{order('id DESC')}
  else
    has_and_belongs_to_many :albums, :order=>'id DESC'
  end
end

class SelfRef < ActiveRecord::Base
  belongs_to :self_ref
  has_many :self_refs
end
