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
      arr =  person_groups_array

      if arr.size >= 1
        arr[(arr.size - 1)].pluck(:name)
      end
    end

    def kanton
      arr =  person_groups_array

      if arr.size > 1
        arr[(arr.size - 2)].pluck(:name)
      end
    end

    def region
      arr =  person_groups_array

      if arr.size > 2
        arr[(arr.size - 3)].pluck(:name)
      end
    end

    def abteilung
      arr =  person_groups_array

      if arr.size > 3
        arr[(arr.size - 4)].pluck(:name)
      end
    end

    def corps
      arr =  person_groups_array

      if arr.size > 4
        arr[(arr.size - 5)].pluck(:name)
      end
    end

    def person_groups_array
      role = entry.roles.first
      group = Group.where(id: role.group_id)
      persons_groups = Array.new()

      while not group.class.nil?
        persons_groups.push(group)
        if (group.pluck(:type).to_s.include?("Group::Bund"))
          break
        end
      end

      persons_groups.compact

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
