ActiveAdmin.register Event do
  config.filters = false
  permit_params :name, :description, :photo, :date, :category_id
  
  index do
    column :id
    column :date
    column :category
    column :name
    column :photo do |ad|
      image_tag(ad.photo.url(:tiny_pic))
    end
    actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :date, :required => true
      f.input :category, :required => true
      f.input :name, :required => true
      f.input :description
      f.input :photo, :required => false, :as => :file
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :date
      row :category
      row :name
      row :description
      row :photo do
        image_tag(ad.photo.url(:thumb))
      end
    end
  end
  
end
