require Rails.root.join("spec/support/group/bottom_group.rb")

class Group::BottomLayer < Group
  
  self.layer = true
  children Group::BottomGroup


  class Leader < ::Role
    self.permissions = [:layer_full, :contact_data, :login]
  end
  
  class Member < ::Role
    self.permissions = [:layer_read, :login]
  end
  
  class External < ::Role
    self.visible_from_above = false
    self.external = true
  end
  
  roles Leader, Member
  
end
