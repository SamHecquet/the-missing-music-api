require 'rails_helper'


RSpec.describe Api::V1::FestivalsController, :type => :controller do
  describe 'GET #show' do
    context 'when festival_name is not a known festival' do
      it 'return an empty array as a response' do
        # expect{get :show, params: { festival_name: 'Festival inconnu' }}.to raise_error(ActionController::RoutingError)
        get :show, params: { festival_name: 'Festival inconnu' }, :format => :json
        expect(response).to be_success
        expect(JSON.parse(response.body)).to be_an_instance_of(Array)
        expect(JSON.parse(response.body)).to be_empty
      end
    end
  end
  
  describe 'private function to_slug' do
    context 'when festival_name is standard ("toto")' do
      it 'return an array of 5 rewrited names' do
        toto = controller.send(:to_slug, 'toto', Date.today.strftime("%Y"))
        expect(toto).to be_an_instance_of(Array)
        expect(toto.count).to eq(5)
        expect(toto).to contain_exactly(
          'the-toto',
          "toto-#{Date.today.strftime("%Y")}",
          'toto',
          "the-toto-festival-#{Date.today.strftime("%Y")}",
          "toto-festival-#{Date.today.strftime("%Y")}"
        )
      end
    end
    context 'when festival_name has spaces ("toto tata")' do
      it 'return an array of 4 rewrited names' do
        toto = controller.send(:to_slug, 'toto tata', Date.today.strftime("%Y"))
        expect(toto).to be_an_instance_of(Array)
        expect(toto.count).to eq(5)
        expect(toto).to contain_exactly(
          'the-toto-tata',
          'toto-tata',
          "toto-tata-#{Date.today.strftime("%Y")}",
          "the-toto-tata-festival-#{Date.today.strftime("%Y")}",
          "toto-tata-festival-#{Date.today.strftime("%Y")}",
        )
      end
    end
    context 'when festival_name has Special characters ("T@o\'s táta")' do
      it 'return an array of 5 rewrited names' do
        toto = controller.send(:to_slug, 'Tot@o\'s táta', Date.today.strftime("%Y"))
        expect(toto).to be_an_instance_of(Array)
        expect(toto.count).to eq(5)
        expect(toto).to contain_exactly(
          'the-tot-os-t-ta',
          'tot-os-t-ta',
          "tot-os-t-ta-#{Date.today.strftime("%Y")}",
          "the-tot-os-t-ta-festival-#{Date.today.strftime("%Y")}",
          "tot-os-t-ta-festival-#{Date.today.strftime("%Y")}",
        )
      end
    end
  end
end