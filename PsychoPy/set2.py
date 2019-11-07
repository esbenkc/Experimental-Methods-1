#!/usr/bin/env python

"""
set2.py

Experiment to display the game Set on the screen to 
gauge how large the search time difference is between
different parameters (number, color, filling, shape).

URL:      
Author:   Esben Kran Christensen
License:  Creative Commons Attribution 3.0 License

"""
#############################
### SET PYTHON RECREATION ###
#############################

import datetime
import glob
import random
import pygame

import pandas as pd
# Load modules
from psychopy import core, event, gui, sound, visual

stopwatch = core.Clock()
stopwatch.reset()
reaction_time = []
answer = []

#####################
### CARD CREATION ###
#####################

# Card 4 parameters: Color, number, shape, fill
#
# Color: 1 = red, 2 = green, 3 = blue
# Number: 1, 2, 3
# Shape: 1 = circle, 2 = rhombus, 3 = curved
# Fill: 1 = empty, 2 = lined, 3 = filled
#

cards = {'col': {1, 2, 3}, 'n': {1, 2, 3}, 'shape': {1, 2, 3}, 'fill': {1, 2, 3}}
#
#for i in cards:
#    msg = visual.TextStim(win, text = "The rules are simple: win.")
#    msg.draw()
#    win.flip()
#    event.waitKeys(keyList = ["space"])

############################
### VARIABLE DEFINITIONS ###
############################



######################
### PYGAME TESTING ###
######################

class PygView(object):
    
    def __init__(self, width = 640, height = 400, fps = 60):
        # Initialize pygame, window, background, font...
        pygame.init()
        pygame.display.set_caption("Press ESC to quit")
        self.width = width
        self.height = height
        self.screen = pygame.display.set_mode((self.width, self.height), pygame.DOUBLEBUF)
        self.background = pygame.Surface(self.screen.get_size()).convert()
        self.clock = pygame.time.Clock()
        self.fps = fps
        self.playtime = 0.0
        self.font = pygame.font.SysFont('mono', 20, bold = False)
    
    def run(self):
        # Main loop
        running = True
        while running:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    running = False
                elif event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_ESCAPE:
                        running = False
            milliseconds = self.clock.tick(self.fps)
            self.playtime += milliseconds / 1000.0
            self.draw_text("FPS: {:6.3}{}PLAYTIME: {:6.3} SECONDS".format(
                            self.clock.get_fps(), "\n", self.playtime))
            pygame.display.flip()
            self.screen.blit(self.background, (0, 0))
            
        pygame.quit()
    
    def draw_text(self, text):
        # Center text in window
        
        fw, fh = self.font.size(text)
        surface = self.font.render(text, True, (0, 255, 0))
        self.screen.blit(surface, ((self.width - fw) // 2, (self.height - fh) // 2))
        
if __name__ == '__main__':
    PygView(640,400).run()

#
#screen = pygame.display.set_mode((640, 480))
#background = pygame.Surface(screen.get_size())
#background.fill((255,255,255))
#background = background.convert()
#
#screen.blit(background, (0,0))
#
#milliseconds = clock.tick(FPS)
#playtime += milliseconds / 1000
#
#for event in pygame.event.get():
#    if event.type == pygame.QUIT:
#        mainloop = False
#    elif event.type == pygame.KEYDOWN:
#        if event.key == pygame.K_ESCAPE:
#            mainloop = False
#
