module PaginationHelper
  PER_PAGE = 10

  def starting_business_number
    @page * PER_PAGE + 1
  end

  def last_business_number
    add_pages = @display_businesses.count < PER_PAGE ? @display_businesses.count : PER_PAGE
    @page * PER_PAGE + add_pages
  end

  def number_of_pages
    @number_of_pages ||= (@businesses.count / PER_PAGE.to_f).ceil
  end

  def list_number(idx)
    @page * PER_PAGE + idx + 1
  end

  def pagination_number(n)
    if @page < 4
      n + 1
    elsif @page > number_of_pages - 5
      number_of_pages - 8 + n
    else
      @page - 3 + n
    end
  end

  def visible_pagination_pages
    number_of_pages > 9 ? 9 : number_of_pages
  end

  def pagination_path(page)
    if @query
      request.fullpath.gsub(/&p=\d/, "") + "&p=#{page}"
    else
      businesses_path(p: page)
    end
  end

  def current_page_class(n)
    "current_page" if @page + 1 == pagination_number(n)
  end
end