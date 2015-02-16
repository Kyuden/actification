<% module_namespacing do -%>
class <%= class_name %>Actification < Actification::Base
<% method_names.each do |name| -%>

  def <%= name %>
  end
<% end -%>
end
<% end -%>
