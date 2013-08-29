class AddPolymorphismToImage < ActiveRecord::Migration

  def up
    old_imgs = Image.all.inject({}) {|memo,img| memo[img.id] = img.user_id; memo }

    remove_column :images, :user_id
    add_column :images, :imageable_id, :integer
    add_column :images, :imageable_type, :string

    Image.reset_column_information

    old_imgs.each do |id,user_id|
      next if user_id.blank?
        puts "updating image #{id} with User #{user_id}"
        Image.find(id).update_attributes(imageable_id: user_id, imageable_type: "User")
      end
  end

  def down
    add_column :images, :user_id, :integer
    remove_column :images, :imageable_id
    remove_column :images, :imageable_type
  end
end