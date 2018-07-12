class Purse
  def initialize
    @values = {
      1 => "$100",
      2 => "$200",
      3 => "$300",
      4 => "$500",
      5 => "$1,000",
      6 => "$2,000",
      7 => "$4,000",
      8 => "$8,000",
      9 => "$16,000",
      10 => "$32,000",
      11 => "$64,000",
      12 => "$125,000",
      13 => "$250,000",
      14 => "$500,000",
      15 => "$1,000,000"
    }
    @round = 0
  end

  def get_value
    @values[@round]
  end

  def increment
    @round += 1
  end

  def get_tier_value
    if @round >= 10
      @tier_value = "$32,000"
    elsif @round >= 5
      @tier_value = "$1,000"
    else 
      @tier_value = "$0"
    end
    return @tier_value
  end

end