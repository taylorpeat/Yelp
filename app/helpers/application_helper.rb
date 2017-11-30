module ApplicationHelper
  def list_number(idx)
    @page * 10 + idx + 1
  end

  def pagination_number(n)
    @page < 4 ? n + 1 : @page - 3 + n
  end

  def current_page_class(n)
    "current_page" if @page + 1 == pagination_number(n)
  end
end
