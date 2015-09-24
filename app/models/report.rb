class Report < ActiveRecord::Base
  include Filterable
  # associations
  has_many :report_tags
  has_many :tags, through: :report_tags
  has_many :comments
  belongs_to :user
  acts_as_mappable default_units: :miles,
                   default_formula: :sphere,
                   distance_field_name: :distance,
                   lat_column_name: :lat,
                   lng_column_name: :lng
  # validations
  # validates :user_id, presence: true

  # tagging methods
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags
  end

  # Add report creator's username to json output
  def as_json options={}
    attributes.merge({report_username: user.username}).as_json
  end

  # Scopes for Report filtering -> see Filterable module
  scope :report_type, -> (report_type) { where report_type: report_type }
  scope :pet_type, -> (pet_type) { where pet_type: pet_type }
  scope :sex, -> (sex) { where sex: sex }
  scope :size, -> (size) { where size: size }
  scope :age, -> (age) { where age: age }
  scope :breed, -> (breed) { where breed: breed }

end
