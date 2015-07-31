module ApplicationHelper
  def full_title page_title = ""
    base_title = t "static_page.fels"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for association, new_object, child_index: "new_#{association}" do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to name, "javascript:void(0);",
      data: {content: "#{escape_javascript(fields)}", association: "#{association}"},
      id: "add-answer-link", class: "btn btn-success"
  end
end
