ActiveAdmin.register Event do
  config.filters = false
  permit_params :name, :description, :photo, :created_by_id, :date, :end_date, :category_id, :active, :address, :postcode, :city, :featured, :test
  
  index do
    column :id
    column :date
    column :end_date
    column :category
    column :name
    column :address
    column :city
    column :active
    column :for_sale
    column :featured
    column :photo do |ad|
      image_tag(ad.photo.url(:tiny_pic))
    end
    actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :test
      f.input :date, :required => true
      f.input :end_date
      f.input :category, :required => true
      f.input :name, :required => true
      f.input :address
      f.input :postcode
      f.input :city
      f.input :active, :required => true
      f.input :featured, :required => true
      f.input :description
      f.input :photo, :required => false, :as => :file
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :test
      row :created_by
      row :date
      row :end_date
      row :category
      row :name
      row :description
      row :address
      row :postcode
      row :city
      row :active
      row :featured
      row :photo do
        image_tag(ad.photo.url(:thumb))
      end
    end
  end
  
end
