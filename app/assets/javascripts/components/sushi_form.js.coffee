@SushiForm = React.createClass
  getInitialState: ->
    name: ''
    endpoint: ''
    cust_id: ''
    req_id: ''
    report_start: ''
    report_end: ''
    password: ''
    user_id: ''
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.name && @state.endpoint && @state.req_id && @state.cust_id && @state.report_start && @state.report_end
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { sushi: @state }, (data) =>
      @props.handleNewSushi data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Name'
          name: 'name'
          value: @state.name
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Endpoint'
          name: 'endpoint'
          value: @state.endpoint
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Customer ID'
          name: 'cust_id'
          value: @state.cust_id
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Requestor ID'
          name: 'req_id'
          value: @state.req_id
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Report Start'
          name: 'report_start'
          value: @state.report_start
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Report End'
          name: 'report_end'
          value: @state.report_end
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Password'
          name: 'password'
          value: @state.password
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'User ID'
          name: 'user_id'
          value: @state.user_id
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create Sushi Connection'
