Template.item_list.events
  'click .add-item': (event, template) ->
    template.data.add() if template.data.add

  'click .icon-remove': (event, template) ->
    value = event.target.parentNode.innerHTML.replace(/<i.*<\/i>/, '')
    template.data.remove(value) if template.data.remove
