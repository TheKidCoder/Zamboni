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

    it "must have a info method" do
      player.should respond_to(:stats)
    end

    it "should have Pasha the player info" do
      pashca_info = {"name"=>"Pavel Datsyuk", "team"=>"Detroit Red Wings", "height_weight"=>"5' 11\", 194 lbs", "born"=>"Jul 19, 1978 in Sverdlovsk, USSR", "age"=>"34", "drafted"=>"1998: 6th Rnd, 171st by DET", "experience"=>"12 years"}
      player.info.should eq(pashca_info)
    end

    it "should match the keys from the YAML config" do
      player_keys = YAML.load_file(File.dirname(__FILE__) + "/../lib/Zamboni/scrape_paths/player.yml")['player_info'].keys
      player.info.keys.should eq(player_keys)
    end
  end
end