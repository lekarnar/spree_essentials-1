class Spree::Upload < ::Spree::Asset

  # attr_accessible :attachment, :alt
  # we had to leave this here, because it was already here, and maybe
  # something is depending on this default scope
  # updated type: Upload to Spree::Upload
  default_scope {where(type: "Spree::Upload") if table_exists?}

  has_attached_file :attachment,
    :styles        => Proc.new{ |clip| clip.instance.attachment_sizes },
    :default_style => :medium,
    :url           => "/spree/uploads/:id/:style/:basename.:extension",
    :path          => ":rails_root/public/spree/uploads/:id/:style/:basename.:extension"

  validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  self.whitelisted_ransackable_attributes =  %w[alt]

  def image_content?
    attachment_content_type.match(/\/(jpeg|png|gif|tiff|x-photoshop)/)
  end

  def attachment_sizes
    if image_content?
      { :mini => '48x48>', :small => '150x150>', :medium => '420x300>', :large => '800x500>' }
    else
      {}
    end
  end

  def no_attachement_errors
    if attachment_file_name.blank? || !attachment.errors.empty?
      # uncomment this to get rid of the less-than-useful interrim messages
      errors.clear
      errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end

end
