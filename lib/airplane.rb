class Airplane
  attr_accessor :type, :wing_loading, :horse_power, :engine, :flying, :fuel

  def initialize(type,wing_loading,horse_power)
    @type = type
    @wing_loading = wing_loading
    @horse_power = horse_power
    @fuel = 250
    @engine = false
    @flying = false
  end

  def start
    if fuel >= 10
      if @engine == true
        "airplane already started"
      else
        @engine = true
        @fuel -= 10
        "airplane started"
      end
    else
      @engine = false
      "not enough fuel to start engine, please refuel"
    end
  end

  def takeoff
    if fuel >= 30
      if @engine == false
        @flying = true
        "airplane not started, please start"
      else
        @flying = true
        @fuel -= 30
        "airplane launched"
      end
    else
      @engine = false
      @flying = false
      "not enough fuel to takeoff"
    end
  end

  def land
    if fuel >= 30
      if @engine == false
        "airplane not started, please start"
      elsif @engine == true && @flying == false
        "airplane already on the ground"
      else
        @flying = false
        @fuel -= 40
        "airplane landed"
      end
    else
      @engine = false
      @flying = false
      "not enough fuel to land, hopfully you'll land on an island"
    end
  end
end
