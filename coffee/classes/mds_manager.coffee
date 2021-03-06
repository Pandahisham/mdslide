type_is = (type, obj) -> obj? and type == Object.prototype.toString.call(obj).slice(8, -1)

ipc = require('electron').ipcMain;

module.exports = class MdsManager
  WINDOW_PENDING: 1
  WINDOW_ACCEPTED: 2

  windows: new Map
  window_states: new Map

  constructor: ->
    ipc.on 'MdsRendererRequestAccept', @onRequestedAccept
    ipc.on 'MdsRendererSendEvent', @onRecievedEvent

  addWindow: (id, obj) =>
    @window_states.set id, @WINDOW_PENDING
    @windows.set id, obj

  removeWindow: (id) =>
    @window_states.delete id
    @windows.delete id

  onRequestedAccept: (e, id) =>
    is_accepted = @window_states.get(id) == @WINDOW_PENDING
    @window_states.set id, @WINDOW_ACCEPTED if is_accepted

    e.sender.send 'MdsManagerRendererAccepted', is_accepted

  onRecievedEvent: (e, evt, target, args) =>
    if @window_states.get(target?.from) == @WINDOW_ACCEPTED
      send_target = []

      if target.to == '*' or target.to == '**'
        @window_states.forEach (state, id) =>
          return if target.to == '*' and id == target.from
          send_target.push(id) if state == @WINDOW_ACCEPTED

      else if target.to?
        tos = if type_is("Number", target.to) then [target.to] else target.to
        for t in tos
          send_target.push t if @window_states.get(t) == @WINDOW_ACCEPTED

      else
        @windows.get(target.from).trigger evt, args...

      for wid in send_target
        w = @windows.get(wid)?.browserWindow?.webContents
        w.send 'MdsManagerSendEvent', evt, { from: target.from, to: send_target }, args

    e.sender.send 'MdsRendererEventSent', evt
