ActiveAdmin.register Category do
  config.filters = false

  permit_params :name, :photo
  
  index do
    column :id
    column :name
    column :photo do |ad|
      image_tag(ad.photo.url(:tiny_pic))
    end
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :photo, :required => false, :as => :file
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :photo do
        image_tag(ad.photo.url(:thumb))
      end
    end
  end

end
