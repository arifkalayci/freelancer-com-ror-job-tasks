#!/usr/bin/env ruby

require "test/unit"
require_relative './daily_cost'

class DailyCostTest < Test::Unit::TestCase
  def test_example
    start_date = Date.new(2019, 10, 1)
    end_date = Date.new(2019, 10, 3)

    time_period_costs = [
      {
        time_period: ALL_TIME_PERIODS[0], # daily
        cost: 10.0
      },
      {
        time_period: ALL_TIME_PERIODS[1], # weekly
        cost: 70.0
      }
    ]

    assert_equal daily_cost(start_date, end_date, time_period_costs),
      [
        {date: 'Tue, 01 Oct 2019', cost: 20.0},
        {date: 'Wed, 02 Oct 2019', cost: 20.0},
        {date: 'Thu, 03 Oct 2019', cost: 20.0}
      ]
  end

  def test_single_period
    start_date = Date.new(2019, 10, 1)
    end_date = Date.new(2019, 10, 3)

    time_period_costs = [
      {
        time_period: ALL_TIME_PERIODS[0], # daily
        cost: 10.0
      }
    ]

    assert_equal daily_cost(start_date, end_date, time_period_costs),
      [
        {date: 'Tue, 01 Oct 2019', cost: 10.0},
        {date: 'Wed, 02 Oct 2019', cost: 10.0},
        {date: 'Thu, 03 Oct 2019', cost: 10.0}
      ]
  end

  def test_multiple_periods
    start_date = Date.new(2019, 10, 1)
    end_date = Date.new(2019, 10, 3)

    time_period_costs = [
      {
        time_period: ALL_TIME_PERIODS[0], # daily
        cost: 10.0
      },
      {
        time_period: ALL_TIME_PERIODS[1], # daily
        cost: 70.0
      },
      {
        time_period: ALL_TIME_PERIODS[2], # monthly
        cost: 310.0
      }
    ]

    assert_equal daily_cost(start_date, end_date, time_period_costs),
      [
        {date: 'Tue, 01 Oct 2019', cost: 30.0},
        {date: 'Wed, 02 Oct 2019', cost: 30.0},
        {date: 'Thu, 03 Oct 2019', cost: 30.0}
      ]
  end

  def test_duplicate_multiple_periods
    start_date = Date.new(2019, 10, 1)
    end_date = Date.new(2019, 10, 3)

    time_period_costs = [
      {
        time_period: ALL_TIME_PERIODS[0], # daily
        cost: 10.0
      },
      {
        time_period: ALL_TIME_PERIODS[0], # daily
        cost: 25.0
      },
      {
        time_period: ALL_TIME_PERIODS[1], # daily
        cost: 70.0
      },
      {
        time_period: ALL_TIME_PERIODS[2], # monthly
        cost: 310.0
      }
    ]

    assert_equal daily_cost(start_date, end_date, time_period_costs),
      [
        {date: 'Tue, 01 Oct 2019', cost: 55.0},
        {date: 'Wed, 02 Oct 2019', cost: 55.0},
        {date: 'Thu, 03 Oct 2019', cost: 55.0}
      ]
  end

  def test_error_raised_on_wrong_time_period
    start_date = Date.new(2019, 10, 1)
    end_date = Date.new(2019, 10, 3)

    time_period_costs = [
      {
        time_period: 'yearly',
        cost: 10.0
      }
    ]

    assert_raise ArgumentError do
      daily_cost(start_date, end_date, time_period_costs)
    end
  end

  def test_error_raised_on_wrong_time_period
    start_date = Date.new(2019, 10, 1)
    end_date = Date.new(2019, 10, 3)

    time_period_costs = [
      {
        time_period: 'daily',
        cost: 0
      }
    ]

    assert_raise ArgumentError do
      daily_cost(start_date, end_date, time_period_costs)
    end
  end
end
