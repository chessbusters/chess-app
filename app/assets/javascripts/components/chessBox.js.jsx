var ChessBox = React.createClass ({

  getInitialState: function(){
    return {
      games: this.props.game,
      piece: this.props.piece,
      board: this.props.board
    }
  },

  render () {
      return (
        <div>
        <h1> your game</h1>
        
        <Chessboard board={this.state.board} />
        </div>
      );
    }
});