require 'rails_helper'

describe Api::V1::FestivalsController, type: 'controller' do
  describe 'private function to_slug' do
    context 'when festival_name is standard ("toto")' do
      it 'return an array of 5 rewrited names' do
        toto = controller.send(:to_slug, 'toto', Date.today.strftime('%Y'))
        expect(toto).to be_an_instance_of(Array)
        expect(toto.count).to eq(5)
        expect(toto).to contain_exactly(
          'the-toto',
          "toto-#{Date.today.strftime('%Y')}",
          'toto',
          "the-toto-festival-#{Date.today.strftime('%Y')}",
          "toto-festival-#{Date.today.strftime('%Y')}"
        )
      end
    end
    context 'when festival_name has spaces ("toto tata")' do
      it 'return an array of 5 rewrited names' do
        toto = controller.send(:to_slug, 'toto tata', Date.today.strftime('%Y'))
        expect(toto).to be_an_instance_of(Array)
        expect(toto.count).to eq(5)
        expect(toto).to contain_exactly(
          'the-toto-tata',
          'toto-tata',
          "toto-tata-#{Date.today.strftime('%Y')}",
          "the-toto-tata-festival-#{Date.today.strftime('%Y')}",
          "toto-tata-festival-#{Date.today.strftime('%Y')}"
        )
      end
    end
    context 'when festival_name has Special characters ("T@o\'s táta")' do
      it 'return an array of 5 rewrited names' do
        toto = controller.send(
          :to_slug,
          'Tot@o\'s táta',
          Date.today.strftime('%Y')
        )
        expect(toto).to be_an_instance_of(Array)
        expect(toto.count).to eq(5)
        expect(toto).to contain_exactly(
          'the-tot-os-t-ta',
          'tot-os-t-ta',
          "tot-os-t-ta-#{Date.today.strftime('%Y')}",
          "the-tot-os-t-ta-festival-#{Date.today.strftime('%Y')}",
          "tot-os-t-ta-festival-#{Date.today.strftime('%Y')}"
        )
      end
    end
  end
end
