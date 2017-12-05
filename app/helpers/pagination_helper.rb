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
    @businesses.count / 10 + 1
  end

  def list_number(idx)
    @page * PER_PAGE + idx + 1
  end

  def pagination_number(n)
    @page < 4 ? n + 1 : @page - 3 + n
  end

  def pagination_pages
    total_pages = @businesses.count / PER_PAGE
    total_pages > 9 ? 9 : total_pages + 1
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