""" # The Great Hypothesis Idea Generator

print("___________________________")
title = "The Great Hypothesis Idea Generator"
intro = "This program assists in the generation of hypotheses and ideas"
intro + " and uses different listing combinations to compile old ideas into new!"

def introduction():
    print(title + "\n" + intro)

# Indentation decides function association (??)

introduction()

# List manipulation

listing = ['horse', 'manic', 23, 55]
numbers = listing [2:4]
words = listing[0:2]

print (numbers + words)

# Excercise 1

names = ['bob', 'mette', 'mette', 'pete', 'holger', 'bibi', 'kurt']
names.extend("connie julie torben".split())
names.remove('kurt')
names.sort(reverse = True)

print(names)

print("Length of last name: " + str(len(names[len(names)-1])))

for i in names:
    i = i.upper()
    print(i.upper())

print(names) """

# Day 2

"""

def mean(x):
    return sum(x) / len(x)

print(mean([3,34,2,64,34]))

# Excercise 3
def text_fun(x):
    result = x.split()
    sum = 0
    for i in result:
        print(len(i))
        sum += len(i)
    print(sum / len(result))

text_fun("Duck man woman girl boy son daughter lover")

"""

import datetime
import glob
import random

import pandas as pd
# Load modules
from psychopy import core, event, gui, sound, visual

# show pop-up box
box = gui.Dlg(title = "DATAAA!!!")
box.addField("Participant ID:")
box.addField("Age:")
box.addField("Gender:", choices = ["female","male", "unicorn"])
box.show()
if box.OK:
    ID = box.data[0]
    AGE = box.data[1]
    GENDER = box.data[2]
elif box.Cancel:
    core.quit()

print(ID, AGE, GENDER)

stopwatch = core.Clock()
stopwatch.reset()
reaction_time = []
answer = []

logfile = pd.DataFrame(columns = ["ID", "Age", "Gender", "Stimulus", "Cogs", "Response", "Correct", "Reaction_Time"])

pics = glob.glob("PsychoPy Workshop/stimuli/stimulus*.jpg")
pics_cogs = []
pics_number = []
pics_response = []
random.shuffle(pics)

win = visual.Window(color = "black", fullscr = True, viewScale = 1)
msg = visual.TextStim(win, "Welcome to the experiment!")
msg.draw()
win.flip()
core.wait(2)

if random.randrange(0, 2) == 0:
    pic = visual.ImageStim(win, image = "PsychoPy Workshop/stimuli/picture.jpg")
else:
    pic = visual.ImageStim(win, image = "PsychoPy Workshop/stimuli/success.jpg")
pic.draw()
win.flip()
event.waitKeys()

# Excercise 4

def screenimager(image, soundPath):
    audio = sound.Sound(soundPath)
    nextFlip = win.getFutureFlipTime(clock='ptb')
    # audio.play(when = nextFlip)
    pic = visual.ImageStim(win, image = image)
    pic.draw()
    win.flip()
    core.wait(1)

def inputunit(txt, input):
    txt = visual.TextStim(win, txt)
    txt.draw()
    win.flip()
    event.waitKeys(keyList = [input])

success = ["PsychoPy Workshop/stimuli/success.jpg", "PsychoPy Workshop/sounds/applause.wav"]
failure = ["PsychoPy Workshop/stimuli/failure.jpg", "PsychoPy Workshop/sounds/fail.wav"]

correct = ""

for i in pics:
    pic = visual.ImageStim(win, image = i)
    pic.draw()
    win.flip()
    stopwatch.reset()
    key = event.waitKeys(keyList = ["left", "right"])[0]
    if key == "left" and i[-5] == "L" or key == "right" and i[-5] == "R":
        screenimager(success[0], success[1])
        correct = 1
    elif key == "right" and i[-5] == "L" or key == "left" and i[-5] == "R":
        screenimager(failure[0], failure[1])
        correct = 0
    elif key == "q":
        core.quit()
    reaction_time.append(stopwatch.getTime() % 60)

    logfile = logfile.append({
        "Cogs":i[-7],
        "Stimulus":i[-9],
        "Reaction_time": str(stopwatch.getTime() % 60),
        "Response": "left" if key == "left" else "right",
        "ID": ID,
        "Age": AGE,
        "Gender": GENDER,
        "Correct": correct
        }, ignore_index = True)

DT = datetime.datetime.now()

logfile_name = "logfiles/logfile_{0}_{1}.csv".format(ID, str(DT.year) + str(DT.month) + str(DT.day) + str(DT.microsecond))
logfile.to_csv(logfile_name)

inputunit("Goodbye, love...", 'l')
inputunit("Goodbye, love... L", 'o')
inputunit("Goodbye, love... Lo", 'v')
inputunit("Goodbye, love... Lov", 'e')
inputunit("Goodbye, love... Love", '.')

txt = visual.TextStim(win, "Awwww <3")
txt.draw()
win.flip()
core.wait(2)
