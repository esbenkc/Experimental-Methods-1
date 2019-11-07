#Title: Portfolio 2
#Date: 07.10.2019
#Author: Lærke Kyed Reese Andersen 

#Reading library
from psychopy import visual, core, event, gui
import glob
import random
import pandas as pd

#Pop up window
box = gui.Dlg(title = "Title")
box.addField("ID:")
box.addField("Age:")
box.addField("Gender:", choices = ["Female", "Male", "Other"])
box.addField("Native Language:", choices = ["English", "Non-English"])
box.show()
if box.OK:
    ID = box.data[0]
    AGE = box.data[1]
    GENDER = box.data[2]
    NAT_LANG = box.data[3]
elif box.Cancel:
    core.quit()

logfile = pd.DataFrame(columns = ["ID", "Age", "Gender", "Native_Language", "Stimulus", "Word", "Reaction.time"])

#Defining window
win = visual.Window(fullscr = True)

#Introduction
msg = visual.TextStim(win, text = "Welcome to the experiment! \n\nYou will be presented with a short text. \nYou will only be able to read one word at a time. \nWhen you have read the word, press 'space' to get the next word. \n\nWe will start out with a brief example:")
msg.draw()
win.flip()
event.waitKeys(keyList = ["space"])

Trial = "This is just an example."
Trial = Trial.split(sep = " ")

for testword in Trial:
    msg = visual.TextStim(win, text = testword)
    msg.draw()
    win.flip()
    event.waitKeys(keyList = ["space"])

msg = visual.TextStim(win, text = "Great! You are now ready to begin the experiment. \n(Press 'space' to continue)")
msg.draw()
win.flip()
event.waitKeys(keyList = ["space"])

#Experiment:

#Adding stopwatch
stopwatch = core.Clock()

#Securing randomization
if random.randrange(0, 2) == 0:
    Stimulus = "Pretend level faulty vigorous inexpensive camp long decide join infamous steep kettle godly peel soft sleepy land battle discover intend troubled misty reflective marvellous crack odd believe punch rescue summer gun load vessel purple shivering mind please tax stir vivacious neat quickest cake jail flaky raise complete cover kaput receipt lovely giant stream stomach cute art frightening humorous rabbit kill copper increase envious alike applaud top box push unfasten frame calculator poised flame wonderful befitting grab protest earn imported approve abstracted clean camera avoid eggs crook zephyr cooing double abiding quizzical bees make honey bite-sized terrible unarmed rule miss robust flippant thirsty touch work club regret protect square axiomatic mother"
    Stimulus_num = 1
else:
    Stimulus = "Pretend level faulty vigorous inexpensive camp long decide join infamous steep kettle godly peel soft sleepy land battle discover intend troubled misty reflective marvellous crack odd believe punch rescue summer gun load vessel purple shivering mind please tax stir vivacious neat quickest cake jail flaky raise complete cover kaput receipt lovely giant stream stomach cute art frightening humorous rabbit kill copper increase envious alike applaud top box push unfasten frame calculator poised flame wonderful befitting grab protest earn imported approve abstracted clean camera avoid eggs crook zephyr cooing double abiding quizzical bees make juice bite-sized terrible unarmed rule miss robust flippant thirsty touch work club regret protect square axiomatic mother"
    Stimulus_num = 2

#Splitting the list into seperate words:
Stimulus = Stimulus.split(sep = " ")

#Creating loop for every word in the text:
for word in Stimulus:
    msg = visual.TextStim(win, text = word)
    msg.draw()
    win.flip()
    stopwatch.reset()
    event.waitKeys(keyList = ["space"])
    reaction_time = stopwatch.getTime()
    Word = word
    logfile = logfile.append({
        "ID": ID,
        "Age": AGE,
        "Gender": GENDER,
        "Native_Language": NAT_LANG,
        "Stimulus": Stimulus_num,
        "Word": Word,
        "Reaction.time": reaction_time}, ignore_index = True)

#Saving the data
logfile_id = "logfiles/readingP2_alt_{0}.csv".format(ID)
logfile.to_csv(logfile_id)