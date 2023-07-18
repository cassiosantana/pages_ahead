module ViewTestHelper
  def expect_object_list(objects)
    selector = generate_selector(objects.first)
    expect(rendered).to have_selector(selector) do
      objects.each do |object|
        name = object_name(object)
        expect(rendered).to have_selector("p")
        expect(rendered).to have_link("Show this #{name}", href: send("#{name}_path", object))
      end
    end
    expect(rendered).to have_selector("div p", count: objects.count)
  end

  def expect_page_title(title)
    expect(rendered).to have_selector("h1", text: title)
  end

  def expect_link_to_new(object_name)
    expect(rendered).to have_link("New #{object_name}", href: send("new_#{object_name}_path"))
  end

  def expect_link_to_show(object)
    name = object_name(object)
    expect(rendered).to have_link("Show this #{name}", href: send("#{name}_path", object))
  end

  def expect_link_to_edit(object)
    name = object_name(object)
    expect(rendered).to have_link("Edit this #{name}", href: send("edit_#{name}_path", object))
  end

  def expect_link_back_to(index_name)
    expect(rendered).to have_link("Back to #{index_name}", href: send("#{index_name}_path"))
  end

  def expect_submit_button(button_name)
    expect(rendered).to have_button(button_name)
  end

  private

  def generate_selector(object)
    "##{object.class.to_s.downcase.pluralize}"
  end

  def object_name(object)
    object.class.to_s.downcase
  end
end
