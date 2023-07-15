module ViewTestHelper
  def expect_entity_list(entities)
    selector = get_selector(entities.first)
    expect(rendered).to have_selector(selector) do
      entities.each do |entity|
        entity_name = entity.class.to_s.downcase
        expect(rendered).to have_selector("p")
        expect(rendered).to have_link("Show this #{entity_name}", href: send("#{entity_name}_path", entity))
      end
    end
    expect(rendered).to have_selector("div p", count: entities.count)
  end

  def expect_page_title(title)
    expect(rendered).to have_selector("h1", text: title)
  end

  def expect_link_to_new(record_name)
    expect(rendered).to have_link("New #{record_name}", href: send("new_#{record_name}_path"))
  end

  private

  def get_selector(entity)
    "##{entity.class.to_s.downcase.pluralize}"
  end
end
