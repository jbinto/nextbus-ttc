require File.join(File.dirname(__FILE__), '..', 'helper')

class TestClient < Test::Unit::TestCase

  def setup
    super
    @client = Nextbus::Client.instance
  end

  def test_client
    assert_equal @client, Nextbus.client
  end

  def test_agencies
    agency_title1 = 'AC Transit'
    agency_title2 = 'APL'
    expect_response('agency_list.xml', nil, Net::HTTP::Get)
    agencies = @client.agencies
    assert agencies.is_a?(Array)
    assert agencies.detect{|agency| agency.title == agency_title1 }
    assert agencies.detect{|agency| agency.title == agency_title2 }
    assert_equal 65, agencies.length
  end

  def test_routes
    route_title1 = '1S-Yonge Subway Shuttle'
    route_title2 = '5-Avenue Rd'
    agency_id    = 'ttc'
    expect_response('route_list.xml', /#{agency_id}/, Net::HTTP::Get)
    routes = @client.routes(agency_id)
    assert routes.is_a?(Array)
    assert routes.detect{|route| route.title == route_title1 }
    assert routes.detect{|route| route.title == route_title2 }
    assert_equal 179, routes.length
  end

  def test_route
    route_title = '504-King'
    stop_tag1   = '14186'
    stop_tag2   = '1115'
    agency_id   = 'ttc'
    route_id    = '504'
    expect_response('route_config.xml', /#{agency_id}.+#{route_id}/, Net::HTTP::Get)
    route = @client.route(agency_id, route_id)
    assert route.is_a?(Hashie::Mash)
    assert_equal route_title, route.title
    assert_equal stop_tag1, route.stop[0].tag
    assert_equal stop_tag2, route.stop[1].tag
  end

  def test_predictions
    vehicle_id1 = '1041'
    vehicle_id2 = '1022'
    agency_id   = 'abc'
    route_id    = '123'
    stop_id     = '456'
    expect_response('predictions.xml', /#{agency_id}.+#{route_id}.+#{stop_id}/, Net::HTTP::Get)
    predictions = @client.predictions(agency_id, route_id, stop_id)
    assert predictions.is_a?(Array)
    assert_equal vehicle_id1, predictions[0].vehicle
    assert_equal vehicle_id2, predictions[1].vehicle
    assert_equal 5, predictions.length
  end

  def test_vehicles
    vehicle_heading1 = '265'
    vehicle_heading2 = '227'
    agency_id        = 'abc'
    route_id         = '123'
    time             = Time.parse('2010/01/31 12:30:00EDT')
    epoch_time       = time.to_i.to_s
    expect_response('vehicle_locations.xml', /#{agency_id}.+#{route_id}.+#{epoch_time}/, Net::HTTP::Get)
    vehicles = @client.vehicles(agency_id, route_id, time)
    assert vehicles.is_a?(Array)
    assert_equal vehicle_heading1, vehicles[0].heading
    assert_equal vehicle_heading2, vehicles[1].heading
    assert_equal 7, vehicles.length
  end

  def test_directions
    direction_title1 = 'West - 504 King towards Dundas West Station via King'
    direction_title2 = 'East - 504 King towards Broadview Station via King'
    agency_id        = 'abc'
    route_id         = '123'
    expect_response('route_config.xml', /#{agency_id}.+#{route_id}/, Net::HTTP::Get)
    directions = @client.directions(agency_id, route_id)
    assert directions.is_a?(Array)
    assert_equal direction_title1, directions[0].title
    assert_equal direction_title2, directions[1].title
    assert_equal 3, directions.length
  end

  def test_stops
    # FIXME BOSTON TORONTO
    stop_tag1     = '14186'
    stop_tag2     = '1115'
    agency_id     = 'ttc'
    route_id      = '504'
    direction_id  = '504_0_504Sun'
    expect_response('route_config.xml', /#{agency_id}.+#{route_id}/, Net::HTTP::Get)
    stops = @client.stops(agency_id, route_id, direction_id)
    assert stops.is_a?(Array)
    assert_equal stop_tag1, stops[0].tag
    assert_equal stop_tag2, stops[1].tag
    assert_equal 58, stops.length
  end

end
