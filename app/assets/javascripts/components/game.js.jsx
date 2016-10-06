var Game = React.createClass({

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
        {this.props.game.map(function(game){
          return(
            <h2 className="text-center" key={game.id}><a href={"/games/" + game.id}> {game.name} </a></h2>
            )
        })}

        <Game games={this.state.games} />

        <GameForm parentGameSubmit={this.parentGameSubmit}/>
        </div>
      );
    }
});