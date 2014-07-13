ActiveAdmin.register Event do
  config.filters = false
  permit_params :name, :description, :photo, :category_id
  
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :category
      f.input :photo, :required => false, :as => :file
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :description
      row :category
      row :photo do
        image_tag(ad.photo.url(:thumb))
      end
    end
  end
  
end
