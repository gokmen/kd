KDListItemView = require './../list/listitemview.coffee'
JView          = require './../../core/jview.coffee'

module.exports = class JTreeItemView extends KDListItemView

  constructor:(options = {}, data = {})->

    options.tagName      or= "li"
    options.type         or= "jtreeitem"
    options.bind         or= "mouseenter contextmenu dragstart dragenter dragleave dragend dragover drop"
    options.childClass   or= null
    options.childOptions or= {}

    super options, data

    @setClass "jtreeitem"
    @expanded = no

    {childClass, childOptions} = @getOptions()
    if childClass
      @child = new childClass childOptions, @getData()

  viewAppended: JView::viewAppended

  pistachio:->

    if @getOptions().childClass
      "{{> @child}}"
    else
      """
      <span class='arrow'></span>
      {{#(title)}}
      """

  toggle:(callback)->

    if @expanded then @collapse() else @expand()

  expand:(callback)->

    @expanded = yes
    @setClass "expanded"

  collapse:(callback)->

    @expanded = no
    @unsetClass "expanded"

  decorateSubItemsState:(state = yes)->

    if state
      @setClass "has-sub-items"
    else
      @unsetClass "has-sub-items"
