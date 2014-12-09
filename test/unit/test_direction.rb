require File.join(File.dirname(__FILE__), '..', 'helper')

class TestDirection < Test::Unit::TestCase

  def setup
    @direction1 = Nextbus::Direction.new
  end

  def test_tag_attr
    assert_attr_accessor @direction1, :tag
  end
  def test_title_attr
    assert_attr_accessor @direction1, :title
  end
  def test_name_attr
    assert_attr_accessor @direction1, :name
  end

  def test_reports_attr
    assert_attr_accessor @direction1, :reports, []
  end
  def test_stops_attr
    assert_attr_accessor @direction1, :stops, []
  end
  def test_route_attr
    assert_attr_accessor @direction1, :route
  end

  def test_instantiated_with_attrs
    attrs = {:tag => 'my tag', :title => 'my title', :name => 'my name'}
    assert_instantiated_with_attrs Nextbus::Direction, attrs
  end

  def test_all
    direction_title1 = 'West - 504 King towards Dundas West Station via King'
    direction_title2 = 'East - 504 King towards Broadview Station via King'
    agency_id        = 'ttc'
    route_id         = '504'
    expect_response('route_config.xml', /#{agency_id}.+#{route_id}/, Net::HTTP::Get)
    all = Nextbus::Direction.all(agency_id, route_id)
    assert all.is_a?(Array)
    assert_equal 3, all.length
    assert all[0].is_a?(Nextbus::Direction)
    assert_equal direction_title1, all[0].title
    assert_equal direction_title2, all[1].title
  end

  def test_find
    direction_title = 'East - 504 King towards Broadview Station via King'
    agency_id       = 'ttc'
    route_id        = '504'
    direction_id    = '504_0_504Sun'
    expect_response('route_config.xml', /#{agency_id}.+#{route_id}/, Net::HTTP::Get)
    direction = Nextbus::Direction.find(agency_id, route_id, direction_id)
    assert direction.is_a?(Nextbus::Direction)
    assert_equal direction_title, direction.title
  end

end
