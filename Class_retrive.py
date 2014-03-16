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