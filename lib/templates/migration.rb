class Create<%= module_name %><%= plural_class %> < ActiveRecord::Migration
  def change
    create_table :<%= "#{namespace_underscore}_" if namespace_name %><%= plural_name %> do |t|  
      <%- model_attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
      <%- end -%>
      
      t.timestamps
    end
  end
end
