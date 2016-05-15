require_relative "../../lib/airplane"

describe Airplane do
  let(:my_plane) { Airplane.new("cesna", 10, 150) }


  describe "#initialization" do
    it 'should have a type' do
      expect(my_plane.type).to eq("cesna")
    end
    it 'should have a wing_loading' do
      expect(my_plane.wing_loading).to eq(10)
    end
    it 'should have a horsepower' do
      expect(my_plane.horse_power).to eq(150)
    end
    it 'should have its engine off' do
      expect(my_plane.engine).to eq(false)
    end
    it 'should not be flying to start' do
      expect(my_plane.flying).to eq(false)
    end
    it 'should have a full tank of fuel' do
      expect(my_plane.fuel).to eq(250)
    end
  end

  describe '#start' do
    context 'when the plane has not been started yet' do
      it 'should return airplane started when engine is not on' do
        expect(my_plane.start).to eq('airplane started')
      end
      it 'should change the state of engine_on to true'do
        my_plane.start
        expect(my_plane.engine).to eq(true)
      end
      it 'should use 10 gallons of fuel' do
        my_plane.start
        expect(my_plane.fuel).to eq(240)
      end
    end

    context 'when the plane has not been started yet' do
      it 'should return airplane already started when engine is already on' do
        my_plane.engine = true
        expect(my_plane.start).to eq('airplane already started')
      end
    end

    context 'when there is not enough fuel to start' do
      before do
        my_plane.fuel = 9
      end
      it 'should give a warning message' do
        expect(my_plane.start).to eq("not enough fuel to start engine, please refuel")
      end
      it 'should not start the engine' do
        my_plane.start
        expect(my_plane.engine).to eq(false)
      end
    end
  end

  describe "#takeoff" do
    context 'if the engine has not been started' do
      it 'should return a start engine message' do
        expect(my_plane.takeoff).to eq("airplane not started, please start")
      end
    end

    context 'if the engine has been started' do
      before do
        my_plane.start
      end
      it 'should return a launch message' do
        expect(my_plane.takeoff).to eq("airplane launched")
      end
      it 'should change the state of flying to true' do
        my_plane.takeoff
        expect(my_plane.flying).to eq(true)
      end
      it 'should consume 30 gallons of fuel' do
        my_plane.takeoff
        expect(my_plane.fuel).to eq(210)
      end
    end

    context 'not enough fuel to takeoff' do
      before do
        my_plane.fuel = 20
        my_plane.start
      end
      it 'should give a warning message' do
        expect(my_plane.takeoff).to eq("not enough fuel to takeoff")
      end
      it 'should not takeoff' do
        my_plane.takeoff
        expect(my_plane.flying).to eq(false)
      end
    end
  end

  describe "#land" do
    context 'if the engine is not yet on' do
      it 'should return a start engine message' do
        expect(my_plane.land).to eq("airplane not started, please start")
      end
    end

    context 'if the engine is on, but the plane is not flying' do
      it 'should a message already on the grounf' do
        my_plane.start
        expect(my_plane.land).to eq("airplane already on the ground")
      end
    end

    context 'if the plane is flying' do
      before do
        my_plane.start
        my_plane.takeoff
      end
      it 'should return a plane landed message' do
        expect(my_plane.land).to eq("airplane landed")
      end
      it 'should change the flying state to false' do
        my_plane.land
        expect(my_plane.flying).to eq(false)
      end
      it 'should consume 40 gallons of fuel' do
        my_plane.land
        expect(my_plane.fuel).to eq(170)
      end
    end

    context 'not enough fuel to land' do
      before do
        my_plane.fuel = 20
        my_plane.start
        my_plane.takeoff
      end
      it 'should give a warning message' do
        expect(my_plane.land).to eq("not enough fuel to land, hopfully you'll land on an island")
      end
      it 'should change the flying state to false' do
        my_plane.land
        expect(my_plane.flying).to eq(false)
      end
    end
  end

end
