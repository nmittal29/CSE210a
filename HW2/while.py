#!/usr/bin/python3

import ply.lex as lex
import ply.yacc as yacc

class Node:

    def eval(self):
        return 0

    def execute(self):
        return 0


class IntegerNode(Node):
    def __init__(self, v):
        self.value = int(v)

    def eval(self):
        return self.value


class BinaryOpNode(Node):
    def __init__(self, op, node1, node2):
        self.Node1 = node1
        self.Node2 = node2
        self.op = op

    def eval(self):
        try:
            if self.op == '+':
                return self.Node1.eval() + self.Node2.eval()
            elif self.op == '-':
                return self.Node1.eval() - self.Node2.eval()
            elif self.op == '*':
                return self.Node1.eval() * self.Node2.eval()
            elif self.op == '/':
                return self.Node1.eval() / self.Node2.eval()
            elif self.op == '<':
                return self.Node1.eval() < self.Node2.eval()
            elif self.op == '<=':
                return self.Node1.eval() <= self.Node2.eval()
            elif self.op == '=':
                return self.Node1.eval() == self.Node2.eval()
            elif self.op == '¬=':
                return self.Node1.eval() != self.Node2.eval()
            elif self.op == '>':
                return self.Node1.eval() > self.Node2.eval()
            elif self.op == '>=':
                return self.Node1.eval() >= self.Node2.eval()
            elif self.op == '∧':
                return self.Node1.eval() and self.Node2.eval()
            elif self.op == '∨':
                return self.Node1.eval() or self.Node2.eval()
            elif self.op == '%':
                return self.Node1.eval() % self.Node2.eval()
        except Exception:
            raise MySemanticError(Exception)

class BooleanNode(Node):
    def __init__(self, boolean):
        if boolean == 'true':
            self.boolean = True
        else:
            self.boolean = False

    def eval(self):
        return self.boolean


class NotNode(Node):
    def __init__(self, node):
        self.node = node

    def eval(self):
        try:
            return not self.node.eval()
        except Exception:
            raise MySemanticError(Exception)

class EmptyBlockNode(Node):
    def __init__(self):
        self.nothing = 0

    def execute(self):
        self.nothing = 1

class SkipNode(Node):
    def __init__(self):
        self.nothing = 0

    def execute(self):
        self.nothing = 1

class BlockNode(Node):
    def __init__(self, *statements):
        self.statementList = statements

    def execute(self):
        for statement in self.statementList:
            statement.execute()



class VariableNode(Node):
    def __init__(self, name):
        self.variableName = name

    def eval(self):
        try:
            if self.variableName in variableDictionary:
                return variableDictionary[self.variableName]
            else:
                return 0
        except Exception:
            raise MySemanticError(Exception)


class AssignmentNode(Node):
    def __init__(self, variable_node, value_node):
        self.variableNode = variable_node
        self.valueNode = value_node

    def execute(self):
        try:
            variableDictionary[self.variableNode.variableName] = self.valueNode.eval()
        except Exception:
            raise MySemanticError(Exception)


class IfStatementNode(Node):
    def __init__(self, expression, block):
        self.expression = expression
        self.block = block

    def execute(self):
        if self.expression.eval():
            self.block.execute()


class IfElseStatementNode(Node):
    def __init__(self, expression, block1, block2):
        self.expression = expression
        self.block1 = block1
        self.block2 = block2

    def execute(self):
        if self.expression.eval():
            self.block1.execute()
        else:
            self.block2.execute()


class WhileStatementNode(Node):
    def __init__(self, expression, block):
        self.expression = expression
        self.block = block

    def execute(self):
        while self.expression.eval():
            self.block.execute()

variableDictionary = {}

reserved = {
    'if' : 'IF',
    'else' : 'ELSE',
    'while' : 'WHILE',
    'true' : 'TRUE',
    'false' : 'FALSE',
    'then' : 'THEN',
    'skip': 'SKIP',
    'do' : 'DO'
}

tokens = [
             'LPAREN', 'RPAREN',
             'NUMBER',
             'PLUS', 'MINUS', 'MULTIPLY', 'DIVIDE',
             'SEMICOLON', 'COMMA',
             'LESS_THAN', 'LESS_THAN_EQUAL', 'EQUAL', 'NOT_EQUAL', 'GREATER_THAN', 'GREATER_THAN_EQUAL',
             'LCURLY', 'RCURLY',
             'ASSIGN', 'ID',
             'NOT', 'AND', 'OR', 'MOD'
         ] + list(reserved.values())

t_LPAREN = r'\('
t_RPAREN = r'\)'
t_PLUS = r'\+'
t_MINUS = r'-'
t_MULTIPLY = r'\*'
t_DIVIDE = r'/'
t_SEMICOLON = r';'
t_COMMA = r','
t_LESS_THAN = r'<'
t_LESS_THAN_EQUAL = r'<='
t_EQUAL = r'='
t_NOT_EQUAL = r'\¬='
t_GREATER_THAN = r'>'
t_GREATER_THAN_EQUAL = r'>='
t_LCURLY = r'{'
t_RCURLY = r'}'
t_ASSIGN = r':='
t_NOT = r'\¬'
t_AND = r'\∧'
t_OR = r'\∨'
t_MOD = r'\%'

