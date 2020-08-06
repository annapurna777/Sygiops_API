module SygiopsSupport
  class Calendar < ApplicationRecord
    require 'biz'
    store :business_hours
    store :public_holidays

    def self.timezones
      list = {}
      TZInfo::Timezone.all_country_zone_identifiers.each do |timezone|
        t = TZInfo::Timezone.get(timezone)
        diff = t.current_period.utc_total_offset / 60 / 60
        list[ timezone ] = diff
      end
      list
    end


  def business_hours_to_hash
    hours = {}
    business_hours.each do |day, meta|
      next if !meta[:active]
      next if !meta[:timeframes]

      hours[day.to_sym] = {}
      meta[:timeframes].each do |frame|
        next if !frame[0]
        next if !frame[1]

        hours[day.to_sym][frame[0]] = frame[1]
      end
    end
    hours
  end

=begin

  calendar = Calendar.find(123)
  calendar.public_holidays_to_array

returns

  [
    Thu, 08 Mar 2020,
    Sun, 25 Mar 2020,
    Thu, 29 Mar 2020,
  ]

=end

  def public_holidays_to_array
    holidays = []
    public_holidays&.each do |day, meta|
      next if !meta
      next if !meta['active']
      next if meta['removed']

      holidays.push Date.parse(day)
    end
    holidays
  end

  def biz(time_zone)
    Biz::Schedule.new do |config|

      # get business hours
      hours = business_hours_to_hash
      raise "No configured hours found in calendar #{inspect}" if hours.blank?

      config.hours = hours

      # get holidays
      config.holidays = public_holidays_to_array
      config.time_zone = time_zone
    end
  end

  end
end
