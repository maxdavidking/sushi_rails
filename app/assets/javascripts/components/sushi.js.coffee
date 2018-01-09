@Sushi = React.createClass
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/sushi/#{ @props.sushi.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteSushi @props.sushi
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.sushi.name
      React.DOM.td null, @props.sushi.endpoint
      React.DOM.td null, @props.sushi.cust_id
      React.DOM.td null, @props.sushi.req_id
      React.DOM.td null, @props.sushi.report_start
      React.DOM.td null, @props.sushi.report_end
      React.DOM.td null, @props.sushi.password
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
