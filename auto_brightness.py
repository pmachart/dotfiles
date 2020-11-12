# https://gist.github.com/vaibhav93/20500065786327e55c2f438a3922a7ae

import i3ipc
import os

SET_BRIGHTNESS = 'xbacklight -time 0 -set ' 
GET_BRIGHTNESS = 'xbacklight'
i3 = i3ipc.Connection()

class BrightnessController:
    def __init__(self):
        self.brightness_map = {}
        # Subscribe to events
        i3.on('workspace::focus', self.on_workspace_focus)
        # Start main loop
        i3.main()   

    def get_brightness(self):
        return os.popen(GET_BRIGHTNESS).read()

    def set_brightness(self,brightness):
        os.system(SET_BRIGHTNESS + brightness)

    # Define a callback to be called when you switch workspaces.
    def on_workspace_focus(self, connection, e):
        current_brightness = float(self.get_brightness())
        #print(current_brightness)
        if e.old:
            self.brightness_map[e.old.id] = str(current_brightness)

        if e.current:
            if e.current.id in self.brightness_map:
                self.set_brightness(self.brightness_map[e.current.id])

bc = BrightnessController()
