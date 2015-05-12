
# encoding: utf-8

#  Copyright (c) 2012-2013, Jungwacht Blauring Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

module Export::Csv::People
  class NoActiveRole < PeopleAddress
    def person_attributes
      Person.column_names.collect(&:to_sym) -
        Person::INTERNAL_ATTRS -
        [:picture, :primary_group_id]
    end
  end
end
