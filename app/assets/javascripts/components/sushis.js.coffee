@Sushis = React.createClass
  getInitialState: ->
    sushis: @props.data
  getDefaultProps: ->
    sushis: []
  addSushi: (sushi) ->
    sushis = React.addons.update(@state.sushis, { $push: [sushi] })
    @setState sushis: sushis
  deleteSushi: (sushi) ->
    index = @state.sushis.indexOf sushi
    sushis = React.addons.update(@state.sushis, { $splice: [[index, 1]] })
    @replaceState sushis: sushis
  updateSushi: (sushi, data) ->
    index = @state.sushis.indexOf sushi
    sushis = React.addons.update(@state.sushis, { $splice: [[index, 1, data]] })
    @replaceState sushis: sushis
  render: ->
    React.DOM.div
      className: 'sushis'
      React.DOM.h2
        className: 'title'
        'Sushi Connections'
      React.createElement SushiForm, handleNewSushi: @addSushi
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Date'
            React.DOM.th null, 'Endpoint'
            React.DOM.th null, 'Customer ID'
            React.DOM.th null, 'Requestor ID'
            React.DOM.th null, 'Report Start'
            React.DOM.th null, 'Report End'
            React.DOM.th null, 'Password'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for sushi in @state.sushis
            React.createElement Sushi, key: sushi.id, sushi: sushi, handleDeleteSushi: @deleteSushi, handleEditSushi: @updateSushi
