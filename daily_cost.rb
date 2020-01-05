require 'date'

ALL_TIME_PERIODS = %w(daily weekly monthly).freeze

def daily_cost(start_date, end_date, time_period_costs)
  (start_date..end_date).map do |date|
    {
      date: date.strftime('%a, %d %b %Y'),
      cost:
        # Go through all the time period costs and add the cost
        time_period_costs.inject(0) do |acc, time_period_cost|
          raise ArgumentError, "Cost must be positive" unless time_period_cost[:cost] > 0
          acc +=
            case time_period_cost[:time_period]
              when 'daily' then time_period_cost[:cost]
              when 'weekly' then time_period_cost[:cost].to_f / 7
              when 'monthly' then time_period_cost[:cost].to_f / Date.new(start_date.year, start_date.month, -1).day
              else raise ArgumentError, "Unknown time period: #{time_period_cost[:time_period]}"
            end
        end
    }
  end
end
