module ApplicationHelper
  def list_number(idx)
    @page * 10 + idx + 1
  end

  def pagination_number(n)
    @page < 4 ? n + 1 : @page - 3 + n
  end

  def pagination_pages(businesses)
    total_pages = businesses.count / 10
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
