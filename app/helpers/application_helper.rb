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

  def template_to_add_fields(f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    content_tag(:div, "", class: "fields_template", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
