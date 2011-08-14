<%- if namespace_name -%>
module <%= module_name %>
<%- end -%>
class <%= class_name %> < ActiveRecord::Base

end
<%- if namespace_name -%>
end
<%- end -%>
