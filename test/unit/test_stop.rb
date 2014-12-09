require File.join(File.dirname(__FILE__), '..', 'helper')

class TestStop < Test::Unit::TestCase

  def setup
    @stop1 = Nextbus::Stop.new
  end

  def test_tag_attr
    assert_attr_accessor @stop1, :tag
  end
  def test_title_attr
    assert_attr_accessor @stop1, :title
  end
  def test_short_lat_attr
    assert_attr_accessor @stop1, :lat
  end
  def test_region_lon_attr
    assert_attr_accessor @stop1, :lon
  end
  def test_region_stop_id_attr
    assert_attr_accessor @stop1, :stop_id
  end

  def test_direction_attr
    assert_attr_accessor @stop1, :direction
  end
  def test_predictions_attr
    assert_attr_accessor @stop1, :predictions, []
  end

  def test_instantiated_with_attrs
    attrs = {:tag => 'my tag', :title => 'my title', :lat => 'my lat', :lon => 'my lon', :stop_id => 'my stop id'}
    assert_instantiated_with_attrs Nextbus::Stop, attrs
  end

  def test_all
    stop_tag1     = '14161'
    stop_tag2     = '4402'
    agency_id     = 'ttc'
    route_id      = '504'
    direction_id  = '504_1_504'
    expect_response('route_config.xml', /#{agency_id}.+#{route_id}/, Net::HTTP::Get)
    all = Nextbus::Stop.all(agency_id, route_id, direction_id)
    assert all.is_a?(Array)
    assert_equal 58, all.length
    assert all[0].is_a?(Nextbus::Stop)
    assert_equal stop_tag1, all[0].tag
    assert_equal stop_tag2, all[1].tag
  end

  def test_find
    stop_tag      = '14161'
    agency_id     = 'ttc'
    route_id      = '504'
    direction_id  = '504_1_504'
    stop_id       = '14639'     # n.b. in Toronto, stop_tag != stop_id
    expect_response('route_config.xml', /#{agency_id}.+#{route_id}/, Net::HTTP::Get)
    stop = Nextbus::Stop.find(agency_id, route_id, direction_id, stop_tag)
    assert stop.is_a?(Nextbus::Stop)
    assert_equal stop_id, stop.stop_id
  end

end