def t_ID(t):
    r'[a-zA-Z_][a-zA-Z_0-9]*'
    t.type = reserved.get(t.value, 'ID')    # Check for reserved words
    if t.type == 'ID':
        t.value = VariableNode(t.value)
    return t

def t_NUMBER(t):
    #r'(-?\d*(\d\.|\.\d)\d* | \d+)'
    r'(-?\d * (\d\.| \.\d)\d * | \d +)'
    try:
        t.value = IntegerNode(t.value)
    except ValueError:
        print("Integer value too large %d", t.value)
        t.value = 0
    return t

t_ignore = " \t\n"


def t_error(t):
    raise MySyntaxError(Exception)


lexer = lex.lex(debug=0)

# Parsing rules
precedence = (
    ('left', 'OR'),
    ('left', 'AND'),
    ('left', 'NOT'),
    ('left', 'LESS_THAN', 'LESS_THAN_EQUAL', 'EQUAL', 'NOT_EQUAL', 'GREATER_THAN', 'GREATER_THAN_EQUAL'),
    ('left', 'PLUS', 'MINUS'),
    ('left', 'MULTIPLY', 'DIVIDE', 'MOD'),
    ('left', 'LPAREN', 'RPAREN'),
)


def p_command_1(t):
    '''
    command : SKIP
    '''
    t[0] = SkipNode()

def p_command_9(t):
    '''
    command : WHILE expression DO ID ASSIGN expression SEMICOLON command
    '''
    t[0] = BlockNode(WhileStatementNode(t[2],AssignmentNode(t[4],t[6])),t[8])

def p_command_7(t):
    '''
    command : LCURLY command RCURLY
    '''
    t[0] = BlockNode(t[2])

def p_command_2(t):
    '''
    command : command SEMICOLON command
    '''
    t[0] = BlockNode(t[1],t[3])

def p_command_8(t):
    '''
    command : LCURLY RCURLY
    '''
    t[0] = EmptyBlockNode()

def p_command_3(t):
    '''
    command : IF expression THEN command
    '''
    t[0] = IfStatementNode(t[2], t[4])

def p_command_4(t):
    '''
    command : IF expression THEN command ELSE command
    '''
    t[0] = IfElseStatementNode(t[2], t[4], t[6])


def p_command_5(t):
    '''
    command : ID ASSIGN expression
    '''
    t[0] = AssignmentNode(t[1],t[3])


def p_command_6(t):
    '''
    command : WHILE expression DO command
    '''
    t[0] = WhileStatementNode(t[2],t[4])

def p_expression_parenthesized_expression(t):
    '''
    expression : LPAREN expression RPAREN
    '''
    t[0] = t[2]

def p_expression_binop(t):
    '''
    expression : expression PLUS expression
                  | expression MINUS expression
                  | expression MULTIPLY expression
                  | expression DIVIDE expression
                  | expression MOD expression
                  | expression LESS_THAN expression
                  | expression LESS_THAN_EQUAL expression
                  | expression EQUAL expression
                  | expression NOT_EQUAL expression
                  | expression GREATER_THAN expression
                  | expression GREATER_THAN_EQUAL expression
                  | expression AND expression
                  | expression OR expression
    '''
    t[0] = BinaryOpNode(t[2], t[1], t[3])


def p_expression_logical_operator(t):
    '''
    expression : NOT expression
    '''
    t[0] = NotNode(t[2])

def p_expression_factor(t):
    '''
    expression : factor
    '''
    t[0] = t[1]

def p_expression_unary(t):
    '''
    expression : MINUS expression
                  | PLUS expression
    '''
    t[0] = IntegerNode(str(-1 * t[2].eval()))

def p_factor_number(t):
    '''
    factor : NUMBER
    '''
    t[0] = t[1]

def p_boolean(t):
    '''
    expression : TRUE
                  | FALSE
    '''
    t[0] = BooleanNode(t[1])

def p_ID(t):
    '''
    expression : ID
    '''
    t[0] = t[1]


def p_error(t):
    raise MySyntaxError(Exception)


parser = yacc.yacc(debug=0)


import sys

class MySyntaxError(Exception):
    pass


class MySemanticError(Exception):
    pass

def print_dict():
    print_str = str()
    for id, value in sorted(variableDictionary.items()):
        print_str = print_str + str(id) + ' → ' + str(value) + ', '
    length = len(print_str)-2
    var_str = print_str[:length]
    var_str = '{' + var_str + '}'
    return var_str
try:
    data = sys.argv[1]
    lex.input(data)
    #print(data)
    while True:
        token = lex.token()
        if not token: break
        #print(token)
    root = yacc.parse(data)
    root.execute()
    #print(variableDictionary)
    vars_str = print_dict()
    print(vars_str)
except MySyntaxError:
    print("SYNTAX ERROR")
except MySemanticError:
    print("SEMANTIC ERROR")
