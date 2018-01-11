@Sushi = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/sushi/#{ @props.sushi.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteSushi @props.sushi
  handleEdit: (e) ->
    e.preventDefault()
    data =
      name: @refs.name.value
      endpoint: @refs.endpoint.value
      cust_id: @refs.cust_id.value
      req_id: @refs.req_id.value
      report_start: @refs.report_start.value
      report_end: @refs.report_end.value
      password: @refs.password.value
    $.ajax
      method: 'PUT'
      url: "/sushi/#{ @props.sushi.id }"
      dataType: 'JSON'
      data:
        sushi: data
      success: (data) =>
        @setState edit: false
        @props.handleEditSushi @props.sushi, data
  sushiForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.sushi.name
          ref: 'name'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.sushi.endpoint
          ref: 'endpoint'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.sushi.cust_id
          ref: 'cust_id'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.sushi.req_id
          ref: 'req_id'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.sushi.report_start
          ref: 'report_start'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.sushi.report_end
          ref: 'report_end'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.sushi.password
          ref: 'password'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'
  sushiRow: ->
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
          className: 'btn btn-info'
          href: "/sushi/#{ @props.sushi.id }/test"
          'Test'
        React.DOM.a
          className: 'btn btn-primary'
          href: "/sushi/#{ @props.sushi.id }/call.csv"
          'Connect'
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  render: ->
    if @state.edit
      @sushiForm()
    else
      @sushiRow()
