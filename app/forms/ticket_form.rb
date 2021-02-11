class TicketForm < Reform::Form
  include Reform::Form::Coercion

  property :drawing_id
  property :prize_id
  property :entry_id
  property :serial_number
  property :revealed_at
  property :scratch_state

  validates :drawing_id, presence: true
  validates :entry_id, presence: true
  validate :set_scratch_state, if: :validate_revealed?

  def set_scratch_state
    model.scratch_state.map.with_index do |x, i|
      x.map.with_index do |_, j|
        scratch_state[i][j]['prize'] = model.scratch_state[i][j]['prize']
      end
    end
    self.scratch_state = auto_reveal_all_tiles(scratch_state)
  end

  # Revealing all tiles if the user reveals 3 tiles of winning ammount
  def auto_reveal_all_tiles(scratch_state)
    prize_reveal_count = scratch_state.flatten.group_by(&:itself).map{|k, v| [k, v.length]}.to_h
    if prize_reveal_count.key(3) && prize_reveal_count.key(3)['revealed']
      scratch_state.map.with_index do |x, i|
        x.map.with_index do |_, j|
          scratch_state[i][j]['revealed'] = true
        end
      end
    end
    return scratch_state
  end

  def validate_revealed?
    unless scratch_state.flatten.count == 9
      errors.add(:base, 'send proper number of tiles')
      return false
    else
      model.scratch_state.map.with_index do |x,i|
         x.map.with_index do |_, j|
            if model.scratch_state[i][j]['revealed']
              unless scratch_state[i][j]['revealed']
                errors.add(:base, 'illegal action')
                return false
              end
            end
         end
      end
    end
  end
end
