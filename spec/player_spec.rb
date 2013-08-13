require 'spec_helper'
require 'nokogiri'

describe Zamboni::Player do
  describe 'initialize player' do
    let(:player_id) {'1223'}
    let(:player) { Zamboni::Player.new(id: player_id) }

    it 'should match the id given' do
      player.id.should eq(player_id)
    end
  end

  describe 'GET player' do
    let(:player) { Zamboni::Player.new(id: '1223') }
    before do
      VCR.insert_cassette 'player', record: :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "must have a stats method" do
      player.should respond_to(:stats)
    end

    it "should scrape the player page" do
    end
  end
end