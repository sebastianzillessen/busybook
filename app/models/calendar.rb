class Calendar < ActiveRecord::Base
  belongs_to :user
  has_many :schedules, dependent: :destroy

  validates :uri, uniqueness: {scope: :user}


  def name
    props['displayname']
  end

  def color
    c= props['calendar-color']

    if (c.starts_with?("#"))
      return c[0..6]
    end
  end

  def color=(c)
    props['calendar-color'] = c
    props = props
  end


  def to_s
    name
  end

  def props
    props_json = self.props_json
    if props_json.length >= 2
      ActiveSupport::JSON.decode(props_json)
    else
      {}
    end
  end

  def props=(v)
    self.props_json = ActiveSupport::JSON.encode(v)
  end

  def self.find_by_name(name)
    self.all.find_each do |cal|
      if name == cal.name
        return cal
      end
    end

    nil
  end

  def self.find_by_not_name(name)
    self.all.find_each do |cal|
      if name != cal.name
        return cal
      end
    end

    nil
  end
end
