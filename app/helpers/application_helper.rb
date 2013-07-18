module ApplicationHelper
  def format_date(date, format='')
    # Date formats http://apidock.com/ruby/DateTime/strftime#864-Complete-Formatting-Codes
    case format.to_sym
    when :long
      format = '%e %B, %Y'      # 2 February, 2012
    when :short
      format = '%e %b %H:%M'    # 2 Feb, 18:30
    when :shortdate
      format = '%e %b %Y'       # 2 Feb 2012
    when :shortmonth
      format = '%b %Y'          # Feb 2012
    when :js, :db
      format = '%Y/%m/%d %H:%M' # 2012/02/28 18:30
    else
      format = '%d/%m/%Y'       # 28/02/2012
    end
    
    date.nil? ? '-' : date.strftime(format)
  end
end
