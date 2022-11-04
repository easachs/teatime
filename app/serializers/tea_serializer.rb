# frozen_string_literal: true

class TeaSerializer
  def self.all_teas
    {
      data: {
        type: 'teas',
        teas: Tea.all.map do |tea|
          { id: tea.id,
            attributes: {
              title: tea.title,
              description: tea.description,
              temperature: tea.temperature,
              brew_time: tea.brew_time
            } }
        end
      }
    }
  end
end
