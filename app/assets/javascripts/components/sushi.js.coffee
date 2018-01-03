@Sushi = React.createClass
  getInitialState: ->
    sushi: @props.data
  getDefaultProps: ->
    sushi: []
  render: ->
    React.DOM.div
      className: 'sushi'
      React.DOM.h2
        className: 'title'
        'Sushi'
