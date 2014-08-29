module DirectoriesHelper
  def private_visibility_labeling(v)
    if v == true      
      t('activerecord.attributes.directory.private')
    else      
      t('activerecord.attributes.directory.public')
    end
  end
end
