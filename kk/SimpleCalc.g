
grammar SimpleCalc;
options {
  language = Ruby;
}

@members {
  @stack = []

  def result
    @stack[0]
  end
}

parse: expression;

expression: mult (
    '+' mult {
      @stack.push(@stack.pop + @stack.pop)
    }
  | '-' mult {
      a = @stack.pop
      b = @stack.pop
      @stack.push(b - a)
    }
  )* ;

mult: atom (
    '*' atom {
      @stack.push(@stack.pop * @stack.pop)
    }
  | '/' atom {
      a = @stack.pop
      b = @stack.pop
      @stack.push(b / a.to_f)
    }
  )* ;


atom: n=NUMBER { @stack.push($n.text.to_i) }
  | '(' expression ')';

NUMBER: ('0'..'9')+;

WS: (' ' | '\n' | '\t')+ { channel = 99 };
