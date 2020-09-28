module THUMB
  def thumb_move_shifted_register(instr : Word) : Nil
    op = bits(instr, 11..12)
    offset = bits(instr, 6..10)
    rs = bits(instr, 3..5)
    rd = bits(instr, 0..2)
    @r[rd] = case op
             when 0b00 then lsl(@r[rs], offset, true)
             when 0b01 then lsr(@r[rs], offset, true)
             when 0b10 then asr(@r[rs], offset, true)
             else           raise "Invalid shifted register op: #{op}"
             end
    @cpsr.zero = @r[rd] == 0
    @cpsr.negative = bit?(@r[rd], 31)
  end
end
