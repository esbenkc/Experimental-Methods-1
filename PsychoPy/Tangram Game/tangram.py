# Importing libraries

import datetime
import random
import glob

import pandas as pd
from psychopy import core, event, gui, sound, visual

# Variable definitions

stopwatch = core.Clock()
stopwatch.reset()
reaction_time = []
answer = []

# Fetching figures

pics = glob.glob("stimulus/stimulus_*.png")
pics_descriptor = []
pics_number = []
pics_response = []
random.shuffle(pics)

for i in pics:
    pics_number.extend([(str(i[-6]) + str(i[-5]))])

print(pics_number)

# Defining log file structure

logfile = pd.DataFrame(
    columns = ["ID", "Age", "Gender", "Native_Language", "Stimulus", "Writing_Time", "Description"])

"""
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

"""




