# Fix the issue between webrat 0.7.3 using "example.org" and rails 3.x using "example.com"
Webrat::Session.class_eval do
    def current_host
        URI.parse(current_url).host || @custom_headers["Host"] || default_current_host
    end

    def default_current_host
        adapter.class == Webrat::RackAdapter ? "example.org" : "www.example.com"
    end
end