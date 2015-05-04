# encoding: utf-8

#  Copyright (c) 2012-2013, Jungwacht Blauring Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

module Export::Csv::People
  # Attributes of a person, handles associations
  class PersonRow < Export::Csv::Row

    self.dynamic_attributes = { /^phone_number_/ => :phone_number_attribute,
                                /^social_account_/ => :social_account_attribute,
                                /^additional_email_/ => :additional_email_attribute,
                                /^people_relation_/ => :people_relation_attribute }

    def roles
      entry.roles.map { |role| "#{role} #{role.group.with_layer.join(' / ')}"  }.join(', ')
    end

    def bund

      Group.where(id: entry.roles.first.group_id).pluck(:name)
      #group = Group.where(id: entry.roles.first.group_id)
      #while group.pluck(:parent_id).nil?
      #  group = Group.where(parent_id: group.pluck(:parent_id))
      #end
    end

    def kanton
     arr =  person_groups_array
     puts arr.class
     puts arr.size
     puts ("B===============================================================D")
     arr.each { |a| puts a, " " }
    end

    def region

    end

    def abteilung
     # group = Group.where(id: entry.roles.first.group_id)
     # while group.pluck(:type).to_s.include?("Group::Abteilung")
     #   group = Group.where(parent_id: group.pluck(:parent_id))
     # end
    end

    def corps
     #Group.where(id: entry.roles.first.group_id).pluck(:name)
    end

    def person_groups_array
      role = entry.roles.first
      group = Group.where(id: role.group_id)
      persons_groups = Array.new(100)

      while group.pluck(:parent_id).nil? do
        persons_groups.push(group)
        group = Group.where(id: group.pluck(:parent_id))
      end

      persons_groups

      puts ("B==========================asd=====================================D")
      persons_groups.each { |a| puts a, " " }

    end




    def gender
      entry.gender_label
    end
    private

    def phone_number_attribute(attr)
      contact_account_attribute(entry.phone_numbers, attr)
    end

    def social_account_attribute(attr)
      contact_account_attribute(entry.social_accounts, attr)
    end

    def additional_email_attribute(attr)
      contact_account_attribute(entry.additional_emails, attr)
    end

    def people_relation_attribute(attr)
      entry.relations_to_tails.
            select { |r| :"people_relation_#{r.kind}" == attr }.
            map    { |r| r.tail.to_s }.
            join(', ')
    end

    def contact_account_attribute(accounts, attr)
      account = accounts.find { |e| ContactAccounts.key(e.class, e.translated_label) == attr }
      account.value if account
    end

  end
end
