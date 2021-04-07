# frozen_string_literal: true

module StreamdeckProf
  module DeviceData
    XL = {
      device_model: "20GAT9901",
      dimensions: { x: 8, y: 4 }.freeze,
      empty_profile: { "Actions": {}, "DeviceModel": "20GAT9901", "Name": "New Profile", "Version": "1.0" }.freeze
    }.freeze

    CLASSIC = {
      device_model: "20GAA9901",
      dimensions: { x: 5, y: 3 }.freeze,
      empty_profile: { "Actions": {}, "DeviceModel": "20GAA9901", "Name": "New Profile", "Version": "1.0" }.freeze
    }.freeze

    MINI = {
      device_model: "20GAI9901",
      dimensions: { x: 3, y: 2 }.freeze,
      empty_profile: { "Actions": {}, "DeviceModel": "20GAI9901", "Name": "New Profile", "Version": "1.0" }.freeze
    }.freeze

    MOBILE = {
      device_model: "VSD/WiFi",
      dimensions: { x: 5, y: 3 }.freeze,
      empty_profile: { "Actions": {}, "DeviceModel": "VSD/WiFi", "Name": "New Profile", "Version": "1.0" }.freeze
    }.freeze
  end
end