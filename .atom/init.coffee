# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"
{TextEditor} = require('atom')
TextEditor.prototype.isFoldableAtBufferRow = -> false
# atom.getCurrentWindow().on 'blur', ->
#   for pane in atom.workspace.getPanes()
#     pane.saveItems()

#process.nextTick ->
#  atom.workspace.getPaneItems().forEach ->
#      atom.workspace.destroyActivePaneItem()
