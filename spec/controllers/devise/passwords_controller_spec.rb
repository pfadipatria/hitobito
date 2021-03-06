# encoding: utf-8

#  Copyright (c) 2012-2013, Jungwacht Blauring Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

require 'spec_helper'

describe Devise::PasswordsController do
  let(:bottom_group) { groups(:bottom_group_one_one) }

  before do
    request.env['devise.mapping'] = Devise.mappings[:person]
    ActionMailer::Base.deliveries = []
  end

  describe '#create' do
    it '#create with invalid email invalid password' do
      post :create, person: { email: 'asdf' }
      last_email.should_not be_present
      controller.resource.errors[:email].should eq ['nicht gefunden']
    end

    context 'with login permission' do
      let(:person) { Fabricate('Group::BottomGroup::Leader', group: bottom_group).person.reload }

      it '#create shows invalid password' do
        post :create, person: { email: person.email }
        flash[:notice].should eq 'Du erhältst in wenigen Minuten eine E-Mail mit der Anleitung, wie Du Dein Passwort zurücksetzen kannst.'
        last_email.should be_present
      end
    end

    context 'without login permission' do
      it '#create shows invalid password' do
        post :create, person: { email: 'not-existing@example.com' }
        last_email.should_not be_present
        flash[:alert].should eq  'Du bist nicht berechtigt, Dich hier anzumelden.'
      end
    end

    def last_email
      ActionMailer::Base.deliveries.last
    end
  end

end
