 var GamesBox = React.createClass ({

  getInitialState: function(){
    return {
      games: this.props.game,
    }
  },

  parentGameSubmit (formData){

    $.ajax({
      url: "/games",
      dataType: 'json',
      type: 'POST',
      data: formData,

      success: function(games) {

        this.setState({games: games});

      }.bind(this),

      error: function(response, status, err) {

        console.log(this.props.url, status, err.toString())
      }.bind(this)


    });
  },

    render () {
      return (
        <div>
        <h1> Hey everyone </h1>
        
        <Game games={this.state.games} />

        <GameForm parentGameSubmit={this.parentGameSubmit}/>
        </div>
      );
    }
});

// <h2 class="text-center">
//       <% if game.white_user_id && game.black_user_id %>
//         <%="Player #{game.white_user_id} vs Player #{game.black_user_id}" %>
//        <% elsif game.white_user_id && game.black_user_id == nil %>
//        <%= link_to "Game: #{game.name}", game_path(game) %>
//        <b> Waiting for an opponent </b>
//         <% end %>
//     </h2>
// <% end %>