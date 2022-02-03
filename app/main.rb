
def thundersnow_talks_at
  Time.at(1_644_278_400)
end

def talk_ends_at
  minutes = 1
  seconds = 5
  Time.now.utc + ((60 * minutes) + seconds)
end

def tick(args)
  @stop_time = thundersnow_talks_at
  # @stop_time = talk_ends_at

  seconds_left = (@stop_time - Time.now.utc).round

  if seconds_left <= 0
    @text_label[:text] = '0:00'
    args.audio[:my_audio] = { input: thundersnow_sound, gain: 1.0 } unless @countdown_ended
    @countdown_ended = true
    size_inc = [-1, 1].sample
    @text_label[:size_enum] += size_inc
    @text_label[:y] += size_inc
  else
    @countdown_ended = false
    time_left = Time.at(seconds_left)
    @text_label = text_label
    @text_label[:text] = "#{time_left.min}:#{time_left.sec.to_s.rjust(2, '0')}"

    if seconds_left == 60
      args.audio[:my_audio] = { input: thundersnow_sound, gain: 0.1 } unless @played_warning
      @played_warning = true
    else
      @played_warning = false
    end
  end

  args.outputs.labels << @text_label
  args.outputs.background_color = [0, 0, 0, 255]
end

def thundersnow_sound
  @sound_cycle ||= (0..4).to_a.cycle
  "sounds/thundersnow_#{@sound_cycle.next}.wav"
end

def text_label
  { x: 630,
    y: 640,
    r: 240,
    g: 217,
    b: 255,
    alignment_enum: 1,
    size_enum: 240 }
end
