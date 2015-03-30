# encoding: utf-8

#  Copyright (c) 2012-2013, Jungwacht Blauring Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

ThinkingSphinx::Index.define_partial :person do
  #fields
  #indexes company_name, profession, company, :sortable => true
  #indexes address, zip_code, town, country, birthday, :sortable => true
  indexes first_name, :sortable => true
  indexes last_name, :sortable =>true


  #attributes
  #has first_name, last_name, nickname, email

#  indexes phone_numbers.number, as: :phone_number
#  indexes social_accounts.name, as: :social_account
#  indexes additional_emails.email, as: :additional_email
end
