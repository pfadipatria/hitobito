# encoding: utf-8

#  Copyright (c) 2012-2013, Jungwacht Blauring Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

require 'spec_helper'
require 'csv'

describe Export::Csv::People::PeopleFull do

  before do
    PeopleRelation.kind_opposites['parent'] = 'child'
    PeopleRelation.kind_opposites['child'] = 'parent'
  end

  after do
    PeopleRelation.kind_opposites.clear
  end

  let(:person) { people(:top_leader) }
  let(:list) { [person] }
  let(:people_list) { Export::Csv::People::PeopleFull.new(list) }

  subject { people_list }

  its(:attributes) do should eq [:first_name, :last_name, :company_name, :profession, :nickname, :company, :email, :address,
                                 :zip_code, :town, :country, :gender, :birthday, :additional_information, :roles] end

  context '#attribute_labels' do
    subject { people_list.attribute_labels }

    its([:roles]) { should eq 'Rollen' }
    its([:social_account_website]) { should be_blank }

    its([:company]) { should eq 'Firma' }
    its([:company_name]) { should eq 'Firmenname' }

    context 'social accounts' do
      before { person.social_accounts << SocialAccount.new(label: 'Webseite', name: 'foo.bar') }
      its([:social_account_webseite]) { should eq 'Social Media Adresse Webseite' }
    end

    context 'people relations' do
      before { person.relations_to_tails << PeopleRelation.new(head_id: person.id, tail_id: people(:bottom_member).id, kind: 'parent') }
      its([:people_relation_parent]) { should eq 'Elternteil' }
    end
  end

  context 'integration' do

    let(:full_headers) do
      ['Vorname', 'Nachname', 'Firmenname', 'Übername', 'Firma', 'Beruf', 'Haupt-E-Mail',
       'Adresse', 'PLZ', 'Ort', 'Land', 'Geschlecht', 'Geburtstag',
       'Zusätzliche Angaben', 'Rollen']
    end
    let(:data) { Export::Csv::People::PeopleFull.export(list) }
    let(:csv) { CSV.parse(data, headers: true, col_sep: Settings.csv.separator) }

    subject { csv }

    its(:headers) { should == full_headers }

    context 'first row' do
      before do
        person.update_attribute(:gender, 'm')
        person.social_accounts << SocialAccount.new(label: 'skype', name: 'foobar')
        person.phone_numbers << PhoneNumber.new(label: 'vater', number: 123, public: false)
        person.additional_emails << AdditionalEmail.new(label: 'vater', email: 'vater@example.com', public: false)
        person.relations_to_tails << PeopleRelation.new(tail_id: people(:bottom_member).id, kind: 'parent')
      end

      subject { csv[0] }

      its(['Rollen']) { should eq 'Leader Top / TopGroup' }
      its(['Telefonnummer Vater']) { should eq '123' }
      its(['Weitere E-Mail Vater']) { should eq 'vater@example.com' }
      its(['Social Media Adresse Skype']) { should eq 'foobar' }
      its(['Elternteil']) { should eq 'Bottom Member' }
      its(['Geschlecht']) { should eq 'm' }
    end

  end
end
