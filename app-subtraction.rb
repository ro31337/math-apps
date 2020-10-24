class Addition
  INFINITY = 1.to_f / 0
  attr_reader :a, :b

  def initialize
    @a = @b = INFINITY
  end

  def regenerate
    loop do
      @a = rand(0..10)
      @b = rand(0..10)
      break if @a + @b <= 10
    end
  end
end

class Subtraction
  attr_reader :a, :b

  def regenerate
    loop do
      @a = rand(0..10)
      @b = rand(0..10)
      next if @a - @b > 10 || @a - @b < 0
      break
    end
  end
end

class AsString
  def initialize(origin:)
    @origin = origin
  end

  def print
    10.times do
      @origin.regenerate
      a = @origin.a
      b = @origin.b
      puts "#{a} + #{b} = "
      puts
      puts "#{spaced('.' * a)} + #{spaced('.' * b)} ="
      puts
      puts
    end
  end

  private

  def spaced(s)
    s.scan(/.{1,5}/).join(' ')
  end
end

class AsHtml
  def initialize(origin:)
    @origin = origin
  end

  def head
    puts <<~HTML
      <html>
      <head>
        <style>
          body { font-family: Arial }
          .exercise { border-bottom: 1px dotted #000; padding: 9px 0 }
          .exercise:last-child { border-bottom: none }
          .example { font-size: 30px }
          .hint { font-size: 40px; display: flex; flex-direction: row; line-height: 14px; margin-top: 8px }
          .hint > div { margin-right: 10px }
          .hint .plus { color: #888; font-size: 20px }
          .hint .x { font-size: 17px; }
        </style>
      </head>
      <body>
      <div class="exercise" style="border-bottom: 3px solid #000">
        <div class="example">1 &nbsp;2 &nbsp; 3 &nbsp;&nbsp;&nbsp; 4 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10</div>
        <div class="hint">
          <div>
            #{spaced('•' * 1)}
          </div>
          <div>
            #{spaced('•' * 2)}
          </div>
          <div>
            #{spaced('•' * 3)}
          </div>
          <div>
            #{spaced('•' * 4)}
          </div>
          <div>
            #{spaced('•' * 5)}
          </div>
          <div>
            #{spaced('•' * 6)}
          </div>
          <div>
            #{spaced('•' * 7)}
          </div>
          <div>
            #{spaced('•' * 8)}
          </div>
          <div>
            #{spaced('•' * 9)}
          </div>
          <div>
            #{spaced('•' * 10)}
          </div>
        </div>
      </div>
    HTML
  end

  def print_with_head(...)
    head
    print(...)
  end

  def print
    10.times do
      @origin.regenerate
      a = @origin.a
      b = @origin.b
      yield(a, b)
    end
  end
end

def spaced(s)
  s.scan(/.{1,5}/).join('<br />')
end

AsHtml.new(origin: Subtraction.new).print_with_head do |a, b|
  puts <<~HTML
    <div class="exercise">
      <div class="example">#{a} - #{b} =</div>
      <div class="hint">
        <div>
          #{spaced('•' * a)}
        </div>
        <div class="x">
          #{spaced('✕' * b)}
        </div>
      </div>
    </div>
  HTML
end
