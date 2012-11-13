require 'spec_helper'

describe CensusesController, type: :controller do
    
  render_views
  
  class << self
    def it_should_redirect_to_show
      it { should redirect_to census_federation_group_path(Group.root) } 
    end
  end

  let(:test_entry) { censuses(:two_o_12) }
  let(:test_entry_attrs) { { year: 2013, start_at: Date.new(2013, 8), finish_at: Date.new(2013, 10, 31) }}

  before { sign_in(people(:top_leader)) } 

  include_examples 'crud controller', skip: [%w(index), %w(show), %w(edit), %w(update), %w(destroy)]

  
end