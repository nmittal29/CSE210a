import ply.lex as lex
import ply.yacc as yacc
import sys

tokens = ['INT', 'BOOLEAN', 'IDENTIFIER', 'PLUS', 'MINUS', 'MULTIPLY', 'DIVIDE', 'EQUALS']

t_PLUS = r'\+'
t_MINUS = r'\-'
t_MULTIPLY = r'\*'
t_DIVIDE = r'\/'
t_EQUALS = r'\='
t_ignore = r' '

def t_INT(t):
    r'\d+'
    t.value = int(t.value)
    return t

def t_IDENTIFIER(t):
    r'[a-zA-Z_][a-zA-Z0-9_]*'
    t.type = 'IDENTIFIER'
    return t

def t_error(t):
    print("\n Illegal Characters!!")
    t.lexer.skip(1)


lexer = lex.lex()
env = {}

precedence = (

    ('left', 'PLUS', 'MINUS'),
    ('left', 'MULTIPLY', 'DIVIDE')
)

def p_calc(p):
    '''
    calc : expression
         | var_assign
         | empty
    '''
    print(run(p[1]))

def p_var_assign(p):
    '''
    var_assign : IDENTIFIER EQUALS expression
    '''
    p[0] = ('=', p[1], p[3])

def p_expression(p):
    '''
    expression : expression DIVIDE expression
               | expression MULTIPLY expression
               | expression PLUS expression
               | expression MINUS expression
    '''
    p[0] = (p[2], p[1], p[3])

def p_expression_int(p):
    '''
    expression : INT
    '''
    p[0] = p[1]

def p_expression_var(p):
    '''
    expression : IDENTIFIER
    '''
    p[0] = ('var', p[1])

def p_empty(p):
    '''
    empty :
    '''
    p[0] = None

def p_error(p):
    print("Syntax error found!!")

def run(p):
    if type(p) == tuple:
        if p[0] == '+':
            return run(p[1]) + run(p[2])
        elif p[0] == '-':
            return run(p[1]) - run(p[2])
        elif p[0] == '*':
            return run(p[1]) * run(p[2])
        elif p[0] == '/':
            return run(p[1]) / run(p[2])
        elif p[0] == '=':
            env[p[1]] = run(p[2])
            print(env)
        elif p[0] == 'var':
            if p[1] not in env:
                return 'Undeclared Variable found!'
            else:
                return env[p[1]]
    else:
        return p

parser = yacc.yacc()

while True:
    try:
        s = input('')

    except EOFError:
        break

    parser.parse(s)