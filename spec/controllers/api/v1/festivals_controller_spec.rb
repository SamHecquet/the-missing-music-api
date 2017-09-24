# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::FestivalsController, type: 'controller' do
  describe 'SlugGenerator function to_slug' do
    context 'when festival_name is standard ("toto")' do
      it 'return an array of 5 rewrited names' do
        toto = SlugGenerator.to_slug(
          'toto',
          year = Date.today.strftime('%Y').to_i
        )
        expect(toto).to be_an_instance_of(Array)
        expect(toto.count).to eq(5)
        expect(toto).to contain_exactly(
          'the-toto',
          "toto-#{year}",
          'toto',
          "the-toto-festival-#{year}",
          "toto-festival-#{year}"
        )
      end
    end
    context 'when festival_name has spaces ("toto tata")' do
      it 'return an array of 5 rewrited names' do
        toto = SlugGenerator.to_slug(
          'toto tata',
          year = Date.today.strftime('%Y').to_i
        )
        expect(toto).to be_an_instance_of(Array)
        expect(toto.count).to eq(5)
        expect(toto).to contain_exactly(
          'the-toto-tata',
          'toto-tata',
          "toto-tata-#{year}",
          "the-toto-tata-festival-#{year}",
          "toto-tata-festival-#{year}"
        )
      end
    end
    context 'when festival_name has Special characters ("T@o\'s táta")' do
      it 'return an array of 5 rewrited names' do
        toto = SlugGenerator.to_slug(
          'Tot@o\'s táta',
          year = Date.today.strftime('%Y').to_i
        )
        expect(toto).to be_an_instance_of(Array)
        expect(toto.count).to eq(5)
        expect(toto).to contain_exactly(
          'the-tot-os-t-ta',
          'tot-os-t-ta',
          "tot-os-t-ta-#{year}",
          "the-tot-os-t-ta-festival-#{year}",
          "tot-os-t-ta-festival-#{year}"
        )
      end
    end
  end
end
