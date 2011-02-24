<%= form_tag("/search") do %>
  
  <%= text_field_tag 'query' %>
  
  <%= hidden_field_tag 'model', model %>

  <%= submit_tag 'Search' %>

<% end %>

