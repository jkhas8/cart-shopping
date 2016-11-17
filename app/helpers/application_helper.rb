module ApplicationHelper
  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) +
      link_to_function(name, "remove_fields(this)", class: "btn btn-danger btn-sm")
  end

  def link_to_function(name, *args, &block)
    html_options = args.extract_options!.symbolize_keys

    function = block_given? ? update_page(&block) : args[0] || ""
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || "#"

    content_tag(:a, name, html_options.merge(href: href, onclick: onclick))
  end
end
