var Game = React.createClass({

 renderProjectRows: function(){
    return(
      this.props.games.map(function(game){
        return(
          <div className="row" style={{marginTop: "20px"}} key={game.id}>

            <div className="col-sm-2">
              <h2 className="text-center" key={game.id}><a href={"/games/" + game.id}> {game.name} </a></h2>
            </div>

          </div>
        )
      })
    );
  },

  render: function() {
    return(
      <div>

        <div className="row" style={{marginTop: "50px"}}>

          <div className="col-sm-2">
          </div>

          <div className="col-sm-2" style={{fontWeight: "bold"}}>
            Name
          </div>

        </div>

        {this.renderProjectRows()}

      </div>
    );
  }

});