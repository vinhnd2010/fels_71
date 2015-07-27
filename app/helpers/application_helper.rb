module ApplicationHelper
  def full_title page_title = ""
    base_title = t("FELS")
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def add_lesson f, lessons
    new_object = f.object.class.reflect_on_association(lessons).klass.new
    fields = f.fields_for(lessons, new_object) do |builder|
      render "lesson_field", f: builder
    end
    link_to t("categories.NewLesson"), "javascript:void(0);", class: "btn btn-info button-click",
      data: {fields: "#{escape_javascript(fields)}"}
  end
end
