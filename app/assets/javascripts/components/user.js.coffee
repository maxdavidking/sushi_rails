@User = React.createClass
  getInitialState: ->
    edit: false
  handleEdit: (e) ->
    e.preventDefault()
    data =
      name: @refs.name.value
      organization: @refs.organization.value
    $.ajax
      method: 'PUT'
      url: "/user/#{ @props.user.id }"
      dataType: 'JSON'
      data:
        user: data
      success: (data) =>
        @setState edit: false
        @props.handleEditUser @props.user, data
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  recordRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.user.name
      React.DOM.td null, @props.user.organization
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Edit'
  recordForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.user.name
          ref: 'name'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.user.organization
          ref: 'organization'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'
  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
