_title = null
_list = null
_ok = null
_callback = null
_selected = null

@openListDialog = (title, list, ok, callback) ->
  _title = if title then title else "Choose one"
  _list = if list then list else []
  _ok = if ok then ok else 'OK'
  _callback = callback
  Session.set('show_list_dialog', true)

closeDialog = ->
  Session.set('show_list_dialog', false)

Template.list_dialog.show = ->
  Session.get('show_list_dialog')

Template.list_dialog.title = ->
  return _title

Template.list_dialog.list = ->
  return _list

Template.list_dialog.ok = ->
  return _ok

Template.list_dialog.active = ->
  selectedId = Session.get('selectedId')
  if selectedId == this._id
    return 'active'
  else
    return ''

Template.list_dialog.events
  'click .cancel': -> closeDialog()
  'click .ok': ->
    closeDialog()
    _callback(_selected) if _callback
  'click .list-item': (event) ->
    Session.set('selectedId', this._id)
    _selected = this.name
