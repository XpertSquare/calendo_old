module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def parent_layout(layout)
    @view_flow.set(:layout,output_buffer)
    self.output_buffer = render(file: "layouts/#{layout}")
  end  
  
  def options_from_collection_for_select_with_attributes(collection, value_method, text_method, attr_name, attr_field, selected = nil)
    options = collection.map do |element|
      [element.send(text_method), element.send(value_method), attr_name => element.send(attr_field)]
    end
    
    selected, disabled = extract_selected_and_disabled(selected)
    select_deselect = {}
    select_deselect[:selected] = extract_values_from_collection(collection, value_method, selected)
    select_deselect[:disabled] = extract_values_from_collection(collection, value_method, disabled)
  
    options_for_select(options, select_deselect)
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def date_to_dd_MMM_yyyy(date)
    if date.nil?
      ""
    else
      date.strftime('%d-%b-%Y')      
    end
  end
  
end
