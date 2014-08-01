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
end
