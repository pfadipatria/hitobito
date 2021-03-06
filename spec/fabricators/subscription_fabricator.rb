# encoding: utf-8

#  Copyright (c) 2012-2013, Jungwacht Blauring Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

# == Schema Information
#
# Table name: subscriptions
#
#  id              :integer          not null, primary key
#  mailing_list_id :integer          not null
#  subscriber_id   :integer          not null
#  subscriber_type :string(255)      not null
#  excluded        :boolean          default(FALSE), not null
#

Fabricator(:subscription) do
  subscriber { Fabricate(:person) }
end
