class Report < ActiveRecord::Base
  include Filterable
  before_save :downcase_fields
  # associations
  has_many :comments
  belongs_to :user
  acts_as_mappable default_units: :miles,
                   default_formula: :sphere,
                   distance_field_name: :distance,
                   lat_column_name: :lat,
                   lng_column_name: :lng
  # validations
  # validates :user_id, presence: true

  # Scopes for Report filtering -> see Filterable module
  scope :report_type, -> (report_type) { where report_type: report_type }
  scope :animal_type, -> (animal_type) { where animal_type: animal_type }
  scope :sex, -> (sex) { where sex: sex }
  scope :pet_size, -> (pet_size) { where pet_size: pet_size }
  scope :age, -> (age) { where age: age }
  scope :breed, -> (breed) { where breed: breed }
  scope :color, -> (color) { where color: color }

  # Add report creator's username to json output
  # Todo look at ActiveModel Serializers to improve this
  def as_json options={}
    # attributes.merge({report_username: user.username, report_taggings: self.all_tags_string}).as_json
    attributes.merge({report_username: user.username}).as_json

  end

  private
  def downcase_fields
    self.breed.downcase! unless self.breed == ""
    self.color.downcase! unless self.color == ""
  end
end
