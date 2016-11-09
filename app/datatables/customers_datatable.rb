class CustomersDatatable
  delegate :params, :link_to, :content_tag, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Customer.count,
      iTotalDisplayRecords: customers.total_entries,
      aaData: data
    }
  end

  private
    def data
      customers.map do |customer|
        [
          customer.name,
          customer.phone_number,
          customer.email,
          customer.address,
          link_to(content_tag(:i, " View", class: 'fa fa-eye'), customer, class: 'btn btn-info btn-xs')
        ]
      end
    end

    def customers
      @customers ||= fetch_customers
    end

    def fetch_customers
      customers = Customer.order("#{sort_column} #{sort_direction}")
      customers = customers.page(page).per_page(per_page)
      if params[:sSearch].present?
        customers = customer.where("name like :search or email like :search", search: "%#{params[:sSearch]}")
      end
      customers
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[id first_name date_of_an_customer deadline running_total status_type customer]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
end
