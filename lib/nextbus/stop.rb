module Nextbus
  class Stop

    include InstantiateWithAttrs
    include AttrWithDefault

    # n.b. `tag` is the canonical ID for searching/uniqueness via NextBus.
    # `stop_id` is the TTC-authoritative stop number, but treated only as 'extra data' by this program.
    attr_accessor :tag, :title, :lat, :lon, :stop_id, :direction, :predictions => []

    def self.all(agency_id, route_id, direction_id)
      Nextbus.client.stops(agency_id, route_id, direction_id).map{|stop| new(stop) }
    end

    def self.find(agency_id, route_id, direction_id, stop_tag)
      all(agency_id, route_id, direction_id).detect{|stop| stop.tag == stop_tag }
    end

  end
end