module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def parent_layout(layout)
    @view_flow.set(:layout,output_buffer)
    self.output_buffer = render(file: "layouts/#{layout}")
  end  
end
