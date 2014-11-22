from string import ascii_letters, digits


def classnum(text):
    """Return the words in a tweet, not including punctuation.
    """
    for i in range(len(text)):
        if text[i] not in ascii_letters:
            if text[i] not in digits:
                text = text[:i] + ' ' + text[i+1:]
    return text.split()

def extract(dept, text):
    text = classnum(text)
    for i in text:
        print('- course: '+ dept + '.'+ str(i))


def number_switch(num, up_to):
    """Takes a number, adds an "A" and a "B" onto it, up 
    another number of choice.

    >>> number_switch(112, 114)
    112A
    112B
    113A
    113B
    114A
    114B
    """
    while up_to >= num:
        print('{0}A'.format(num))
        print('{0}B'.format(num))
        num += 1


def letter_add(num, end):
    """Adds one letter to the alphabet to the number of choice.

    >>> letter_add(134, 'D')
    134A
    134B
    134C
    """
    for letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ':
        if end == letter:
                return
        print('{0}{1}'.format(num, letter))


def consec_num(first, last):
    """Creates a column of every whole number between the first
    and the last number.

    >>> consec_num(5, 7)
    5
    6
    7
    """
    while first <= last:
        print(first)
        first += 1


