# Importing libraries

import datetime
import random

import pandas as pd
from psychopy import core, event, gui, sound, visual

# Variable definitions

txts = [
    """Once upon a time, a very long time ago now, about last Friday, Winnie-the-Pooh lived in a forest all by himself under the name of Sanders. One day when he was out walking, he came to an open place in the middle of the forest, and in the middle of this place was a large oak-tree, and, from the top of the tree, there came a loud buzzing-noise.
Winnie-the-Pooh sat down at the foot of the tree, put his head between his paws, and began to think.
First of all he said to himself: That buzzing-noise means something. You don’t get a buzzing-noise like that, 
just buzzing and buzzing, without its meaning something. If there’s a buzzing-noise, somebody’s making a buzzing-noise, 
and the only reason for making a buzzing-noise that I know of is because you’re a bee. 
Then he thought another long time, and said: ‘And the only reason for being a bee that I know of is making honey.’
And then he got up, and said: ‘And the only reason for making honey is so as I can eat it.’ So he began to climb the tree.""",
    """Once upon a time, a very long time ago now, about last Friday, Winnie-the-Pooh lived in a forest all by himself under the name of Sanders. One day when he was out walking, he came to an open place in the middle of the forest, and in the middle of this place was a large oak-tree, and, from the top of the tree, there came a loud buzzing-noise.
Winnie-the-Pooh sat down at the foot of the tree, put his head between his paws, and began to think.
First of all he said to himself: That buzzing-noise means something. You don’t get a buzzing-noise like that, 
just buzzing and buzzing, without its meaning something. If there’s a buzzing-noise, somebody’s making a buzzing-noise, 
and the only reason for making a buzzing-noise that I know of is because you’re a bee. 
Then he thought another long time, and said: ‘And the only reason for being a bee that I know of is making juice.’
And then he got up, and said: ‘And the only reason for making honey is so as I can eat it.’ So he began to climb the tree."""
]

practice_txt = "You're now reading this test text."
realtest_txt = "We're now going to show the real text and you'll read it. 'space' to continue."

lines = [
    "Welcome to the experiment!",
    "Here, you have to test your reading time for two different texts.",
    "We'll start with a test sequence:"]

stopwatch = core.Clock()
stopwatch.reset()

# Defining log file structure

logfile = pd.DataFrame(
    columns = ["ID", "Age", "Gender", "Native_Language", "Stimulus", "Reaction_Time", "Word"])


# Experiment
# Showing participant input box
box = gui.Dlg(title = "Experiment information")
box.addField("Participant ID:")
box.addField("Age:")
box.addField("Gender:", choices = ["Female", "Male"])
box.addField("Native language: ", choices = ["English", "Non-English"])
box.show()
if box.OK:
    ID = box.data[0]
    AGE = int(box.data[1])
    GENDER = box.data[2]
    NAT_LANG = box.data[3]
elif box.Cancel:
    core.quit()

# Starting GUI
win = visual.Window(color = "black", fullscr = True, viewScale = 1)


# Introducing experiment
for i in lines:
    txt = visual.TextStim(win, i + " 'space' to continue.")
    txt.draw()
    win.flip()
    event.waitKeys(keyList = ["space"])

# Show practice text
for i in practice_txt.split(sep = " "):
    msg = visual.TextStim(win, text = i)
    msg.draw()
    win.flip()
    event.waitKeys(keyList = ["space"])

# Continue experiment text
txt = visual.TextStim(win, text = realtest_txt)
txt.draw()
win.flip()
event.waitKeys(keyList = ["space"])

# Choose random experimental text
if random.randrange(0, 2) == 0:
    stimulus = txts[0]
    stim_num = 0
else:
    stimulus = txts[1]
    stim_num = 1

# Actual experiment
stimulus = stimulus.split(sep = " ")
for i in stimulus:
    word = visual.TextStim(win, text = i)
    word.draw()
    win.flip()
    stopwatch.reset()
    event.waitKeys(keyList = ["space"])
    logfile = logfile.append({
        "ID": ID,
        "Age": AGE,
        "Gender": GENDER,
        "Native_Language": NAT_LANG,
        "Stimulus": stim_num,
        "Reaction_Time": str(stopwatch.getTime() % 60),
        "Word": i
    }, ignore_index = True)

# Saving the log file
DT = datetime.datetime.now()
logfile_name = "logfiles/logfileP2_{0}.csv".format(ID)
logfile.to_csv(logfile_name)

# Ending experiment
msg = visual.TextStim(win, text = "Thank you for participating. The experiment will now end.")
msg.draw()
win.flip()
core.wait(2)
