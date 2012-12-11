# encoding:  utf-8

require 'spec_helper'

describe Event::Course::ConditionsController, type: :controller do


  let(:group) { groups(:ch) }
  let(:test_entry) { group.course_conditions.create!(label: 'foo', content: 'bar') }
  let(:test_entry_attrs) { { label: 'some label', content: 'some more content' }}
  let(:scope_params) {  { group_id: group.id } } 

  before do
    test_entry
    sign_in(people(:top_leader))
  end 

  class << self
    def it_should_redirect_to_show
      it { should redirect_to group_event_course_conditions_path(returning: true) } 
    end
  end


  include_examples 'crud controller', skip: [%w(update html invalid), %w(destroy html invalid)]

end
