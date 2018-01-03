@Sushis = React.createClass
  getInitialState: ->
    sushis: @props.data
  getDefaultProps: ->
    sushis: []
  render: ->
    React.DOM.div
      className: 'sushis'
      React.DOM.h2
        className: 'title'
        'Sushi Connections'
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
        React.DOM.tbody null,
          for sushi in @state.sushis
            React.createElement Sushi, key: sushi.id, sushi: sushi
