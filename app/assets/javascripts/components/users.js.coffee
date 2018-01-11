@Users = React.createClass
  getInitialState: ->
    users: @props.data
  getDefaultProps: ->
    users: []
  updateUser: (user, data) ->
    index = @state.users.indexOf user
    users = React.addons.update(@state.users, {$splice: [[index, 1, data]] })
    @replaceState users: users
  render: ->
    React.DOM.div
      className: "users"
      React.DOM.h2
        className: "title"
        'User Profile'
    React.DOM.table
      className: "table table-bordered"
      React.DOM.thead null,
        React.DOM.tr null,
          React.DOM.th null, 'Name'
          React.DOM.th null, 'Organization'
          React.DOM.th null, 'Actions'
      React.DOM.tbody null,
        for user in @state.users
          React.createElement User, key: user.id, user: user, handleEditUser: @updateUser
