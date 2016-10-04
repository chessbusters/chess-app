 class GamesList extends React.Component {
    render () {
      return (
        <div>
        <h1> All the games </h1>
        <h1>{this.props.game.name} </h1>
        <h2>{this.props.game.created_at}</h2>
      </div>
      )
    }
}

// <h2 class="text-center">
//       <% if game.white_user_id && game.black_user_id %>
//         <%="Player #{game.white_user_id} vs Player #{game.black_user_id}" %>
//        <% elsif game.white_user_id && game.black_user_id == nil %>
//        <%= link_to "Game: #{game.name}", game_path(game) %>
//        <b> Waiting for an opponent </b>
//         <% end %>
//     </h2>
// <% end %>