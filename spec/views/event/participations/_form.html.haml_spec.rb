# encoding: utf-8

#  Copyright (c) 2012-2013, Jungwacht Blauring Schweiz. This file is part of
#  hitobito and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito.

require 'spec_helper'

describe 'event/participations/_form.html.haml' do

  let(:participant) { people(:top_leader) }
  let(:participation) { Fabricate(:event_participation, person: participant, event: event) }
  let(:user) { participant }
  let(:event) { events(:top_event) }
  let(:group) { event.groups.first }
  let(:question) { event_questions(:top_ov) }
  let(:dom) { Capybara::Node::Simple.new(rendered) }
  let(:answer_text) { nil }

  before do
    question.update_attribute(:multiple_choices, true)
    event.questions << question
    answer = participation.answers.build
    answer.question = question
    answer.answer = answer_text

    decorated = Event::ParticipationDecorator.new(participation)

    view.stub(path_args: [group, event, decorated])
    view.stub(entry: decorated)
    view.stub(model_class: Event::Participation)
    view.stub(:current_user) { user }

    controller.stub(current_user: user)
    assign(:event, event)
    assign(:group, group)
  end

  context 'checkboxes' do
    let(:ga) { dom.find_field('GA') }
    let(:halbtax) { dom.find_field('Halbtax') }

    context 'unchecked' do

      shared_examples 'unchecked_multichoice_checkbox' do
        before { render }

        it { should_not be_checked }
        its([:name]) { should eq 'event_participation[answers_attributes][0][answer][]' }
        its([:type]) { should eq 'checkbox' }
        its([:value]) { should eq value }
      end

      describe 'Choice GA' do
        subject { ga }
        let(:value) { '1' }

        it_behaves_like 'unchecked_multichoice_checkbox'
      end

      describe 'Choice Halbtax' do
        subject { halbtax }
        let(:value) { '2' }

        it_behaves_like 'unchecked_multichoice_checkbox'
      end
    end

    describe 'Halbtax checked' do
      let(:answer_text) { 'Halbtax' }
      before { render }

      it { ga.should_not be_checked }
      it { halbtax.should be_checked }
    end


    describe 'GA, Halbtax checked' do
      let(:answer_text) { 'GA, Halbtax' }
      before { render }

      it { ga.should be_checked }
      it { halbtax.should be_checked }
    end
  end

end
