module ViewTestHelper
  def expect_entity_list(entities)
    selector = "##{entities.first.class.to_s.downcase.pluralize}"
    expect(rendered).to have_selector(selector) do
      entities.each do
        expect(rendered).to have_selector("p", text: entities.first.class.to_s)
      end
    end
  end
end
